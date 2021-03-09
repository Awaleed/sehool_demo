import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/form_data_model.dart';

import '../../init_injectable.dart';
import '../cubits/cart_message_cubit/cart_messages_cubit.dart';
import '../models/cart_model.dart';
import 'my_error_widget.dart';

class MessageCheckBox extends StatefulWidget {
  const MessageCheckBox({
    Key key,
    @required this.cart,
    @required this.onValueChanged,
    @required this.formKey,
  }) : super(key: key);
  final ValueChanged onValueChanged;
  final CartItemModel cart;
  final GlobalKey<FormState> formKey;

  @override
  _MessageCheckBoxState createState() => _MessageCheckBoxState();
}

class _MessageCheckBoxState extends State<MessageCheckBox> {
  // CartMessagesCubit cubit;
  TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    // cubit = getIt<CartMessagesCubit>();
    // cubit.getMessagesValues();
  }

  @override
  void dispose() {
    messageController.dispose();
    // cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
    // return BlocConsumer<CartMessagesCubit, CartMessagesState>(
    //   cubit: cubit,
    //   listener: (context, state) {
    //     // if (widget.cart.message == null) {
    //     //   setState(() {
    //     //     final value = state.maybeWhen(
    //     //       success: (value) => value,
    //     //       orElse: () => null,
    //     //     );
    //     //     if (value != null) {
    //     //       widget.cart.message = CartMessage(occasion: value.occasions.first, text: value.messages.first);
    //     //       widget.onValueChanged?.call(value);
    //     //     }
    //     //   });
    //     // }
    //   },
    //   builder: (context, state) {
    //     return state.when(
    //       initial: () => _buildUI(null, isLoading: true),
    //       loading: () => _buildUI(null, isLoading: true),
    //       success: (value) => _buildUI(value),
    //       failure: (message) => MyErrorWidget(
    //         onRetry: () {
    //           cubit.getMessagesValues();
    //         },
    //         message: message,
    //       ),
    //     );
    //   },
    // );
  }

  Widget _buildUI(/* CartMessageModel value, {bool isLoading = false} */) {
    // if (isLoading) {
    //   return FittedBox(
    //     child: Container(
    //       margin: const EdgeInsets.only(left: 40.0, right: 40.0),
    //       decoration: const BoxDecoration(
    //         color: Colors.black87,
    //         borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //       ),
    //       child: const Padding(
    //         padding: EdgeInsets.all(16.0),
    //         child: CircularProgressIndicator(strokeWidth: 2.0),
    //       ),
    //     ),
    //   );
    // }
    return Column(
      children: [
        // Row(
        //   children: [
        //     Switch(
        //       value: widget.cart.isGift,
        //       onChanged: (value) {
        //         setState(() {
        //           widget.cart.isGift = !widget.cart.isGift;
        //         });
        //       },
        //     ),
        //     Text(S.current.is_gift),
        //   ],
        // ),
        // CheckboxListTile(
        //   value: widget.cart.isGift,
        //   onChanged: (value) {
        //     setState(() {
        //       widget.cart.isGift = !widget.cart.isGift;
        //     });
        //   },
        //   title: Text(S.current.is_gift),
        // ),
        // if (widget.cart.isGift)
        Form(
          key: widget.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                // validator: Validators.shortStringValidator,
                decoration: InputDecoration(
                  hintText: S.current.from,
                  hintStyle: const TextStyle(color: Colors.black26),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onSaved: (value) => widget.cart.from = value,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                // validator: Validators.shortStringValidator,
                decoration: InputDecoration(
                  hintText: S.current.to,
                  hintStyle: const TextStyle(color: Colors.black26),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onSaved: (value) => widget.cart.to = value,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              // const SizedBox(height: 20),
              // _buildDropdown(value.event, widget.cart.event, (value) => widget.cart.event = value, S.current.occasion),
              // const SizedBox(height: 20),
              // _buildDropdown(value.phrases, widget.cart.phrase, (value) => widget.cart.phrase = value, S.current.message),
              const SizedBox(height: 20),
              _buildTextInput(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextInput() {
    return TextFormField(
      controller: messageController,
      validator: (value) {
        if (value.isEmpty) {
          return null;
        } else {
          return Validators.shortStringValidator(value);
        }
      },
      decoration: InputDecoration(
        hintText: S.current.write_custom_message,
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: Colors.black26),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            Helpers.dismissFauces(context);
            messageController.clear();
          },
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onSaved: (value) {
        if (value.isEmpty) {
          widget.cart.customPhrase = null;
        } else {
          widget.cart.customPhrase = value;
        }
      },
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      maxLines: 5,
      minLines: 1,
      // style: const TextStyle(fontWeight: FontWeight.bold),
      onChanged: (value) {
        // sendTimer?.cancel();
        // sendTimer = Timer(700.milliseconds, () {
        //   cubit.validateCoupon(couponController.text);
        // });
      },
    );
  }

  Widget _buildDropdown(List<ValueWithId> values, ValueWithId value, ValueChanged onChange, String label) {
    if (value == null) {
      Timer.run(() {
        setState(() {
          setState(() => onChange(value));
          widget.onValueChanged?.call(value);
        });
      });
    }
    return InputDecorator(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white70,
        contentPadding: EdgeInsets.zero,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: value,
          isDense: true,
          dropdownColor: Colors.amber.withOpacity(.8),
          onChanged: (value) {
            if (value == null) return;
            widget.onValueChanged?.call(value);
            setState(() => onChange(value));
          },
          isExpanded: true,
          items: [
            ...values.map(
              (e) => DropdownMenuItem(
                value: e,
                child: Center(
                  child: Text(
                    '$e',
                    overflow: TextOverflow.visible,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
