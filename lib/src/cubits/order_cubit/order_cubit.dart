import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../models/order_model.dart';

import '../../repositories/order_repository.dart';

part 'order_cubit.freezed.dart';
part 'order_state.dart';

@injectable
class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._productRepository) : super(const OrderState.initial());

  final IOrderRepository _productRepository;

  Future<void> getOrder(int id) async {
    emit(const OrderState.loading());
    try {
      final value = await _productRepository.getOrder(id);
      emit(OrderState.success(value));
    } catch (e) {
      // TODO: Handel error messages
      emit(OrderState.failure(message: '$e'));
    }
  }

  Future<void> cancelOrder(
    int orderId,
    String reason,
  ) async {
    emit(const OrderState.loading());
    try {
      final value = await _productRepository.cancelOrder(
        orderId: orderId,
        reason: reason,
      );
      emit(OrderState.success(value));
    } catch (e) {
      // TODO: Handel error messages
      emit(OrderState.failure(message: '$e'));
    }
  }
}
