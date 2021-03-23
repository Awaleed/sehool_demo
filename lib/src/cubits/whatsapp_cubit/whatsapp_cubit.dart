import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/api_caller.dart';

enum WhatsappState { loading, success, failure }

@singleton
class WhatsappCubit extends Cubit<WhatsappState> with ApiCaller {
  WhatsappCubit() : super(WhatsappState.loading) {
    getNumber();
  }
  String number;
  Future<void> getNumber() async {
    emit(WhatsappState.loading);
    try {
      final value = await get(path: '/number/phone');
      print(value);
      number = value;
      emit(WhatsappState.success);
    } catch (e) {
      emit(WhatsappState.failure);
      addError(e);
    }
  }
}
