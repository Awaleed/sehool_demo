import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sehool/src/repositories/auth_repository.dart';

import '../../../init_injectable.dart';
import '../../core/api_caller.dart';
import '../../helpers/helper.dart';
import '../../models/cart_model.dart';

part 'checkout_cubit.freezed.dart';
part 'checkout_state.dart';

enum PaymentStatus { success, failure }

@injectable
class CheckoutCubit extends Cubit<CheckoutState> with ApiCaller {
  CheckoutCubit() : super(const CheckoutState.initial());

  Future<void> placeOrder(CartModel cart) async {
    emit(const CheckoutState.loading());
    try {
      final res = await post(path: '/shoppingCart', data: cart.toJson());
      if (cart.paymentMethod.type == 'visa') {
        final url = res['url'];
        final orderId = res['order_id'];
        if (url != null) {
          await getIt<IAuthRepository>().me();
          emit(CheckoutState.visaPayment(url, orderId));
        }
      } else {
        await getIt<IAuthRepository>().me();
        emit(const CheckoutState.success());
      }
    } catch (e) {
      emit(CheckoutState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  void orderSuccess() => emit(const CheckoutState.success());

  void orderFailure(String message) => emit(CheckoutState.failure(message: message));
}
