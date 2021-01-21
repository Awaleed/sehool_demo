import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../helpers/helper.dart';
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
      emit(ProfileState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    emit(const ProfileState.loading());
    try {
      final value = await _userRepository.updateProfile(data);
      emit(ProfileState.success(value));
    } catch (e) {
      emit(ProfileState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  void reset() => emit(const ProfileState.initial());
}
