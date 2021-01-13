import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehool/src/cubits/lazy_list_cubit/lazy_list_cubit.dart';
import 'package:sehool/src/cubits/reveiw_cubit/review_cubit.dart';
import 'package:sehool/src/models/lazy_list_model.dart';
import 'package:sehool/src/models/product_model.dart';

import '../../../init_injectable.dart';
import 'empty_comments_list.dart';
import 'comments_list_item_widget.dart';
import 'comments_list_loading_item_widget.dart';

class CommentsListSliver extends StatefulWidget {
  const CommentsListSliver({
    Key key,
    @required this.productId,
  }) : super(key: key);

  final int productId;

  @override
  _CommentsListSliverState createState() => _CommentsListSliverState();
}

class _CommentsListSliverState extends State<CommentsListSliver> {
  ReviewCubit cubit;

  List<ReviewModel> reviews = [];
  bool isLoading = true;
  String error;

  @override
  void initState() {
    super.initState();
    cubit = getIt<ReviewCubit>()..getReviews(widget.productId);

    cubit.listen((state) {
      state.when(
        initial: () => setState(() => isLoading = true),
        loading: () => setState(() => isLoading = true),
        success: (values) => setState(() {
          isLoading = false;
          reviews = values;
        }),
        //TODO: handel ERRORS
        failure: (message) => throw UnimplementedError(),
      );
    });
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= reviews.length) {
            return const CommentsListLoadingItemWidget();
          } else {
            return CommentsListItemWidget(
              review: reviews.elementAt(index),
            );
          }
        },
        childCount: isLoading ? reviews.length + 5 : reviews.length,
      ),
    );
  }
}
