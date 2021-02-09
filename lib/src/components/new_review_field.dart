import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../cubits/product_cubits/review_cubit/review_cubit.dart';
import '../helpers/helper.dart';

class NewReviewField extends StatefulWidget {
  const NewReviewField({
    Key key,
    @required this.productId,
    @required this.cubit,
    @required this.textEditingController,
    @required this.isLoading,
  }) : super(key: key);

  final int productId;
  final ReviewCubit cubit;
  final TextEditingController textEditingController;
  final bool isLoading;

  @override
  _NewReviewFieldState createState() => _NewReviewFieldState();
}

class _NewReviewFieldState extends State<NewReviewField> {
  int rating = 2;

  @override
  Widget build(BuildContext context) {
    final canSend = (widget.textEditingController?.text?.isNotEmpty ?? false) && !widget.isLoading;
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          if (canSend)
            RatingBar.builder(
              initialRating: rating.toDouble(),
              ignoreGestures: widget.isLoading,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemSize: 50.0,
              onRatingUpdate: (double value) {
                setState(() {
                  rating = value.toInt();
                });
              },
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.textEditingController,
                  enabled: !widget.isLoading,
                  maxLines: 10,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              IconButton(
                color: Colors.amber,
                icon: const Icon(FluentIcons.send_28_filled),
                onPressed: canSend
                    ? () async {
                        Helpers.dismissFauces(context);
                        await widget.cubit.addReview(
                          productId: widget.productId,
                          review: widget.textEditingController.text.trim(),
                          rating: rating,
                        );
                        widget.textEditingController.clear();
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
