# 🏗️ Architecture Guide

This document provides an in-depth look at the architecture of the Grocery App, explaining the design decisions, patterns, and principles used throughout the project.

## Table of Contents

1. [Overview](#overview)
2. [Clean Architecture Layers](#clean-architecture-layers)
3. [Data Flow](#data-flow)
4. [State Management](#state-management)
5. [Dependency Injection](#dependency-injection)
6. [Routing](#routing)
7. [Error Handling](#error-handling)
8. [Design Patterns](#design-patterns)
9. [Testing Strategy](#testing-strategy)

## Overview

This project implements **Clean Architecture** as proposed by Robert C. Martin (Uncle Bob), adapted for Flutter development. The core principle is the **Dependency Rule**: source code dependencies can only point inwards, toward higher-level policies.

```
┌───────────────────────────────────────────────────────┐
│                   Presentation                         │
│  ┌──────────────────────────────────────────────┐    │
│  │              Domain                           │    │
│  │  ┌────────────────────────────────────────┐  │    │
│  │  │            Data                         │  │    │
│  │  │  ┌──────────────────────────────────┐  │  │    │
│  │  │  │      External (APIs, DBs)        │  │  │    │
│  │  │  └──────────────────────────────────┘  │  │    │
│  │  └────────────────────────────────────────┘  │    │
│  └──────────────────────────────────────────────┘    │
└───────────────────────────────────────────────────────┘

Dependencies flow inward →
```

### Benefits

- **Independent of Frameworks**: Business logic doesn't depend on Flutter
- **Testable**: Business logic can be tested without UI, Database, or external services
- **Independent of UI**: UI can change without affecting business logic
- **Independent of Database**: Can swap Hive for SQLite without affecting business rules
- **Independent of External Services**: Business logic doesn't know about the outside world

## Clean Architecture Layers

### 1. Domain Layer (`lib/src/domain/`)

The **innermost layer** containing business logic and rules. This layer has NO dependencies on other layers.

#### Components:

**Entities** (`domain/entity/`)
- Pure Dart objects representing business models
- Contain business logic that is application-independent
- No dependencies on Flutter or external packages

```dart
class ProductEntity extends Equatable {
  final int id;
  final String name;
  final double price;
  final String? imageUrl;
  
  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
  });
  
  @override
  List<Object?> get props => [id, name, price, imageUrl];
}
```

**Repository Interfaces** (`domain/repository/`)
- Abstract classes defining contracts for data operations
- Domain layer defines what it needs, data layer implements it

```dart
abstract class AbstractProductServiceRepository {
  Future<Either<Failure, PaginationEntity>> fetchProducts(MapParams? params);
  Future<Either<Failure, ProductEntity>> fetchProductById(int id);
  Future<Either<Failure, List<CategoryEntity>>> fetchCategories();
}
```

**Use Cases** (`domain/usecase/`)
- Encapsulate business logic operations
- Each use case performs ONE specific action
- Orchestrate data flow between layers

```dart
class ProductUseCase {
  final AbstractProductServiceRepository repository;
  
  ProductUseCase(this.repository);
  
  Future<Either<Failure, PaginationEntity>> call(MapParams? params) {
    return repository.fetchProducts(params);
  }
}
```

### 2. Data Layer (`lib/src/data/`)

Implements repository interfaces and handles data operations.

#### Components:

**Models** (`data/models/`)
- Data Transfer Objects (DTOs)
- JSON serialization/deserialization
- Conversion to/from Domain entities

```dart
class ProductModel extends ProductEntity {
  const ProductModel({
    required int id,
    required String name,
    required double price,
    String? imageUrl,
  }) : super(id: id, name: name, price: price, imageUrl: imageUrl);
  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image_url': imageUrl,
    };
  }
}
```

**Data Sources** (`data/datasources/`)
- Abstract interfaces and implementations
- Handle API calls, database operations
- One source for remote (API), one for local (cache)

```dart
abstract class ProductRemoteDataSource {
  Future<PaginationEntity> fetchProducts(MapParams? params);
  Future<ProductModel> fetchProductById(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final API api;
  
  ProductRemoteDataSourceImpl(this.api);
  
  @override
  Future<PaginationEntity> fetchProducts(MapParams? params) async {
    try {
      final response = await api.dio.get('/products', queryParameters: params);
      return PaginationModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(messageError: e.message);
    }
  }
}
```

**Repository Implementations** (`data/repository/`)
- Implement domain repository interfaces
- Coordinate between remote and local data sources
- Handle caching strategies

```dart
class ProductServiceRepositoryImpl implements AbstractProductServiceRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  
  ProductServiceRepositoryImpl(this.remoteDataSource, this.networkInfo);
  
  @override
  Future<Either<Failure, PaginationEntity>> fetchProducts(MapParams? params) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.fetchProducts(params);
        return Right(products);
      } on ServerException catch (e) {
        return Left(ServerFailure(messageFailure: e.messageError));
      }
    } else {
      return Left(CacheFailure(messageFailure: 'No internet connection'));
    }
  }
}
```

### 3. Presentation Layer (`lib/src/presentation/`)

Handles UI and user interaction.

#### Components:

**BLoC/Cubit** (`presentation/bloc/`, `presentation/view/*/bloc/`)
- Manage UI state
- React to events from UI
- Call use cases from domain layer
- Emit new states

```dart
class SearchProductCubit extends Cubit<BaseState> {
  final ProductUseCase productUseCase;
  
  SearchProductCubit(this.productUseCase) : super(const BaseState());
  
  Future<void> searchProducts(String query) async {
    emit(const BaseState(status: CubitStatus.loading));
    
    final result = await productUseCase({'search': query});
    
    result.fold(
      (failure) => emit(BaseState(
        status: CubitStatus.error,
        message: failure.messageFailure,
      )),
      (products) => emit(BaseState(
        status: CubitStatus.success,
        entity: products,
      )),
    );
  }
}
```

**Screens** (`presentation/view/*/screens/`)
- UI pages
- Listen to BLoC state
- Dispatch events to BLoC

**Widgets** (`presentation/view/*/widgets/`, `presentation/widgets/`)
- Reusable UI components
- Stateless when possible
- Feature-specific or shared

## Data Flow

### Request Flow (User Action → API)

```
User Interaction
      ↓
   Widget
      ↓
BLoC Event Dispatch
      ↓
   BLoC/Cubit
      ↓
  Use Case
      ↓
Repository Interface (Domain)
      ↓
Repository Implementation (Data)
      ↓
 Remote Data Source
      ↓
    API Call
```

### Response Flow (API → UI)

```
   API Response
      ↓
Remote Data Source
      ↓
    Model
      ↓
   Entity
      ↓
 Repository
      ↓
  Use Case
      ↓
   BLoC/Cubit
      ↓
 State Emission
      ↓
   Widget Rebuild
```

### Example: Fetching Products

```dart
// 1. User taps category in UI
onTap: () => context.read<SearchProductCubit>().fetchProductsByCategory(categoryId)

// 2. BLoC receives event and calls use case
class SearchProductCubit {
  Future<void> fetchProductsByCategory(int categoryId) async {
    emit(const BaseState(status: CubitStatus.loading));
    final result = await productUseCase({'category_id': categoryId});
    // ...
  }
}

// 3. Use case calls repository
class ProductUseCase {
  Future<Either<Failure, PaginationEntity>> call(MapParams params) {
    return repository.fetchProducts(params);
  }
}

// 4. Repository calls data source
class ProductServiceRepositoryImpl {
  Future<Either<Failure, PaginationEntity>> fetchProducts(MapParams params) async {
    final products = await remoteDataSource.fetchProducts(params);
    return Right(products);
  }
}

// 5. Data source makes API call
class ProductRemoteDataSourceImpl {
  Future<PaginationEntity> fetchProducts(MapParams params) async {
    final response = await api.dio.get('/products', queryParameters: params);
    return PaginationModel.fromJson(response.data);
  }
}

// 6. Response flows back through layers
// 7. BLoC emits new state
// 8. Widget rebuilds with new data
```

## State Management

### BLoC Pattern

This project uses the **BLoC (Business Logic Component)** pattern via `flutter_bloc`.

**Why BLoC?**
- Separates business logic from UI
- Predictable state management
- Easy to test
- Stream-based reactive programming

### BLoC vs Cubit

**BLoC** (Event-State pattern):
```dart
class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(NavBarState(isVisible: false)) {
    on<ShowNavBar>((event, emit) => emit(NavBarState(isVisible: true)));
    on<HideNavBar>((event, emit) => emit(NavBarState(isVisible: false)));
  }
}

// Usage
context.read<NavBarBloc>().add(ShowNavBar());
```

**Cubit** (Function-based):
```dart
class BannerCubit extends Cubit<BaseState> {
  BannerCubit(this.bannerUseCase) : super(const BaseState());
  
  Future<void> fetchBanners() async {
    emit(const BaseState(status: CubitStatus.loading));
    // ...
  }
}

// Usage
context.read<BannerCubit>().fetchBanners();
```

**When to use each:**
- **BLoC**: Complex state with multiple events affecting same state
- **Cubit**: Simpler state changes with direct function calls

### Global vs Local BLoCs

**Global BLoCs** (in `MultiBlocProvider` at app root):
- User session
- Navigation bar
- App settings
- Shared across multiple screens

**Local BLoCs** (provided at feature level):
- Screen-specific state
- Created when screen opens, disposed when closes

## Dependency Injection

Uses **GetIt** as a service locator for dependency injection.

### Setup (`lib/src/get_it_sl.dart`)

```dart
final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  
  // Use Cases
  sl.registerLazySingleton(() => ProductUseCase(sl()));
  
  // Repositories
  sl.registerLazySingleton<AbstractProductServiceRepository>(
    () => ProductServiceRepositoryImpl(sl(), sl()),
  );
  
  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );
  
  // BLoCs (Factory - new instance each time)
  sl.registerFactory(() => SearchProductCubit(sl()));
  
  // External
  sl.registerLazySingleton(() => API());
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
}
```

### Registration Types

- `registerLazySingleton`: Created once when first requested
- `registerFactory`: New instance each time
- `registerSingleton`: Created immediately

## Routing

Uses **AutoRoute** for type-safe declarative routing.

### Route Declaration

```dart
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: IndexRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeNestedRoute.page, children: [
          AutoRoute(page: HomeRoute.page, initial: true),
          AutoRoute(page: ProductRoute.page),
        ]),
        AutoRoute(page: BasketRoute.page),
      ],
    ),
    AutoRoute(page: SignInRoute.page),
  ];
}
```

### Navigation

```dart
// Push
context.router.push(ProductRoute(productId: 123));

// Replace
context.router.replace(HomeRoute());

// Pop
context.router.pop();

// Navigate with result
final result = await context.router.push(AddressRoute());
```

## Error Handling

### Functional Error Handling with dartz

Uses `Either<Failure, Success>` for explicit error handling.

```dart
// Left = Error, Right = Success
Future<Either<Failure, ProductEntity>> fetchProduct(int id) async {
  try {
    final product = await dataSource.fetchProduct(id);
    return Right(product);
  } on ServerException catch (e) {
    return Left(ServerFailure(messageFailure: e.messageError));
  }
}

// Usage
final result = await productUseCase.fetchProduct(123);

result.fold(
  (failure) => showError(failure.messageFailure),
  (product) => displayProduct(product),
);
```

### Exception Hierarchy

```
Exception
├── ServerException    (HTTP 500+)
├── CacheException     (HTTP 400-499)
└── NetworkException   (No internet)

Failure
├── ServerFailure
├── CacheFailure
└── NetworkFailure
```

## Design Patterns

### Repository Pattern
Abstracts data sources from business logic.

### Use Case Pattern
Each use case encapsulates one business action.

### Singleton Pattern
Services like API client, database.

### Factory Pattern
BLoCs created via GetIt factories.

### Observer Pattern
BLoC pattern implements observer via streams.

### Adapter Pattern
Models adapt JSON to Entities.

## Testing Strategy

### Unit Tests
```dart
test('should return product when API call is successful', () async {
  // Arrange
  when(mockDataSource.fetchProduct(1))
      .thenAnswer((_) async => testProduct);
  
  // Act
  final result = await repository.fetchProduct(1);
  
  // Assert
  expect(result, Right(testProduct));
});
```

### Widget Tests
```dart
testWidgets('should display product name', (tester) async {
  await tester.pumpWidget(ProductCard(product: testProduct));
  expect(find.text('Test Product'), findsOneWidget);
});
```

### BLoC Tests
```dart
blocTest<SearchProductCubit, BaseState>(
  'emits [loading, success] when search succeeds',
  build: () => SearchProductCubit(mockUseCase),
  act: (cubit) => cubit.searchProducts('apple'),
  expect: () => [
    BaseState(status: CubitStatus.loading),
    BaseState(status: CubitStatus.success, entity: testProducts),
  ],
);
```

## Best Practices

1. **Keep Domain Pure** - No Flutter imports in domain layer
2. **Single Responsibility** - Each class does one thing
3. **Dependency Inversion** - Depend on abstractions, not concretions
4. **Immutable State** - Use Equatable for value equality
5. **Error Handling** - Always handle failures explicitly
6. **Testing** - Write tests for business logic
7. **Code Generation** - Use build_runner for boilerplate
8. **Documentation** - Document complex logic

## Resources

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Library](https://bloclibrary.dev/)
- [Reso Coder's Clean Architecture Tutorial](https://resocoder.com/flutter-clean-architecture-tdd/)

---

**Last Updated**: 2025
**Maintainer**: [Your Name]
