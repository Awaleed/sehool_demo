import 'package:flutter/material.dart';

import '../../../init_injectable.dart';
import '../../cubits/reveiw_cubit/review_cubit.dart';
import '../../models/product_model.dart';
import 'comments_list_item_widget.dart';
import 'comments_list_loading_item_widget.dart';
import 'empty_comments_list.dart';

class CommentsListSliver extends StatelessWidget {
  const CommentsListSliver({
    Key key,
    @required this.reviews,
    @required this.isLoading,
  }) : super(key: key);

  final List<ReviewModel> reviews;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty && !isLoading) {
      return const EmptyCommentsList();
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= reviews.length) {
            return const CommentsListLoadingItemWidget();
          } else {
            return CommentsListItemWidget(review: reviews.elementAt(index));
          }
        },
        childCount: isLoading ? reviews.length + 5 : reviews.length,
      ),
    );
  }
}
