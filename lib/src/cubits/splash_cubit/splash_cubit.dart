import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/user_datasource.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/settings_repository.dart';

enum SplashState {
  initial,
  firstLaunch,
  authenticated,
  unauthenticated,
}

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._settingsRepository, this._authRepository)
      : super(SplashState.initial) {
    _startLoading();
  }

  final ISettingsRepository _settingsRepository;
  final IAuthRepository _authRepository;

  Future<void> _startLoading() async {
    await _checkIfFirstLaunch();
    await _checkIfAuthenticated();
  }

  Future<void> _checkIfFirstLaunch() async {
    final settings = _settingsRepository.getSettings();
    if (settings.isFirstLaunch) {
      settings.isFirstLaunch = false;
      _settingsRepository.saveSettings(settings);
      emit(SplashState.firstLaunch);
    }
  }

  Future<void> _checkIfAuthenticated() async {
    try {
      if (kUser != null) {
        await _authRepository.me();
        emit(SplashState.authenticated);
      } else {
        emit(SplashState.unauthenticated);
      }
    } catch (e) {
      emit(SplashState.unauthenticated);
    }
  }
}
