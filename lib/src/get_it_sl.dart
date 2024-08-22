import 'package:abricoz_app/src/data/datasources/user_remote_data_source.dart';
import 'package:abricoz_app/src/data/repository/product_service_repository.dart';
import 'package:abricoz_app/src/domain/repository/abstract_product_service_profile.dart';
import 'package:abricoz_app/src/domain/repository/abstract_user_service_profile.dart';
import 'package:abricoz_app/src/domain/usecase/order/check_basket_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/user/banner_use_case.dart';
import 'package:abricoz_app/src/domain/usecase/user/favorite_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:abricoz_app/src/platform/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/api.dart';
import 'core/check_error_type.dart';
import 'data/datasources/order_remote_data_source.dart';
import 'data/datasources/product_remote_data_source.dart';
import 'data/repository/order_service_repository.dart';
import 'data/repository/user_service_repository.dart';
import 'domain/repository/abstract_order_service_profile.dart';
import 'domain/usecase/order/delivery_time_usecase.dart';
import 'domain/usecase/order/order_usecase.dart';
import 'domain/usecase/product/category_usecase.dart';
import 'domain/usecase/product/product_usecase.dart';
import 'domain/usecase/user/address_usecase.dart';
import 'domain/usecase/user/city_usecase.dart';
import 'domain/usecase/user/district_usecase.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<NetworkOperationHelper>(() => NetworkOperationHelper(sl()));

  //BLoCs

 // sl.registerFactory(() => BookItemCubit(sl()));

  // UseCases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => CityUseCase(sl()));
  sl.registerLazySingleton(() => CategoryUseCase(sl()));
  sl.registerLazySingleton(() => ProductUseCase(sl()));
  sl.registerLazySingleton(() => BannerUseCase(sl()));
  sl.registerLazySingleton(() => CheckBasketUseCase(sl()));
  sl.registerLazySingleton(() => AddressUseCase(sl()));
  sl.registerLazySingleton(() => DistrictUseCase(sl()));
  sl.registerLazySingleton(() => DeliveryTimeUseCase(sl()));
  sl.registerLazySingleton(() => OrderUseCase(sl()));
  sl.registerLazySingleton(() => FavoriteUseCase(sl()));


 // Remote Repositories
  sl.registerLazySingleton<OrderRemoteDataSource>(
        () => OrderRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(sl()),
  );

 // Service Repositories
  sl.registerLazySingleton<AbstractOrderServiceRepository>(
        () => OrderServiceRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<AbstractUserServiceRepository>(
        () => UserServiceRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<AbstractProductServiceRepository>(
        () => ProductServiceRepositoryImpl(sl(), sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => API());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
