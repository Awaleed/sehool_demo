import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehool/generated/l10n.dart';

import '../../init_injectable.dart';
import '../cubits/cart_message_cubit/cart_messages_cubit.dart';
import '../models/cart_model.dart';
import 'my_error_widget.dart';

class MessageCheckBox extends StatefulWidget {
  const MessageCheckBox({
    Key key,
    @required this.cart,
    @required this.onValueChanged,
  }) : super(key: key);
  final ValueChanged onValueChanged;
  final CartModel cart;

  @override
  _MessageCheckBoxState createState() => _MessageCheckBoxState();
}

class _MessageCheckBoxState extends State<MessageCheckBox> {
  CartMessagesCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<CartMessagesCubit>();
    cubit.getMessagesValues();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartMessagesCubit, CartMessagesState>(
      cubit: cubit,
      listener: (context, state) {
        // if (widget.cart.message == null) {
        //   setState(() {
        //     final value = state.maybeWhen(
        //       success: (value) => value,
        //       orElse: () => null,
        //     );
        //     if (value != null) {
        //       widget.cart.message = CartMessage(occasion: value.occasions.first, text: value.messages.first);
        //       widget.onValueChanged?.call(value);
        //     }
        //   });
        // }
      },
      builder: (context, state) {
        return state.when(
          initial: () => _buildUI(null, isLoading: true),
          loading: () => _buildUI(null, isLoading: true),
          success: (value) => _buildUI(value),
          failure: (message) => MyErrorWidget(
            onRetry: () {
              cubit.getMessagesValues();
            },
            message: message,
          ),
        );
      },
    );
  }

  Widget _buildUI(CartMessageModel value, {bool isLoading = false}) {
    if (isLoading) {
      return FittedBox(
        child: Container(
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(strokeWidth: 2.0),
          ),
        ),
      );
    }
    return Column(
      children: [
        CheckboxListTile(
          value: widget.cart.isGift,
          onChanged: (value) {
            setState(() {
              widget.cart.isGift = !widget.cart.isGift;
            });
          },
          title: Text(S.current.is_gift),
        ),
        if (widget.cart.isGift)
          Column(
            children: [
              _buildDropdown(value.event, widget.cart.event, (value) => widget.cart.event = value, S.current.occasion),
              const SizedBox(height: 20),
              _buildDropdown(value.phrases, widget.cart.phrase, (value) => widget.cart.phrase = value, S.current.message),
              const SizedBox(height: 20),
            ],
          ),
      ],
    );
  }

  Widget _buildDropdown(List<ValueWithId> values, ValueWithId value, ValueChanged onChange, String label) {
    if (value == null) {
      Timer.run(() {
        setState(() {
          onChange(values.first);
        });
      });
    }
    return InputDecorator(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: value,
          dropdownColor: Colors.amber.withOpacity(.8),
          onChanged: (value) {
            if (value == null) return;
            widget.onValueChanged?.call(value);
            setState(() => onChange(value));
          },
          icon: const SizedBox.shrink(),
          isExpanded: true,
          hint: DropdownMenuItem(
            child: Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black),
              ),
            ),
          ),
          items: [
            ...values.map(
              (e) => DropdownMenuItem(
                value: e,
                child: Center(
                  child: Text(
                    '$e',
                    style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black),
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
