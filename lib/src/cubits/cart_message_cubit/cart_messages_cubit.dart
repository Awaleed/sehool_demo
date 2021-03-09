// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:injectable/injectable.dart';
// import '../../core/api_caller.dart';
// import '../../helpers/helper.dart';
// import '../../models/cart_model.dart';

// part 'cart_messages_state.dart';
// part 'cart_messages_cubit.freezed.dart';

// @injectable
// class CartMessagesCubit extends Cubit<CartMessagesState> with ApiCaller {
//   CartMessagesCubit() : super(const CartMessagesState.initial());

//   Future<void> getMessagesValues() async {
//     emit(const CartMessagesState.loading());
//     try {
//       final res = await get(path: '/congratulatory/phrases');
//       final value = CartMessageModel.fromJson(res);
//       emit(CartMessagesState.success(value));
//     } catch (e) {
//       emit(CartMessagesState.failure(message: Helpers.mapErrorToMessage(e)));
//       addError(e);
//     }
//   }
// }
