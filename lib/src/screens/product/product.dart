import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehool/src/data/user_datasource.dart';
import 'package:sehool/src/helpers/helper.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../components/comments_list/comments_list_sliver.dart';
import '../../components/my_error_widget.dart';
import '../../components/new_review_field.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../../cubits/product_cubits/review_cubit/review_cubit.dart';
import '../../models/product_model.dart';
import '../../routes/config_routes.dart';
import '../cart/add_to_cart.dart';
import '../home/home.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product';

  const ProductScreen({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ReviewCubit cubit;
  TextEditingController textEditingController;
  bool canSend = false;

  @override
  void initState() {
    super.initState();
    cubit = getIt<ReviewCubit>()..getReviews(widget.product.id);
    textEditingController = TextEditingController(text: kUser == null ? S.current.you_must_login_first : '');
    textEditingController.addListener(checkIfFieldEmpty);
  }

  @override
  void dispose() {
    cubit.close();
    textEditingController.dispose();
    super.dispose();
  }

  void checkIfFieldEmpty() {
    setState(() {
      canSend = textEditingController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ReviewCubit, ReviewState>(
        cubit: cubit,
        builder: (context, state) {
          return state.when(
            initial: () => _buildUI([], isLoading: true),
            loading: () => _buildUI([], isLoading: true),
            addingReview: (values) => _buildUI(values, isLoading: true),
            success: (values) => _buildUI(values),
            failure: (message) => MyErrorWidget(
              onRetry: () {
                cubit.retryGetReviews();
              },
              message: message,
            ),
          );
        },
      ),
    );
  }

  Widget _buildUI(List<ReviewModel> values, {isLoading = false}) {
    return RefreshIndicator(
      onRefresh: cubit.retryGetReviews,
      child: Parent(
        style: ParentStyle()
          ..background.color(Colors.white)
          ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
        child: Scaffold(
          floatingActionButton: const WhatsappFloatingActionButton(),
          bottomNavigationBar: NewReviewField(
            productId: widget.product.id,
            cubit: cubit,
            textEditingController: textEditingController,
            isLoading: isLoading,
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 400,
                elevation: 0,
                backgroundColor: Colors.black54,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
                flexibleSpace: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(25),
                      ),
                      child: FlexibleSpaceBar(
                        title: PlayAnimation(
                          tween: 0.0.tweenTo(1.0),
                          curve: Curves.easeInOut,
                          duration: 1700.milliseconds,
                          builder: (context, child, value) => Opacity(
                            opacity: value,
                            child: child,
                          ),
                          child: Text(
                            widget.product.name,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                          ),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: widget.product.image,
                              fit: BoxFit.cover,
                            ),
                            PlayAnimation(
                              tween: 0.0.tweenTo(1.0),
                              curve: Curves.easeInOut,
                              duration: 1700.milliseconds,
                              builder: (context, child, value) => Opacity(
                                opacity: value,
                                child: child,
                              ),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 50, top: 20),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black,
                                      Colors.transparent,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: kToolbarHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Text.rich(
                                        TextSpan(
                                          text: '${widget.product.price.toInt()} ???\n',
                                          children: [
                                            TextSpan(
                                              text: widget.product.kilo,
                                              style: Theme.of(context).textTheme.headline6.copyWith(
                                                    color: Colors.amber,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.amber),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      right: 30,
                      bottom: -20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocBuilder<CartCubit, CartState>(
                            cubit: getIt<CartCubit>(),
                            builder: (context, state) {
                              return FloatingActionButton(
                                heroTag: 'btn${widget.product.id}',
                                onPressed: () {
                                  if (kUser == null) {
                                    Helpers.showMessageOverlay(
                                      context,
                                      message: S.current.you_must_login_first,
                                    );
                                  } else if (widget.product.qyt <= 0) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.white70,
                                        content: Text(S.current.not_available_message),
                                      ),
                                    );
                                  } else {
                                    AppRouter.sailor.navigate(
                                      AddToCartScreen.routeName,
                                      params: {'product': widget.product},
                                    );
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                backgroundColor: Colors.black,
                                hoverColor: Colors.amber.withOpacity(.3),
                                splashColor: Colors.amber.withOpacity(.3),
                                child: const Icon(
                                  FluentIcons.cart_24_regular,
                                  color: Colors.amber,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          S.current.description,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const Divider(),
                        Text(widget.product.description),
                      ],
                    ),
                  ),
                ),
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
                    child: ListTile(title: Text(S.current.comments)),
                  ),
                ),
              ),
              CommentsListSliver(
                isLoading: isLoading,
                reviews: values.reversed.toList(),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }
}
