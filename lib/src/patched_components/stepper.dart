// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// TODO(dragostis): Missing functionality:
//   * mobile horizontal mode with adding/removing Patchedsteps
//   * alternative labeling
//   * Patchedstepper feedback in the case of high-latency interactions

enum PatchedStepState {
  indexed,

  editing,

  complete,

  disabled,

  error,
}

enum PatchedStepperType {
  vertical,
  horizontal,
}

const TextStyle _kPatchedStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);
const Color _kErrorLight = Colors.red;
final Color _kErrorDark = Colors.red.shade400;
const Color _kCircleActiveLight = Colors.white;
const Color _kCircleActiveDark = Colors.black87;
const Color _kDisabledLight = Colors.black38;
const Color _kDisabledDark = Colors.white38;
const double _kPatchedStepSize = 24.0;
const double _kTriangleHeight =
    _kPatchedStepSize * 0.866025; // Triangle height. sqrt(3.0) / 2.0

@immutable
class PatchedStep {
  const PatchedStep({
    @required this.title,
    this.subtitle,
    @required this.content,
    this.state = PatchedStepState.indexed,
    this.isActive = false,
  })  : assert(title != null),
        assert(content != null),
        assert(state != null);

  final Widget title;

  final Widget subtitle;

  final Widget content;

  final PatchedStepState state;

  final bool isActive;
}

class PatchedStepper extends StatefulWidget {
  const PatchedStepper({
    Key key,
    @required this.patchedSteps,
    this.physics,
    this.type = PatchedStepperType.vertical,
    this.currentPatchedStep = 0,
    this.onPatchedStepTapped,
    this.onPatchedStepContinue,
    this.onPatchedStepCancel,
    this.controlsBuilder,
  })  : assert(patchedSteps != null),
        assert(type != null),
        assert(currentPatchedStep != null),
        assert(0 <= currentPatchedStep &&
            currentPatchedStep < patchedSteps.length),
        super(key: key);

  final List<PatchedStep> patchedSteps;

  final ScrollPhysics physics;

  final PatchedStepperType type;

  final int currentPatchedStep;

  final ValueChanged<int> onPatchedStepTapped;

  final VoidCallback onPatchedStepContinue;

  final VoidCallback onPatchedStepCancel;

  final ControlsWidgetBuilder controlsBuilder;

  @override
  _PatchedStepperState createState() => _PatchedStepperState();
}

class _PatchedStepperState extends State<PatchedStepper>
    with TickerProviderStateMixin {
  List<GlobalKey> _keys;
  final Map<int, PatchedStepState> _oldStates = <int, PatchedStepState>{};

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.patchedSteps.length,
      (int i) => GlobalKey(),
    );

    for (int i = 0; i < widget.patchedSteps.length; i += 1)
      _oldStates[i] = widget.patchedSteps[i].state;
  }

  @override
  void didUpdateWidget(PatchedStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.patchedSteps.length == oldWidget.patchedSteps.length);

    for (int i = 0; i < oldWidget.patchedSteps.length; i += 1)
      _oldStates[i] = oldWidget.patchedSteps[i].state;
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.patchedSteps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return widget.currentPatchedStep == index;
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Widget _buildLine(bool visible) {
    return Container(
      width: visible ? 1.0 : 0.0,
      height: 16.0,
      color: Colors.grey.shade400,
    );
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final PatchedStepState state =
        oldState ? _oldStates[index] : widget.patchedSteps[index].state;
    final bool isDarkActive = _isDark() && widget.patchedSteps[index].isActive;
    assert(state != null);
    switch (state) {
      case PatchedStepState.indexed:
      case PatchedStepState.disabled:
        return Text(
          '${index + 1}',
          style: isDarkActive
              ? _kPatchedStepStyle.copyWith(color: Colors.black87)
              : _kPatchedStepStyle,
        );
      case PatchedStepState.editing:
        return Icon(
          Icons.edit,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case PatchedStepState.complete:
        return Icon(
          Icons.check,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case PatchedStepState.error:
        return const Text('!', style: _kPatchedStepStyle);
    }
  }

  Color _circleColor(int index) {
    final ThemeData themeData = Theme.of(context);
    if (!_isDark()) {
      return widget.patchedSteps[index].isActive
          ? themeData.primaryColor
          : Colors.black38;
    } else {
      return widget.patchedSteps[index].isActive
          ? themeData.accentColor
          : themeData.backgroundColor;
    }
  }

  Widget _buildCircle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kPatchedStepSize,
      height: _kPatchedStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _circleColor(index),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: _buildCircleChild(
              index,
              oldState &&
                  widget.patchedSteps[index].state == PatchedStepState.error),
        ),
      ),
    );
  }

  Widget _buildTriangle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kPatchedStepSize,
      height: _kPatchedStepSize,
      child: Center(
        child: SizedBox(
          width: _kPatchedStepSize,
          height:
              _kTriangleHeight, // Height of 24dp-long-sided equilateral triangle.
          child: CustomPaint(
            painter: _TrianglePainter(
              color: _isDark() ? _kErrorDark : _kErrorLight,
            ),
            child: Align(
              alignment: const Alignment(
                  0.0, 0.8), // 0.8 looks better than the geometrical 0.33.
              child: _buildCircleChild(
                  index,
                  oldState &&
                      widget.patchedSteps[index].state !=
                          PatchedStepState.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    if (widget.patchedSteps[index].state != _oldStates[index]) {
      return AnimatedCrossFade(
        firstChild: _buildCircle(index, true),
        secondChild: _buildTriangle(index, true),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState:
            widget.patchedSteps[index].state == PatchedStepState.error
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      );
    } else {
      if (widget.patchedSteps[index].state != PatchedStepState.error)
        return _buildCircle(index, false);
      else
        return _buildTriangle(index, false);
    }
  }

  Widget _buildVerticalControls() {
    if (widget.controlsBuilder != null)
      return widget.controlsBuilder(context,
          onStepContinue: widget.onPatchedStepContinue,
          onStepCancel: widget.onPatchedStepCancel);

    Color cancelColor;
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        cancelColor = Colors.black54;
        break;
      case Brightness.dark:
        cancelColor = Colors.white70;
        break;
    }

    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    const OutlinedBorder buttonShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)));
    const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 16.0);

    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 48.0),
        child: Row(
          // The Material spec no longer includes a PatchedStepper widget. The continue
          // and cancel button styles have been configured to match the original
          // version of this widget.
          children: <Widget>[
            TextButton(
              onPressed: widget.onPatchedStepContinue,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : (_isDark()
                          ? colorScheme.onSurface
                          : colorScheme.onPrimary);
                }),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return _isDark() || states.contains(MaterialState.disabled)
                      ? null
                      : colorScheme.primary;
                }),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    buttonPadding),
                shape: MaterialStateProperty.all<OutlinedBorder>(buttonShape),
              ),
              child: Text(localizations.continueButtonLabel),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(start: 8.0),
              child: TextButton(
                onPressed: widget.onPatchedStepCancel,
                style: TextButton.styleFrom(
                  primary: cancelColor,
                  padding: buttonPadding,
                  shape: buttonShape,
                ),
                child: Text(localizations.cancelButtonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _titleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    assert(widget.patchedSteps[index].state != null);
    switch (widget.patchedSteps[index].state) {
      case PatchedStepState.indexed:
      case PatchedStepState.editing:
      case PatchedStepState.complete:
        return textTheme.bodyText1;
      case PatchedStepState.disabled:
        return textTheme.bodyText1
            .copyWith(color: _isDark() ? _kDisabledDark : _kDisabledLight);
      case PatchedStepState.error:
        return textTheme.bodyText1
            .copyWith(color: _isDark() ? _kErrorDark : _kErrorLight);
    }
  }

  TextStyle _subtitleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    assert(widget.patchedSteps[index].state != null);
    switch (widget.patchedSteps[index].state) {
      case PatchedStepState.indexed:
      case PatchedStepState.editing:
      case PatchedStepState.complete:
        return textTheme.caption;
      case PatchedStepState.disabled:
        return textTheme.caption
            .copyWith(color: _isDark() ? _kDisabledDark : _kDisabledLight);
      case PatchedStepState.error:
        return textTheme.caption
            .copyWith(color: _isDark() ? _kErrorDark : _kErrorLight);
    }
  }

  Widget _buildHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedDefaultTextStyle(
          style: _titleStyle(index),
          duration: kThemeAnimationDuration,
          curve: Curves.fastOutSlowIn,
          child: widget.patchedSteps[index].title,
        ),
        if (widget.patchedSteps[index].subtitle != null)
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: AnimatedDefaultTextStyle(
              style: _subtitleStyle(index),
              duration: kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
              child: widget.patchedSteps[index].subtitle,
            ),
          ),
      ],
    );
  }

  Widget _buildVerticalHeader(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              // Line parts are always added in order for the ink splash to
              // flood the tips of the connector lines.
              _buildLine(!_isFirst(index)),
              _buildIcon(index),
              _buildLine(!_isLast(index)),
            ],
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsetsDirectional.only(start: 12.0),
            child: _buildHeaderText(index),
          )),
        ],
      ),
    );
  }

  Widget _buildVerticalBody(int index) {
    return Stack(
      children: <Widget>[
        PositionedDirectional(
          start: 24.0,
          top: 0.0,
          bottom: 0.0,
          child: SizedBox(
            width: 24.0,
            child: Center(
              child: SizedBox(
                width: _isLast(index) ? 0.0 : 1.0,
                child: Container(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(height: 0.0),
          secondChild: Container(
            margin: const EdgeInsetsDirectional.only(
              start: 60.0,
              end: 24.0,
              bottom: 24.0,
            ),
            child: Column(
              children: <Widget>[
                widget.patchedSteps[index].content,
                _buildVerticalControls(),
              ],
            ),
          ),
          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: _isCurrent(index)
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: kThemeAnimationDuration,
        ),
      ],
    );
  }

  Widget _buildVertical() {
    return ListView(
      shrinkWrap: true,
      physics: widget.physics,
      children: <Widget>[
        for (int i = 0; i < widget.patchedSteps.length; i += 1)
          Column(
            key: _keys[i],
            children: <Widget>[
              InkWell(
                onTap: widget.patchedSteps[i].state != PatchedStepState.disabled
                    ? () {
                        // In the vertical case we need to scroll to the newly tapped
                        // Patchedstep.
                        Scrollable.ensureVisible(
                          _keys[i].currentContext,
                          curve: Curves.fastOutSlowIn,
                          duration: kThemeAnimationDuration,
                        );

                        if (widget.onPatchedStepTapped != null)
                          widget.onPatchedStepTapped(i);
                      }
                    : null,
                canRequestFocus:
                    widget.patchedSteps[i].state != PatchedStepState.disabled,
                child: _buildVerticalHeader(i),
              ),
              _buildVerticalBody(i),
            ],
          ),
      ],
    );
  }

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.patchedSteps.length; i += 1) ...<Widget>[
        InkResponse(
          onTap: widget.patchedSteps[i].state != PatchedStepState.disabled
              ? () {
                  if (widget.onPatchedStepTapped != null)
                    widget.onPatchedStepTapped(i);
                }
              : null,
          canRequestFocus:
              widget.patchedSteps[i].state != PatchedStepState.disabled,
          child: Column(
            children: <Widget>[
              Container(
                height: 72.0,
                child: Center(
                  child: _buildIcon(i),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 12.0),
                child: _buildHeaderText(i),
              ),
            ],
          ),
        ),
        if (!_isLast(i))
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 1.0,
            color: Colors.grey.shade400,
          ),
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: children,
            ),
          ),
        ),
        Expanded(
          child: AnimatedSize(
            curve: Curves.fastOutSlowIn,
            duration: kThemeAnimationDuration,
            vsync: this,
            child: widget.patchedSteps[widget.currentPatchedStep].content,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<PatchedStepper>() != null)
        throw FlutterError('PatchedSteppers must not be nested.\n'
            'The material specification advises that one should avoid embedding '
            'Patchedsteppers within Patchedsteppers. '
            'https://material.io/archive/guidelines/components/Patchedsteppers.html#Patchedsteppers-usage');
      return true;
    }());
    assert(widget.type != null);
    switch (widget.type) {
      case PatchedStepperType.vertical:
        return _buildVertical();
      case PatchedStepperType.horizontal:
        return _buildHorizontal();
    }
  }
}

// Paints a triangle whose base is the bottom of the bounding rectangle and its
// top vertex the middle of its top.
class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    @required this.color,
  });

  final Color color;

  @override
  bool hitTest(Offset point) => true; // Hitting the rectangle is fine enough.

  @override
  bool shouldRepaint(_TrianglePainter oldPainter) {
    return oldPainter.color != color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double base = size.width;
    final double halfBase = size.width / 2.0;
    final double height = size.height;
    final List<Offset> points = <Offset>[
      Offset(0.0, height),
      Offset(base, height),
      Offset(halfBase, 0.0),
    ];

    canvas.drawPath(
      Path()..addPolygon(points, true),
      Paint()..color = color,
    );
  }
}
