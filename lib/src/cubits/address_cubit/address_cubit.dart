import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/address_model.dart';
import '../../repositories/user_repository.dart';

part 'address_cubit.freezed.dart';
part 'address_state.dart';

@injectable
class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this._userRepository) : super(const AddressState.initial());

  final IUserRepository _userRepository;

  Future<void> addAddress(AddressModel model) async {
    emit(const AddressState.loading());
    try {
      final value = await _userRepository.addAddress(model);
      emit(AddressState.success(value));
    } catch (e) {
      // TODO: Handel error messages
      emit(AddressState.failure(message: '$e'));
    }
  }

  Future<void> deleteAddress(int id) async {
    emit(const AddressState.loading());
    try {
      final value = await _userRepository.deleteAddress(id);
      emit(AddressState.success(value));
    } catch (e) {
      // TODO: Handel error messages
      emit(AddressState.failure(message: '$e'));
    }
  }

  Future<void> updateAddress(AddressModel model) async {
    emit(const AddressState.loading());
    try {
      final value = await _userRepository.updateAddress(model);
      emit(AddressState.success(value));
    } catch (e) {
      // TODO: Handel error messages
      emit(AddressState.failure(message: '$e'));
    }
  }
}
