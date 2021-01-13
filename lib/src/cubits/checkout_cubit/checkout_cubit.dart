import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/checkout_model.dart';
import '../../models/order_model.dart';
import '../../repositories/order_repository.dart';

part 'checkout_cubit.freezed.dart';
part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this._orderRepository) : super(const CheckoutState.initial());

  final IOrderRepository _orderRepository;

  Future<void> placeOrder(CheckoutModel model) async {
    emit(const CheckoutState.loading());
    try {
      final value = await _orderRepository.placeOrder(model);
      emit(CheckoutState.success(value));
    } catch (e) {
      // TODO: Handel error messages
      emit(CheckoutState.failure(message: '$e'));
    }
  }
}
