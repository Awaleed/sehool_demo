import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sehool/src/cubits/reveiw_cubit/review_cubit.dart';
import 'package:sehool/src/helpers/helper.dart';

import '../../init_injectable.dart';

class NewReviewField extends StatefulWidget {
  const NewReviewField({
    Key key,
    @required this.productId,
  }) : super(key: key);

  final int productId;

  @override
  _NewReviewFieldState createState() => _NewReviewFieldState();
}

class _NewReviewFieldState extends State<NewReviewField> {
  ReviewCubit cubit;
  bool canSend = false;
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    cubit = getIt<ReviewCubit>();
    textEditingController = TextEditingController();
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
    return BlocBuilder<ReviewCubit, ReviewState>(
      cubit: cubit,
      builder: (context, state) {
        return state.when(
          initial: () => _buildUI(),
          loading: () => _buildUI(isLoading: true),
          success: (_) => _buildUI(),
          failure: (_) => throw UnimplementedError(),
        );
      },
    );
  }

  Container _buildUI({bool isLoading = false}) {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          IconButton(
            color: Colors.amber,
            icon: const Icon(FontAwesomeIcons.paperPlane),
            onPressed: canSend
                ? () {
                    Helpers.dismissFauces(context);
                    cubit.addReview(
                      productId: widget.productId,
                      review: textEditingController.text.trim(),
                    );
                  }
                : null,
          ),
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
        ],
      ),
    );
  }
}
