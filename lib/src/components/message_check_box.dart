import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/cart_model.dart';
import '../models/form_data_model.dart';

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
  TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController(text: widget.cart.customPhrase);
  }

  @override
  void dispose() {
    messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI(/* CartMessageModel value, {bool isLoading = false} */) {
    return Column(
      children: [
        Form(
          key: widget.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.cart.from,
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
                initialValue: widget.cart.to,
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
      onChanged: (value) {},
    );
  }
}
