import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/helper.dart';
import '../math_helper.dart';
import '../matrix.dart';

enum AnimatedTextRotation { up, down }

class AnimatedText extends StatefulWidget {
  const AnimatedText({
    Key key,
    @required this.text,
    this.style,
    this.textRotation = AnimatedTextRotation.up,
  }) : super(key: key);

  final String text;
  final TextStyle style;
  final AnimatedTextRotation textRotation;

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  var _newText = '';
  var _oldText = '';
  var _layoutHeight = 0.0;
  final _textKey = GlobalKey();

  Animation<double> _animation;
  AnimationController _controller;

  double get radius => _layoutHeight / 2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.0, end: pi / 2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _oldText = widget.text;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _layoutHeight = Helpers.getWidgetSize(_textKey)?.height);
    });
  }

  @override
  void didUpdateWidget(AnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      _oldText = oldWidget.text;
      _newText = widget.text;
      _controller.forward().then((_) {
        setState(() {
          final t = _oldText;
          _oldText = _newText;
          _newText = t;
        });
        _controller.reset();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Matrix4 get _matrix {
    if (kIsWeb) {
      return Matrix4.identity();
    }
    return Matrix.perspective(.006);
  }

  Matrix4 _getFrontSideUp(double value) {
    return _matrix
      ..translate(
        0.0,
        -radius * sin(_animation.value),
        -radius * cos(_animation.value),
      )
      ..rotateX(-_animation.value);
  }

  Matrix4 _getBackSideUp(double value) {
    return _matrix
      ..translate(
        0.0,
        radius * cos(_animation.value),
        -radius * sin(_animation.value),
      )
      ..rotateX((pi / 2) - _animation.value);
  }

  Matrix4 _getFrontSideDown(double value) {
    return _matrix
      ..translate(
        0.0,
        radius * sin(_animation.value),
        -radius * cos(_animation.value),
      )
      ..rotateX(_animation.value);
  }

  Matrix4 _getBackSideDown(double value) {
    return _matrix
      ..translate(
        0.0,
        -radius * cos(_animation.value),
        -radius * sin(_animation.value),
      )
      ..rotateX(_animation.value - pi / 2);
  }

  @override
  Widget build(BuildContext context) {
    final rollUp = widget.textRotation == AnimatedTextRotation.up;
    final oldText = Text(
      _oldText,
      key: _textKey,
      style: widget.style,
      overflow: TextOverflow.visible,
      softWrap: false,
    );
    final newText = Text(
      _newText,
      style: widget.style,
      overflow: TextOverflow.visible,
      softWrap: false,
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if (_animation.value <= MathHelper.toRadian(85))
            Transform(
              alignment: Alignment.center,
              transform: rollUp ? _getFrontSideUp(_animation.value) : _getFrontSideDown(_animation.value),
              child: oldText,
            ),
          if (_animation.value >= MathHelper.toRadian(5))
            Transform(
              alignment: Alignment.center,
              transform: rollUp ? _getBackSideUp(_animation.value) : _getBackSideDown(_animation.value),
              child: newText,
            ),
        ],
      ),
    );
  }
}
