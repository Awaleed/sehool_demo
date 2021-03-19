import 'dart:async';

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../../init_injectable.dart';
import '../../../components/my_error_widget.dart';
import '../../../components/orders_list/orders_list_sliver.dart';
import '../../../cubits/order_cubit/order_cubit.dart';

class OrdersHistory extends StatefulWidget {
  static const routeName = '/myOrdersHistory';

  const OrdersHistory({Key key}) : super(key: key);

  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  OrderCubit cubit;
  Timer timer;

  @override
  void initState() {
    super.initState();
    cubit = getIt<OrderCubit>();
    timer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) => cubit.refreshOrders(),
    );
  }

  @override
  void dispose() {
    cubit.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderCubit, OrderState>(
        cubit: cubit,
        builder: (context, state) {
          return state.when(
            canceled: () => _buildUI([], isLoading: true),
            loading: () => _buildUI([], isLoading: true),
            success: (values) => _buildUI(values),
            failure: (message) => MyErrorWidget(
              onRetry: () => cubit.getOrders(),
              message: message,
            ),
          );
        },
      ),
    );
  }

  Widget _buildUI(List values, {isLoading = false}) {
    return RefreshIndicator(
      onRefresh: cubit.getOrders,
      child: Parent(
        style: ParentStyle()
          ..background.color(Colors.white)
          ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
        child: Scaffold(
          backgroundColor: Colors.white70,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black54,
            title: Text(
              S.current.my_orders,
              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
            ),
          ),
          body: OrdersListWidget(
            isLoading: isLoading,
            orders: values.reversed.toList(),
          ),
        ),
      ),
    );
  }
}
