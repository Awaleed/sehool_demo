import 'package:flutter/material.dart';

enum FadeDirection {
  startToEnd,
  endToStart,
  topToBottom,
  bottomToTop,
}

class FadeIn extends StatefulWidget {
  const FadeIn({
    Key key,
    this.fadeDirection = FadeDirection.startToEnd,
    this.offset = 1.0,
    this.controller,
    this.duration,
    this.curve = Curves.easeOut,
    @required this.child,
  })  : assert(controller == null && duration != null || controller != null && duration == null),
        assert(offset > 0),
        super(key: key);

  final AnimationController controller;
  final FadeDirection fadeDirection;
  final double offset;
  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      );
    }

    _updateAnimations();
    _controller?.forward();
  }

  void _updateAnimations() {
    Offset begin;
    Offset end;
    final offset = widget.offset;

    switch (widget.fadeDirection) {
      case FadeDirection.startToEnd:
        begin = Offset(-offset, 0);
        end = const Offset(0, 0);
        break;
      case FadeDirection.endToStart:
        begin = Offset(offset, 0);
        end = const Offset(0, 0);
        break;
      case FadeDirection.topToBottom:
        begin = Offset(0, -offset);
        end = const Offset(0, 0);
        break;
      case FadeDirection.bottomToTop:
        begin = Offset(0, offset);
        end = const Offset(0, 0);
        break;
    }

    _slideAnimation = Tween<Offset>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: _effectiveController,
      curve: widget.curve,
    ));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _effectiveController,
      curve: widget.curve,
    ));
  }

  AnimationController get _effectiveController => widget.controller ?? _controller;

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: widget.child,
      ),
    );
  }
}
