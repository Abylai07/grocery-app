# Contributing to Grocery App

First off, thank you for considering contributing to Grocery App! It's people like you that make this showcase project even better.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Commit Message Guidelines](#commit-message-guidelines)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues as you might find that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples**
- **Describe the behavior you observed and what you expected**
- **Include screenshots if applicable**
- **Include your environment details** (OS, Flutter version, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use a clear and descriptive title**
- **Provide a detailed description of the proposed feature**
- **Explain why this enhancement would be useful**
- **List any similar features in other apps if applicable**

### Pull Requests

- Fill in the pull request template
- Follow the coding standards
- Include tests when adding new features
- Update documentation when needed
- End all files with a newline

## Development Setup

### Prerequisites

- Flutter SDK (>=3.3.4)
- Dart SDK (>=3.3.4)
- Git
- Your preferred IDE (Android Studio, VS Code, IntelliJ)

### Setup Steps

1. **Fork and Clone**
   ```bash
   git clone https://github.com/your-username/grocery_app.git
   cd grocery_app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Environment**
   ```bash
   cp lib/src/common/env_config.example.dart lib/src/common/env_config.dart
   # Edit env_config.dart with your keys
   ```

4. **Generate Code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the App**
   ```bash
   flutter run
   ```

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/domain/usecase/product_usecase_test.dart
```

### Code Generation

When modifying models or routes, regenerate code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Pull Request Process

1. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Your Changes**
   - Write clean, readable code
   - Follow the coding standards
   - Add tests for new functionality
   - Update documentation

3. **Test Your Changes**
   ```bash
   flutter test
   flutter analyze
   ```

4. **Commit Your Changes**
   ```bash
   git commit -m "feat: add amazing feature"
   ```

5. **Push to Your Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create Pull Request**
   - Use a clear title and description
   - Reference any related issues
   - Request review from maintainers

7. **Address Review Comments**
   - Make requested changes
   - Push updates to the same branch

## Coding Standards

### Dart Style Guide

Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide.

### Code Organization

```dart
// 1. Imports (sorted)
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:grocery_app/src/domain/entity/product_entity.dart';

// 2. Class definition
class ProductCard extends StatelessWidget {
  // 3. Fields
  final ProductEntity product;
  
  // 4. Constructor
  const ProductCard({Key? key, required this.product}) : super(key: key);
  
  // 5. Lifecycle methods
  @override
  Widget build(BuildContext context) {
    // ...
  }
  
  // 6. Public methods
  
  // 7. Private methods
}
```

### Naming Conventions

- **Classes**: PascalCase (`ProductCard`, `UserRepository`)
- **Variables**: camelCase (`userName`, `totalPrice`)
- **Constants**: lowerCamelCase (`defaultTimeout`, `maxRetries`)
- **Private**: prefix with `_` (`_privateMethod`, `_internalState`)
- **Files**: snake_case (`product_card.dart`, `user_repository.dart`)

### Clean Architecture Rules

1. **Domain Layer**
   - No Flutter imports
   - No external package dependencies (except dartz, equatable)
   - Pure business logic only

2. **Data Layer**
   - Implement repository interfaces from domain
   - Handle JSON serialization
   - Manage data sources

3. **Presentation Layer**
   - Use BLoC/Cubit for state management
   - Widgets should be stateless when possible
   - No business logic in widgets

### BLoC Best Practices

```dart
// Good: Cubit for simple state
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  
  void increment() => emit(state + 1);
}

// Good: BLoC for complex state with events
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }
  
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // ...
  }
}
```

### Testing

- Write unit tests for business logic
- Write widget tests for UI components
- Aim for >80% code coverage
- Use meaningful test descriptions

```dart
group('ProductUseCase', () {
  test('should return products when repository call succeeds', () async {
    // Arrange
    when(mockRepository.fetchProducts(any))
        .thenAnswer((_) async => Right(testProducts));
    
    // Act
    final result = await useCase(testParams);
    
    // Assert
    expect(result, Right(testProducts));
    verify(mockRepository.fetchProducts(testParams));
  });
});
```

## Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/) specification.

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples

```
feat(auth): add phone number authentication

Implement phone number + OTP authentication flow using Firebase.

Closes #123
```

```
fix(cart): resolve item duplication issue

Fixed bug where adding same item twice created duplicates
instead of incrementing quantity.

Fixes #456
```

```
docs(readme): update installation instructions

Added missing steps for Firebase setup.
```

## Project Structure Guidelines

When adding new features:

1. **Create entities in domain layer first**
2. **Define repository interfaces**
3. **Implement use cases**
4. **Create models in data layer**
5. **Implement data sources**
6. **Implement repositories**
7. **Create BLoC/Cubit in presentation**
8. **Build UI widgets**
9. **Write tests for each layer**
10. **Update documentation**

## Questions?

Feel free to open an issue with the label `question` if you need help or clarification.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Grocery App! 🎉
