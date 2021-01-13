// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'src/cubits/address_cubit/address_cubit.dart';
import 'src/cubits/auth_cubit/auth_cubit.dart';
import 'src/cubits/cart_cubit/cart_cubit.dart';
import 'src/cubits/checkout_cubit/checkout_cubit.dart';
import 'src/cubits/dropdown_cubit/dropdown_cubit.dart';
import 'src/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'src/repositories/auth_repository.dart';
import 'src/data/dropdown_datasource.dart';
import 'src/repositories/dropdown_repository.dart';
import 'src/data/lazy_list_datasource.dart';
import 'src/repositories/lazy_list_repository.dart';
import 'src/data/order_datasource.dart';
import 'src/repositories/order_repository.dart';
import 'src/data/product_datasource.dart';
import 'src/repositories/product_repository.dart';
import 'src/data/settings_datasource.dart';
import 'src/repositories/settings_repository.dart';
import 'src/data/user_datasource.dart';
import 'src/repositories/user_repository.dart';
import 'src/cubits/lazy_list_cubit/lazy_list_cubit.dart';
import 'src/cubits/login_cubit/login_cubit.dart';
import 'src/cubits/order_cubit/order_cubit.dart';
import 'src/cubits/product_cubit/product_cubit.dart';
import 'src/cubits/profile_cubit/profile_cubit.dart';
import 'src/cubits/registration_cubit/registration_cubit.dart';
import 'src/cubits/reveiw_cubit/review_cubit.dart';
import 'src/cubits/settings_cubit/settings_cubit.dart';
import 'src/cubits/splash_cubit/splash_cubit.dart';

/// Environment names
const _prod = 'prod';
const _test = 'test';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<LazyListCubit>(() => LazyListCubit(get<ILazyListRepository>()));
  gh.factory<OrderCubit>(() => OrderCubit(get<IOrderRepository>()));
  gh.factory<ProductCubit>(() => ProductCubit(get<IProductRepository>()));
  gh.factory<ProfileCubit>(() => ProfileCubit(get<IUserRepository>()));
  gh.factory<ReviewCubit>(() => ReviewCubit(get<IProductRepository>()));
  gh.factory<AddressCubit>(() => AddressCubit(get<IUserRepository>()));
  gh.factory<CheckoutCubit>(() => CheckoutCubit(get<IOrderRepository>()));
  gh.factory<DropdownCubit>(() => DropdownCubit(get<IDropdownRepository>()));
  gh.factory<LoginCubit>(() => LoginCubit(get<IAuthRepository>()));
  gh.factory<RegistrationCubit>(
      () => RegistrationCubit(get<IAuthRepository>()));
  gh.factory<SplashCubit>(() => SplashCubit(
        get<ISettingsRepository>(),
        get<IAuthRepository>(),
        get<IUserRepository>(),
      ));
  gh.factory<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(get<IAuthRepository>()));

  // Eager singletons must be registered in the right order
  gh.singleton<CartCubit>(CartCubit());
  gh.singleton<IDropdownRemoteDataSource>(DropdownRemoteDataSource(),
      registerFor: {_prod});
  gh.singleton<IDropdownRemoteDataSource>(FakeDropdownRemoteDataSource(),
      registerFor: {_test});
  gh.singleton<IDropdownRepository>(
      DropdownRepositoryImpl(get<IDropdownRemoteDataSource>()));
  gh.singleton<ILazyListRemoteDataSource>(LazyListRemoteDataSource());
  gh.singleton<ILazyListRepository>(
      LazyListRepositoryImpl(get<ILazyListRemoteDataSource>()));
  gh.singleton<IOrderRemoteDataSource>(OrderRemoteDataSource());
  gh.singleton<IOrderRepository>(
      OrderRepositoryImpl(get<IOrderRemoteDataSource>()));
  gh.singleton<IProductRemoteDataSource>(ProductRemoteDataSource());
  gh.singleton<IProductRepository>(
      ProductRepositoryImpl(get<IProductRemoteDataSource>()));
  gh.singleton<ISettingsDataSource>(SettingsLocalDataSource());
  gh.singleton<ISettingsRepository>(
      SettingsRepositoryImpl(get<ISettingsDataSource>()));
  gh.singleton<IUserLocalDataSource>(UserLocalDataSource());
  gh.singleton<IUserRemoteDataSource>(UserRemoteDataSource(),
      registerFor: {_prod});
  gh.singleton<IUserRemoteDataSource>(FakeUserRemoteDataSource(),
      registerFor: {_test});
  gh.singleton<IUserRepository>(UserRepositoryImpl(
      get<IUserLocalDataSource>(), get<IUserRemoteDataSource>()));
  gh.singleton<SettingsCubit>(SettingsCubit(get<ISettingsRepository>()));
  gh.singleton<IAuthRepository>(AuthRepositoryImpl(
      get<IUserLocalDataSource>(), get<IUserRemoteDataSource>()));
  gh.singleton<AuthCubit>(AuthCubit(get<IAuthRepository>()));
  return get;
}
