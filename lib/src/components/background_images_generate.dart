import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackgroundGeneratorGroup extends StatefulWidget {
  final int number;
  final Direction direction;
  final Trajectory trajectory;
  final DotSize size;
  final List<Color> colors;
  final double opacity;
  final DotSpeed speed;
  final List<String> image;
  final List<String> span;
  final random = Random();
  final bool isText;

  BackgroundGeneratorGroup({
    Key key,
    this.image,
    this.span,
    this.isText = false,
    this.number = 25,
    this.direction = Direction.random,
    this.trajectory = Trajectory.random,
    this.size = DotSize.random,
    this.colors = Colors.primaries,
    this.opacity = .5,
    this.speed = DotSpeed.slow,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BackgroundGeneratorGroupState();
}

class BackgroundGeneratorGroupState extends State<BackgroundGeneratorGroup> {
  double radius;
  int time;

  List<Widget> buildDots() {
    final dots = <Widget>[];

    for (int i = 0; i < widget.number; i++) {
      if (widget.size == DotSize.small) {
        radius = widget.random.nextDouble() * 15 + 5;
      } else if (widget.size == DotSize.medium) {
        radius = widget.random.nextDouble() * 25 + 25;
      } else if (widget.size == DotSize.large) {
        radius = widget.random.nextDouble() * 50 + 50;
      } else if (widget.size == DotSize.random) {
        radius = widget.random.nextDouble() * 70 + 5;
      }
      if (widget.speed == DotSpeed.slow) {
        time = widget.random.nextInt(45) + 22;
      } else if (widget.speed == DotSpeed.medium) {
        time = widget.random.nextInt(30) + 15;
      } else if (widget.speed == DotSpeed.fast) {
        time = widget.random.nextInt(15) + 7;
      } else if (widget.speed == DotSpeed.mixed) {
        time = widget.random.nextInt(45) + 7;
      }
      dots.add(SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BackgroundGenerator(
          direction: widget.direction,
          span: widget.span == null
              ? null
              : TextSpan(
                  text: widget.span[widget.random.nextInt(widget.span.length)],
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.white.withOpacity(.5))),
          trajectory: widget.trajectory,
          image: widget.image == null
              ? ''
              : widget.image[widget.random.nextInt(widget.image.length)],
          radius: radius,
          color: widget.colors[widget.random.nextInt(widget.colors.length)]
              .withOpacity(widget.opacity),
          time: time,
        ),
      ));
    }
    return dots;
  }

  @override
  Widget build(BuildContext buildContext) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: buildDots(),
      ),
    );
  }
}

class BackgroundGenerator extends StatefulWidget {
  final Direction direction;
  final Trajectory trajectory;
  final double radius;
  final int time;
  final Color color;
  final String image;
  final TextSpan span;

  const BackgroundGenerator({
    Key key,
    @required this.image,
    @required this.direction,
    @required this.trajectory,
    @required this.radius,
    @required this.color,
    this.span,
    this.time,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BackgroundGeneratorState();
}

class BackgroundGeneratorState extends State<BackgroundGenerator>
    with SingleTickerProviderStateMixin {
  Random random = Random();
  bool _vertical;
  bool _inverseDir;
  double _initialPosition;
  double _destination;
  double _start;
  double _fraction;
  AnimationController controller;

  ui.Image image;

  bool isImageloaded = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _fraction = 0.0;
    if (widget.direction == Direction.up) {
      _vertical = true;
      _inverseDir = false;
    } else {
      _vertical = random.nextBool();
      _inverseDir = random.nextBool();
    }
    _initialPosition = random.nextDouble();
    if (widget.trajectory == Trajectory.straight) {
      _destination = _initialPosition;
    } else {
      _destination = random.nextDouble();
    }
    _start = 150 * random.nextDouble();
    controller = AnimationController(
        duration: Duration(seconds: widget.time), vsync: this);

    controller.addListener(() {
      setState(() {
        _fraction = controller.value;
      });
    });

    controller.repeat();
    if (widget.span == null) {
      init();
    } else {
      setState(() {
        isImageloaded = true;
      });
    }
  }

  @override
  void didUpdateWidget(covariant BackgroundGenerator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.direction != oldWidget.direction) {
      if (widget.direction == Direction.up) {
        _vertical = true;
        _inverseDir = false;
      } else {
        _vertical = random.nextBool();
        _inverseDir = random.nextBool();
      }
    }
    if (widget.trajectory != oldWidget.trajectory) {
      if (widget.trajectory == Trajectory.straight) {
        _destination = _initialPosition;
      } else {
        _destination = random.nextDouble();
      }
    }
    if (widget.time != oldWidget.time) {
      controller.duration = Duration(seconds: widget.time);
      controller.repeat();
    }
  }

  Future init() async {
    final ByteData data = await rootBundle.load(widget.image);
    image = await loadImage(Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });

    return completer.future;
  }

  Widget _buildImage() {
    if (isImageloaded) {
      return CustomPaint(
        painter: DotPainter(
          vertical: _vertical,
          inverseDir: _inverseDir,
          dot: image,
          span: widget.span,
          initialPosition: _initialPosition,
          destination: _destination,
          radius: widget.radius,
          start: _start,
          fraction: _fraction,
          color: widget.color,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildImage();
    // return FutureBuilder<ui.Image>(
    //     future: sunImage.obtainKey(const ImageConfiguration()).then((key) {
    //       return _loadImage(key);
    //     }),
    //     builder: (context, snapshot) {
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.waiting:
    //           return const Text('Image loading...');
    //         default:
    //           if (snapshot.hasError) {
    //             return Text('Error: ${snapshot.error}');
    //           } else {
    //             return CustomPaint(
    //               painter: DotPainter(
    //                 vertical: _vertical,
    //                 inverseDir: _inverseDir,
    //                 image: snapshot.data,
    //                 initialPosition: _initialPosition,
    //                 destination: _destination,
    //                 radius: widget.radius,
    //                 start: _start,
    //                 fraction: _fraction,
    //                 color: widget.color,
    //               ),
    //             );
    //           }
    //       }
    //     });
  }
}

class DotPainter extends CustomPainter {
  bool vertical;
  bool inverseDir;
  double initialPosition;
  double destination;
  double radius;
  double start;
  double diameter;
  double distance;
  double fraction;
  Color color;
  bool isText;
  final Paint _paint;
  TextSpan span;

  ui.Image dot;
  DotPainter({
    this.dot,
    this.span,
    this.vertical,
    this.inverseDir,
    this.isText,
    this.initialPosition,
    this.destination,
    this.radius,
    this.start,
    this.fraction,
    this.color,
  }) : _paint = Paint() {
    _paint.color = color;
    diameter = radius * 2;
    distance = destination - initialPosition;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset;

    if (!vertical && inverseDir) {
      offset = Offset(
          -start - radius + (size.width + diameter + start) * fraction,
          size.height * (initialPosition + distance * fraction));
    } else if (vertical && inverseDir) {
      offset = Offset(size.width * (initialPosition + distance * fraction),
          -start - radius + (size.height + diameter + start) * fraction);
    } else if (!vertical && !inverseDir) {
      offset = Offset(
          size.width +
              start +
              radius -
              (size.width + diameter + start) * fraction,
          size.height * (initialPosition + distance * fraction));
    } else if (vertical && !inverseDir) {
      offset = Offset(
          size.width * (initialPosition + distance * fraction),
          size.height +
              start +
              radius -
              (size.height + diameter + start) * fraction);
    }

    // ByteData data = image.toByteData();
    if (span != null) {
      final textPainter = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      textPainter.paint(canvas, offset);
    } else {
      canvas.drawImage(dot, offset, _paint);
    }

    // canvas.drawCircle(offset, radius, _paint);
    // canvas.drawImage(image, offset, _paint);
    // svg.draw(canvas, Rect.fromCircle(center: offset, radius: radius));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum Direction {
  up,
  random,
}

enum Trajectory {
  straight,
  random,
}

enum DotSize {
  small,
  medium,
  large,
  random,
}

enum DotSpeed {
  slow,
  medium,
  fast,
  mixed,
}
