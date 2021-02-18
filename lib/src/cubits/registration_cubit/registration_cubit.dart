import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../init_injectable.dart';
import '../../helpers/helper.dart';
import '../../repositories/auth_repository.dart';
import '../auth_cubit/auth_cubit.dart';

part 'registration_cubit.freezed.dart';
part 'registration_state.dart';

@injectable
class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this._authRepository) : super(const RegistrationState.initial());

  final IAuthRepository _authRepository;

  Future<void> registration(FormData credentials) async {
    emit(const RegistrationState.loading());
    try {
      await _authRepository.register(credentials);
      emit(const RegistrationState.success());
      getIt<AuthCubit>().authenticateUser();
    } catch (e) {
      emit(RegistrationState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }
}
