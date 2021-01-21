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

  @override
  void initState() {
    super.initState();
    cubit = getIt<OrderCubit>();
  }

  @override
  void dispose() {
    cubit.close();
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
              onRetry: () {
                cubit.getOrders();
              },
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
          ..background.image(path: 'assets/images/bg.jpg', fit: BoxFit.cover),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              S.current.my_orders,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
          ),
          body: OrdersListWidget(
            isLoading: isLoading,
            orders: values,
          ),
        ),
      ),
    );
  }

  // Widget _buildList() {
  //   return GridView.builder(
  //     gridDelegate:
  //         const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  //     itemBuilder: (context, index) {
  //       return const ProductsCarouselItemWidget(
  //         product: ProductModel(
  //             id: 0,
  //             name: 'pro',
  //             qyt: 2,
  //             price: 200,
  //             description: 'bla bla bla',
  //             image:
  //                 'https://cdn.britannica.com/96/197396-131-0096D43E/ribeye-steak-beef-cow-meat.jpg'),
  //       );
  //     },
  //   );
  // }
}
