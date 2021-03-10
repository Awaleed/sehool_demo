import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../helpers/helper.dart';
import '../../models/address_model.dart';
import '../../repositories/user_repository.dart';

part 'address_cubit.freezed.dart';
part 'address_state.dart';

@injectable
class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this._userRepository) : super(const AddressState.initial());

  final IUserRepository _userRepository;

  Map<String, dynamic> _data;

  Future<void> getAddresses() async {
    emit(const AddressState.loading());
    try {
      final value = await _userRepository.getAddresses();
      emit(AddressState.success(value));
    } catch (e) {
      emit(AddressState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  void retryAddAddress() => addAddress(_data);

  Future<void> addAddress(Map<String, dynamic> data) async {
    _data = data;
    emit(const AddressState.loading());
    try {
      final value = await _userRepository.addAddress(data);
      emit(const AddressState.created());
      emit(AddressState.success(value));
    } catch (e) {
      emit(AddressState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  Future<void> deleteAddress(int id) async {
    emit(const AddressState.loading());
    try {
      final value = await _userRepository.deleteAddress(id);
      emit(AddressState.success(value));
    } catch (e) {
      emit(AddressState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  Future<void> updateAddress(AddressModel model) async {
    emit(const AddressState.loading());
    try {
      final value = await _userRepository.updateAddress(model);
      emit(AddressState.success(value));
    } catch (e) {
      emit(AddressState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }
}
