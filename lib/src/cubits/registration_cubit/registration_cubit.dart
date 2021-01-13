import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../init_injectable.dart';
import '../../models/form_data_model.dart';
import '../../repositories/auth_repository.dart';
import '../auth_cubit/auth_cubit.dart';

part 'registration_cubit.freezed.dart';
part 'registration_state.dart';

@injectable
class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this._authRepository)
      : super(const RegistrationState.initial());

  final IAuthRepository _authRepository;

  Future<void> registration(
      Map<FormFieldType, FormFieldModel> credentials) async {
    emit(const RegistrationState.loading());
    try {
      await _authRepository.register(credentials);
      emit(const RegistrationState.success());
      getIt<AuthCubit>().authenticateUser();
        } catch (e) {
      addError(e);
      // TODO: Handel error messages
      emit(RegistrationState.failure(message: '$e'));
    }
  }
}
