import 'package:division/division.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/orders_list/orders_list_sliver.dart';
import '../../cubits/order_cubit/order_cubit.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  const OrdersScreen({
    Key key,
  }) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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

            //TODO: handel ERRORS
            failure: (message) => throw UnimplementedError(),
          );
        },
      ),
    );
  }

  Widget _buildUI(List values, {isLoading = false}) {
    return Parent(
      style: ParentStyle()
        ..background.image(path: 'assets/images/bg.jpg', fit: BoxFit.cover),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                title: Text(
                  S.current.my_orders,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
                backgroundColor: Colors.black54,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: Card(
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          DateFormat.yMMMEd().format(DateTime.now()),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              OrdersListWidget(isLoading: isLoading, orders: values),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ],
      ),
    );
  }
}
