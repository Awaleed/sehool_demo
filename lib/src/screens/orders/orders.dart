import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'package:sehool/src/components/orders_list/orders_list_sliver.dart';
import 'package:sehool/src/cubits/lazy_list_cubit/lazy_list_cubit.dart';
import 'package:sehool/src/cubits/order_cubit/order_cubit.dart';
import 'package:sehool/src/cubits/reveiw_cubit/review_cubit.dart';
import 'package:sehool/src/models/cart_model.dart';
import 'package:sehool/src/models/lazy_list_model.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/comments_list/comments_list_sliver.dart';
import '../../components/new_review_field.dart';
import '../../models/product_model.dart';
import '../../routes/config_routes.dart';
import '../cart/add_to_cart.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  const OrdersScreen({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  LazyListCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<LazyListCubit>()..getContent(LazyListType.orders);
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LazyListCubit, LazyListState>(
        cubit: cubit,
        builder: (context, state) {
          return state.when(
            initial: () => _buildUI([], isLoading: true),
            loading: () => _buildUI([], isLoading: true),
            loadingMore: (values) => _buildUI(values, isLoading: true),
            success: (values) => _buildUI(values),
            finished: (values) => _buildUI(values),

            //TODO: handel ERRORS
            failure: (message, values) => throw UnimplementedError(),
            failureOnLoadMore: (message, values) => throw UnimplementedError(),
          );
        },
      ),
    );
  }

  Widget _buildUI(List values, {isLoading = false}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.amber,
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                'https://i.pinimg.com/originals/77/59/a2/7759a2ff203398743fd020a4bedbff14.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
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
            OrdersListSliver(isLoading: isLoading, orders: values),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ],
    );
  }
}
