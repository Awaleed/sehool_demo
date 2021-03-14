import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../helpers/helper.dart';
import '../../models/order_model.dart';
import '../../repositories/order_repository.dart';

part 'order_cubit.freezed.dart';
part 'order_state.dart';

@injectable
class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._productRepository) : super(const OrderState.loading()) {
    getOrders();
  }

  final IOrderRepository _productRepository;

  Future<void> getOrders() async {
    emit(const OrderState.loading());
    try {
      final value = await _productRepository.getOrders();
      value.removeWhere((element) => element.status == null);
      emit(OrderState.success(value));
    } catch (e) {
      emit(OrderState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  Future<void> refreshOrders() async {
    try {
      final value = await _productRepository.getOrders();
      value.removeWhere((element) => element.status == null);
      emit(OrderState.success(value));
    } catch (e) {
      emit(OrderState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  Future<void> cancelOrder(
    int orderId,
    String reason,
  ) async {
    emit(const OrderState.loading());
    try {
      await _productRepository.cancelOrder(
        orderId: orderId,
        reason: reason,
      );
      emit(const OrderState.canceled());
    } catch (e) {
      emit(OrderState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }
}
