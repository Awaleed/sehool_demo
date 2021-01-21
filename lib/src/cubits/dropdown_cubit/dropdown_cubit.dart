import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../helpers/helper.dart';
import '../../models/dropdown_value_model.dart';
import '../../repositories/dropdown_repository.dart';

part 'dropdown_cubit.freezed.dart';
part 'dropdown_state.dart';

@injectable
class DropdownCubit extends Cubit<DropdownState> {
  DropdownCubit(this._dropdownRepository)
      : super(const DropdownState.initial());

  final IDropdownRepository _dropdownRepository;

  Future<void> getDropdownValues(DropdownValueType type) async {
    emit(const DropdownState.loading());
    try {
      final values = await _dropdownRepository.getDropdownValues(type);
      emit(DropdownState.success(values));
    } catch (e) {
      emit(DropdownState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  Future<void> setDropdownValues(List values) async {
    emit(const DropdownState.loading());
    emit(DropdownState.success(values));
  }
}
