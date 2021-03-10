import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../core/api_caller.dart';
import '../../helpers/helper.dart';
import '../../models/association_model.dart';

part 'associations_cubit.freezed.dart';
part 'associations_state.dart';

@injectable
class AssociationsCubit extends Cubit<AssociationsState> with ApiCaller {
  AssociationsCubit() : super(const AssociationsState.initial());

  Future<void> getMessagesValues() async {
    emit(const AssociationsState.loading());
    try {
      final res = await get(path: '/association');
      res['discount'] = res['discount']['discount'];
      final value = AssociationModel.fromJson(res);
      emit(AssociationsState.success(value));
    } catch (e) {
      emit(AssociationsState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }
}
