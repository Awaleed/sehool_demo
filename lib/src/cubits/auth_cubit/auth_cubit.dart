import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/auth_repository.dart';

enum AuthState {
  authenticated,
  unauthenticated,
}

@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthState.unauthenticated);
  final IAuthRepository _authRepository;

  void authenticateUser() {
    emit(AuthState.authenticated);
  }

  Future<void> unauthenticateUser() async {
    emit(AuthState.unauthenticated);
    await _authRepository.logout();
  }
}
