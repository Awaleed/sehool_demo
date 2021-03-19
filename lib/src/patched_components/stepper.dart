import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum PatchedStepState { indexed, editing, complete, disabled, error }

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
const double _kTriangleHeight = _kPatchedStepSize * 0.866025;

@immutable
class PatchedStep {
  const PatchedStep({
    @required this.title,
    this.subtitle,
    this.header,
    @required this.content,
    this.state = PatchedStepState.indexed,
    this.isActive = false,
  })  : assert(title != null),
        assert(content != null),
        assert(state != null);

  final String title;
  final IconData header;
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
    this.currentPatchedStep = 0,
    this.onPatchedStepTapped,
    this.onPatchedStepContinue,
    this.onPatchedStepCancel,
    this.controlsBuilder,
  })  : assert(patchedSteps != null),
        assert(currentPatchedStep != null),
        assert(0 <= currentPatchedStep && currentPatchedStep < patchedSteps.length),
        super(key: key);

  final List<PatchedStep> patchedSteps;
  final ScrollPhysics physics;
  final int currentPatchedStep;
  final ValueChanged<int> onPatchedStepTapped;
  final VoidCallback onPatchedStepContinue;
  final VoidCallback onPatchedStepCancel;
  final ControlsWidgetBuilder controlsBuilder;

  @override
  _PatchedStepperState createState() => _PatchedStepperState();
}

class _PatchedStepperState extends State<PatchedStepper> with TickerProviderStateMixin {
  final Map<int, PatchedStepState> _oldStates = <int, PatchedStepState>{};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.patchedSteps.length; i += 1) {
      _oldStates[i] = widget.patchedSteps[i].state;
    }
  }

  @override
  void didUpdateWidget(PatchedStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.patchedSteps.length == oldWidget.patchedSteps.length);
    for (int i = 0; i < oldWidget.patchedSteps.length; i += 1) {
      _oldStates[i] = oldWidget.patchedSteps[i].state;
    }
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final PatchedStepState state = oldState ? _oldStates[index] : widget.patchedSteps[index].state;
    final bool isDarkActive = _isDark() && widget.patchedSteps[index].isActive;
    assert(state != null);
    switch (state) {
      case PatchedStepState.indexed:
      case PatchedStepState.disabled:
        return Icon(
          widget?.patchedSteps[index]?.header ?? FluentIcons.caret_24_regular,
          color: _circleColor(index),
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
      default:
        throw UnimplementedError();
    }
  }

  Color _circleColor(int index) {
    final ThemeData themeData = Theme.of(context);
    if (!_isDark()) {
      return widget.patchedSteps[index].isActive ? themeData.primaryColor : Colors.white;
    } else {
      return widget.patchedSteps[index].isActive ? themeData.accentColor : themeData.backgroundColor;
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
        child: Center(
          child: _buildCircleChild(index, oldState && widget.patchedSteps[index].state == PatchedStepState.error),
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
          height: _kTriangleHeight,
          child: CustomPaint(
            painter: _TrianglePainter(
              color: _isDark() ? _kErrorDark : _kErrorLight,
            ),
            child: Align(
              alignment: const Alignment(0.0, 0.8),
              child: _buildCircleChild(index, oldState && widget.patchedSteps[index].state != PatchedStepState.error),
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
        crossFadeState: widget.patchedSteps[index].state == PatchedStepState.error ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      );
    } else {
      if (widget.patchedSteps[index].state != PatchedStepState.error) {
        return _buildCircle(index, false);
      } else {
        return _buildTriangle(index, false);
      }
    }
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
        return textTheme.bodyText1.copyWith(color: _isDark() ? _kDisabledDark : _kDisabledLight);
      case PatchedStepState.error:
        return textTheme.bodyText1.copyWith(color: _isDark() ? _kErrorDark : _kErrorLight);
      default:
        throw UnimplementedError();
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
          child: Txt(
            widget.patchedSteps[index].title,
            style: TxtStyle()..textColor(_circleColor(index)),
          ),
        ),
      ],
    );
  }

  double value = 0;
  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.patchedSteps.length; i += 1) ...<Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(color: widget.patchedSteps[i].state != PatchedStepState.disabled ? Colors.transparent : Colors.grey.withOpacity(.8), borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: InkResponse(
            onTap: widget.patchedSteps[i].state != PatchedStepState.disabled
                ? () {
                    if (widget.onPatchedStepTapped != null) {
                      widget.onPatchedStepTapped(i);
                    }
                  }
                : null,
            canRequestFocus: widget.patchedSteps[i].state != PatchedStepState.disabled,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 72.0,
                  child: Center(child: _buildIcon(i)),
                ),
                Container(
                  child: _buildHeaderText(i),
                ),
              ],
            ),
          ),
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
          child: _Animated(
            key: GlobalKey(),
            step: widget.patchedSteps[widget.currentPatchedStep],
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
      if (context.findAncestorWidgetOfExactType<PatchedStepper>() != null) {
        throw FlutterError('PatchedSteppers must not be nested.\n'
            'The material specification advises that one should avoid embedding '
            'Patched steppers within Patched steppers. '
            'https:');
      }
      return true;
    }());

    return _buildHorizontal();
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    @required this.color,
  });

  final Color color;

  @override
  bool hitTest(Offset point) => true;

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

class _Animated extends StatelessWidget {
  const _Animated({
    Key key,
    this.step,
  }) : super(key: key);

  final PatchedStep step;

  @override
  Widget build(BuildContext context) {
    return PlayAnimation(
      tween: 0.0.tweenTo(1.0),
      duration: 150.milliseconds,
      curve: Curves.easeOut,
      builder: (context, child, value) => Opacity(opacity: value, child: child),
      child: PlayAnimation<double>(
        tween: 0.0.tweenTo(1.0),
        delay: 600.milliseconds,
        duration: 200.milliseconds,
        curve: Curves.easeOut,
        builder: (context, child, value) => Stack(
          fit: StackFit.expand,
          children: [
            Parent(
              style: ParentStyle()
                ..scale(value)
                ..opacity(value),
              child: step.content,
            ),
            IgnorePointer(
              ignoring: value >= 0,
              child: Opacity(
                opacity: 1 - value,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: step.subtitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
