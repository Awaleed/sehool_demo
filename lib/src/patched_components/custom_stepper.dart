import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum CustomStepState { indexed, editing, complete, disabled, error }

const TextStyle _kCustomStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);
const Color _kErrorLight = Colors.red;
final Color _kErrorDark = Colors.red.shade400;
const Color _kCircleActiveLight = Colors.white;
const Color _kCircleActiveDark = Colors.black87;
const Color _kDisabledLight = Colors.black38;
const Color _kDisabledDark = Colors.white38;
const double _kCustomStepSize = 24.0;
const double _kTriangleHeight = _kCustomStepSize * 0.866025;

@immutable
class CustomStep {
  const CustomStep({
    @required this.title,
    this.subtitle,
    this.header,
    @required this.content,
    this.state = CustomStepState.indexed,
    this.isActive = false,
  })  : assert(title != null),
        assert(content != null),
        assert(state != null);

  final String title;
  final IconData header;
  final Widget subtitle;
  final Widget content;
  final CustomStepState state;
  final bool isActive;
}

class CustomStepper extends StatefulWidget {
  const CustomStepper({
    Key key,
    @required this.customSteps,
    this.physics,
    this.currentCustomStep = 0,
    this.onCustomStepTapped,
    this.onCustomStepContinue,
    this.onCustomStepCancel,
    this.controlsBuilder,
  })  : assert(customSteps != null),
        assert(currentCustomStep != null),
        assert(
            0 <= currentCustomStep && currentCustomStep < customSteps.length),
        super(key: key);

  final List<CustomStep> customSteps;
  final ScrollPhysics physics;
  final int currentCustomStep;
  final ValueChanged<int> onCustomStepTapped;
  final VoidCallback onCustomStepContinue;
  final VoidCallback onCustomStepCancel;
  final ControlsWidgetBuilder controlsBuilder;

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper>
    with TickerProviderStateMixin {
  final Map<int, CustomStepState> _oldStates = <int, CustomStepState>{};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.customSteps.length; i += 1) {
      _oldStates[i] = widget.customSteps[i].state;
    }
  }

  @override
  void didUpdateWidget(CustomStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.customSteps.length == oldWidget.customSteps.length);
    for (int i = 0; i < oldWidget.customSteps.length; i += 1) {
      _oldStates[i] = oldWidget.customSteps[i].state;
    }
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final CustomStepState state =
        oldState ? _oldStates[index] : widget.customSteps[index].state;
    final bool isDarkActive = _isDark() && widget.customSteps[index].isActive;
    assert(state != null);
    switch (state) {
      case CustomStepState.indexed:
      case CustomStepState.disabled:
        return Icon(
          widget?.customSteps[index]?.header ?? FluentIcons.caret_24_regular,
          color: _circleColor(index),
          // '${index + 1}',
          // style: isDarkActive
          //     ? _kCustomStepStyle.copyWith(color: Colors.black87)
          //     : _kCustomStepStyle,
        );
      case CustomStepState.editing:
        return Icon(
          Icons.edit,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case CustomStepState.complete:
        return Icon(
          Icons.check,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case CustomStepState.error:
        return const Text('!', style: _kCustomStepStyle);
      default:
        throw UnimplementedError();
    }
  }

  Color _circleColor(int index) {
    final ThemeData themeData = Theme.of(context);
    if (!_isDark()) {
      return widget.customSteps[index].isActive
          ? themeData.primaryColor
          : Colors.white;
    } else {
      return widget.customSteps[index].isActive
          ? themeData.accentColor
          : themeData.backgroundColor;
    }
  }

  Widget _buildCircle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kCustomStepSize,
      height: _kCustomStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        child: Center(
          child: _buildCircleChild(
              index,
              oldState &&
                  widget.customSteps[index].state == CustomStepState.error),
        ),
      ),
    );
  }

  Widget _buildTriangle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kCustomStepSize,
      height: _kCustomStepSize,
      child: Center(
        child: SizedBox(
          width: _kCustomStepSize,
          height: _kTriangleHeight,
          child: CustomPaint(
            painter: _TrianglePainter(
              color: _isDark() ? _kErrorDark : _kErrorLight,
            ),
            child: Align(
              alignment: const Alignment(0.0, 0.8),
              child: _buildCircleChild(
                  index,
                  oldState &&
                      widget.customSteps[index].state != CustomStepState.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    if (widget.customSteps[index].state != _oldStates[index]) {
      return AnimatedCrossFade(
        firstChild: _buildCircle(index, true),
        secondChild: _buildTriangle(index, true),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: widget.customSteps[index].state == CustomStepState.error
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      );
    } else {
      if (widget.customSteps[index].state != CustomStepState.error) {
        return _buildCircle(index, false);
      } else {
        return _buildTriangle(index, false);
      }
    }
  }

  TextStyle _titleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    assert(widget.customSteps[index].state != null);
    switch (widget.customSteps[index].state) {
      case CustomStepState.indexed:
      case CustomStepState.editing:
      case CustomStepState.complete:
        return textTheme.bodyText1;
      case CustomStepState.disabled:
        return textTheme.bodyText1
            .copyWith(color: _isDark() ? _kDisabledDark : _kDisabledLight);
      case CustomStepState.error:
        return textTheme.bodyText1
            .copyWith(color: _isDark() ? _kErrorDark : _kErrorLight);
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
            widget.customSteps[index].title,
            style: TxtStyle()..textColor(_circleColor(index)),
          ),
        ),
      ],
    );
  }

  double value = 0;
  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.customSteps.length; i += 1) ...<Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: widget.customSteps[i].state != CustomStepState.disabled
                  ? Colors.transparent
                  : Colors.grey.withOpacity(.8),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: InkResponse(
            onTap: widget.customSteps[i].state != CustomStepState.disabled
                ? () {
                    if (widget.onCustomStepTapped != null) {
                      widget.onCustomStepTapped(i);
                    }
                  }
                : null,
            canRequestFocus:
                widget.customSteps[i].state != CustomStepState.disabled,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 72.0,
                  child: Center(child: _buildIcon(i)),
                ),
                Container(
                  // margin: const EdgeInsetsDirectional.only(start: 12.0),
                  child: _buildHeaderText(i),
                ),
              ],
            ),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 8.0),
        //   height: 1.0,
        //   color: Colors.grey.shade400,
        // ),
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
            child: Stack(
          fit: StackFit.expand,
          children: [
            IndexedStack(
              index: widget.currentCustomStep,
              children: [
                ...widget.customSteps.map((e) => e.content),
              ],
            ),
            _Animated(
              key: GlobalKey(),
              step: widget.customSteps[widget.currentCustomStep],
            ),
          ],
        )
            // _Animated(
            //   key: GlobalKey(),
            //   step: widget.customSteps[widget.currentCustomStep],
            // ),
            ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<CustomStepper>() != null) {
        throw FlutterError('CustomSteppers must not be nested.\n'
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

  final CustomStep step;

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
        builder: (context, child, value) => IgnorePointer(
              ignoring: value >= 0,
              child: Opacity(
                opacity: 1 - value,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: step.subtitle,
                ),
              ),
            ),
      ),
    );
  }
}
