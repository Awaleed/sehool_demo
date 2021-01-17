import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../cubits/reveiw_cubit/review_cubit.dart';
import '../helpers/helper.dart';

class NewReviewField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final canSend =
        (textEditingController?.text?.isNotEmpty ?? false) && !isLoading;
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              enabled: !isLoading,
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
                    await cubit.addReview(
                      productId: productId,
                      review: textEditingController.text.trim(),
                    );
                    textEditingController.clear();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
