// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'src/cubits/address_cubit/address_cubit.dart' as _i13;
import 'src/cubits/associations_cubit/associations_cubit.dart' as _i3;
import 'src/cubits/auth_cubit/auth_cubit.dart' as _i32;
import 'src/cubits/cart_cubit/cart_cubit.dart' as _i23;
import 'src/cubits/checkout_cubit/checkout_cubit.dart' as _i4;
import 'src/cubits/dropdown_cubit/dropdown_cubit.dart' as _i15;
import 'src/cubits/forgot_password_cubit/forgot_password_cubit.dart' as _i22;
import 'src/cubits/login_cubit/login_cubit.dart' as _i17;
import 'src/cubits/order_cubit/order_cubit.dart' as _i5;
import 'src/cubits/product_cubits/banner_cubit/banner_cubit.dart' as _i14;
import 'src/cubits/product_cubits/product_cubit/product_cubit.dart' as _i7;
import 'src/cubits/product_cubits/review_cubit/review_cubit.dart' as _i11;
import 'src/cubits/product_cubits/video_cubit/video_cubit.dart' as _i12;
import 'src/cubits/profile_cubit/profile_cubit.dart' as _i9;
import 'src/cubits/registration_cubit/registration_cubit.dart' as _i19;
import 'src/cubits/settings_cubit/settings_cubit.dart' as _i31;
import 'src/cubits/splash_cubit/splash_cubit.dart' as _i20;
import 'src/data/dropdown_datasource.dart' as _i24;
import 'src/data/lazy_list_datasource.dart' as _i25;
import 'src/data/order_datasource.dart' as _i27;
import 'src/data/product_datasource.dart' as _i28;
import 'src/data/settings_datasource.dart' as _i29;
import 'src/data/user_datasource.dart' as _i30;
import 'src/repositories/auth_repository.dart' as _i18;
import 'src/repositories/dropdown_repository.dart' as _i16;
import 'src/repositories/lazy_list_repository.dart' as _i26;
import 'src/repositories/order_repository.dart' as _i6;
import 'src/repositories/product_repository.dart' as _i8;
import 'src/repositories/settings_repository.dart' as _i21;
import 'src/repositories/user_repository.dart' as _i10;

const String _prod = 'prod';
const String _test = 'test';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AssociationsCubit>(() => _i3.AssociationsCubit());
  gh.factory<_i4.CheckoutCubit>(() => _i4.CheckoutCubit());
  gh.factory<_i5.OrderCubit>(() => _i5.OrderCubit(get<_i6.IOrderRepository>()));
  gh.factory<_i7.ProductCubit>(
      () => _i7.ProductCubit(get<_i8.IProductRepository>()));
  gh.factory<_i9.ProfileCubit>(
      () => _i9.ProfileCubit(get<_i10.IUserRepository>()));
  gh.factory<_i11.ReviewCubit>(
      () => _i11.ReviewCubit(get<_i8.IProductRepository>()));
  gh.factory<_i12.VideoCubit>(
      () => _i12.VideoCubit(get<_i8.IProductRepository>()));
  gh.factory<_i13.AddressCubit>(
      () => _i13.AddressCubit(get<_i10.IUserRepository>()));
  gh.factory<_i14.BannerCubit>(
      () => _i14.BannerCubit(get<_i8.IProductRepository>()));
  gh.factory<_i15.DropdownCubit>(
      () => _i15.DropdownCubit(get<_i16.IDropdownRepository>()));
  gh.factory<_i17.LoginCubit>(
      () => _i17.LoginCubit(get<_i18.IAuthRepository>()));
  gh.factory<_i19.RegistrationCubit>(
      () => _i19.RegistrationCubit(get<_i18.IAuthRepository>()));
  gh.factory<_i20.SplashCubit>(() => _i20.SplashCubit(
      get<_i21.ISettingsRepository>(), get<_i18.IAuthRepository>()));
  gh.factory<_i22.ForgotPasswordCubit>(
      () => _i22.ForgotPasswordCubit(get<_i18.IAuthRepository>()));
  gh.singleton<_i23.CartCubit>(_i23.CartCubit());
  gh.singleton<_i24.IDropdownRemoteDataSource>(_i24.DropdownRemoteDataSource(),
      registerFor: {_prod});
  gh.singleton<_i24.IDropdownRemoteDataSource>(
      _i24.FakeDropdownRemoteDataSource(),
      registerFor: {_test});
  gh.singleton<_i16.IDropdownRepository>(
      _i16.DropdownRepositoryImpl(get<_i24.IDropdownRemoteDataSource>()));
  gh.singleton<_i25.ILazyListRemoteDataSource>(
      _i25.FakeLazyListRemoteDataSource(),
      registerFor: {_test});
  gh.singleton<_i25.ILazyListRemoteDataSource>(_i25.LazyListRemoteDataSource(),
      registerFor: {_prod});
  gh.singleton<_i26.ILazyListRepository>(
      _i26.LazyListRepositoryImpl(get<_i25.ILazyListRemoteDataSource>()));
  gh.singleton<_i27.IOrderRemoteDataSource>(_i27.OrderRemoteDataSource());
  gh.singleton<_i6.IOrderRepository>(
      _i6.OrderRepositoryImpl(get<_i27.IOrderRemoteDataSource>()));
  gh.singleton<_i28.IProductRemoteDataSource>(
      _i28.FakeProductRemoteDataSource(),
      registerFor: {_test});
  gh.singleton<_i28.IProductRemoteDataSource>(_i28.ProductRemoteDataSource(),
      registerFor: {_prod});
  gh.singleton<_i8.IProductRepository>(
      _i8.ProductRepositoryImpl(get<_i28.IProductRemoteDataSource>()));
  gh.singleton<_i29.ISettingsDataSource>(_i29.SettingsLocalDataSource());
  gh.singleton<_i21.ISettingsRepository>(
      _i21.SettingsRepositoryImpl(get<_i29.ISettingsDataSource>()));
  gh.singleton<_i30.IUserLocalDataSource>(_i30.UserLocalDataSource());
  gh.singleton<_i30.IUserRemoteDataSource>(_i30.UserRemoteDataSource(),
      registerFor: {_prod});
  gh.singleton<_i30.IUserRemoteDataSource>(_i30.FakeUserRemoteDataSource(),
      registerFor: {_test});
  gh.singleton<_i10.IUserRepository>(_i10.UserRepositoryImpl(
      get<_i30.IUserLocalDataSource>(), get<_i30.IUserRemoteDataSource>()));
  gh.singleton<_i31.SettingsCubit>(
      _i31.SettingsCubit(get<_i21.ISettingsRepository>()));
  gh.singleton<_i18.IAuthRepository>(_i18.AuthRepositoryImpl(
      get<_i30.IUserLocalDataSource>(), get<_i30.IUserRemoteDataSource>()));
  gh.singleton<_i32.AuthCubit>(_i32.AuthCubit(get<_i18.IAuthRepository>()));
  return get;
}
