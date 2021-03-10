import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../helpers/helper.dart';
import '../../models/product_model.dart';

class CommentsListItemWidget extends StatelessWidget {
  const CommentsListItemWidget({
    Key key,
    @required this.review,
  }) : super(key: key);

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: Helpers.isArabic(context)
                ? const EdgeInsets.only(right: 30)
                : const EdgeInsets.only(left: 30),
            child: Card(
              color: Colors.white70,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Padding(
                  padding: Helpers.isArabic(context)
                      ? const EdgeInsets.only(right: 20)
                      : const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(review.user.name),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(DateFormat.yMEd().format(review.createdAt)),
                          RatingBarIndicator(
                            rating: review.rating.toDouble(),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemSize: 13.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                subtitle: Text(review.comment),
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: -10,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(
                    review.user.image,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
