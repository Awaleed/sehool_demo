import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepository) : super(const ProfileState.initial());

  final IUserRepository _userRepository;

  Future<void> updateProfileImage(String path) async {
    emit(const ProfileState.loading());
    try {
      final value = await _userRepository.updateProfileImage(path);
      emit(ProfileState.success(value));
    } catch (e) {
      addError(e);
      // TODO: Handel error messages
      emit(ProfileState.failure(message: '$e'));
    }
  }

  Future<void> changePassword(String password) async {
    emit(const ProfileState.loading());
    try {
      final value = await _userRepository.changePassword(password);
      emit(ProfileState.success(value));
    } catch (e) {
      addError(e);
      // TODO: Handel error messages
      emit(ProfileState.failure(message: '$e'));
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    emit(const ProfileState.loading());
    try {
      final value = await _userRepository.updateProfile(data);
      emit(ProfileState.success(value));
    } catch (e) {
      addError(e);
      // TODO: Handel error messages
      emit(ProfileState.failure(message: '$e'));
    }
  }
}
