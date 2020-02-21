import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A simple day / night switch widget.
class DayNightSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DayNightSwitchState();
}

/// The day night switch state.
class _DayNightSwitchState extends _DayNightSwitchBaseState<DayNightSwitch> {
  @override
  CustomPainter createCustomPainter(BuildContext context) => _DayNightPainter(progress: progress);

  @override
  double get width => 100;
}

/// A simple day / night switch widget (but smaller than the other one).
class DayNightSwitchIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DayNightSwitchIconState();
}

/// The day night switch state.
class _DayNightSwitchIconState extends _DayNightSwitchBaseState<DayNightSwitchIcon> {
  /// Creates a new day night switch icon state.
  _DayNightSwitchIconState() : super(padding: const EdgeInsets.symmetric(vertical: 12));

  @override
  CustomPainter createCustomPainter(BuildContext context) => _DayNightIconPainter(progress: progress);

  @override
  double get width => 36;
}

/// The base state for every day / night switch widget.
abstract class _DayNightSwitchBaseState<T extends StatefulWidget> extends State<T> with TickerProviderStateMixin {
  /// The animation progress.
  double progress;

  /// The animation controller.
  AnimationController controller;

  /// The animation instance.
  Animation<double> animation;

  /// The widget outer padding.
  final EdgeInsetsGeometry padding;

  /// Creates a new day night switch state.
  _DayNightSwitchBaseState({
    this.padding = const EdgeInsets.symmetric(vertical: 10),
  });

  @override
  void initState() {
    super.initState();
    progress = Provider.of<SettingsModel>(context, listen: false).darkModeEnabled ? 1.0 : 0.0;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: SizedBox(
          height: double.infinity,
          width: width,
          child: Consumer<SettingsModel>(
            builder: (context, settingsModel, _) => GestureDetector(
              onTap: () {
                controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
                animation = Tween(begin: progress, end: progress > 0.0 ? 0.0 : 1.0).animate(controller)
                  ..addListener(() {
                    if (mounted) {
                      setState(() => progress = animation.value);
                    }
                  });

                bool enableDarkMode = progress == 0.0;
                controller.addStatusListener((status) async {
                  if (status == AnimationStatus.completed) {
                    settingsModel.darkModeEnabled = enableDarkMode;
                    await settingsModel.flush();
                  }
                });
                controller.forward();
              },
              child: CustomPaint(
                painter: createCustomPainter(context),
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  /// The widget width.
  double get width;

  /// Creates the corresponding custom painter.
  CustomPainter createCustomPainter(BuildContext context);
}

/// The day / night widget painter.
class _DayNightPainter extends CustomPainter {
  /// The widget inner padding.
  final double padding;

  /// The progress.
  final double progress;

  /// Creates a new day / night painter instance.
  _DayNightPainter({
    this.padding = 5,
    @required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.height / 2;

    double sunLeft = (size.width - 2 * (radius));
    double left = progress * sunLeft + radius;

    double top = radius;
    Color backgroundColor = utils.mixColors(_Colors.DAY_BACKGROUND_COLOR, _Colors.NIGHT_BACKGROUND_COLOR, progress);

    Rect background = Rect.fromLTWH(0, 0, size.width, size.height);
    RRect shape = RRect.fromRectAndRadius(background, Radius.circular(radius));

    canvas.clipRRect(shape, doAntiAlias: true);
    canvas.drawRect(
      background,
      Paint()..color = backgroundColor,
    );

    drawCloud(canvas, size, sunLeft);
    drawCloud(canvas, size, sunLeft, 2.5, 2);

    canvas.drawCircle(
      Offset(left, top),
      radius - padding,
      Paint()..color = utils.mixColors(_Colors.SUN_COLOR, _Colors.MOON_COLOR, progress),
    );

    drawCloud(canvas, size, sunLeft, 4, 4, 2);

    drawCrater(canvas, radius, left);
    drawCrater(canvas, radius, left, 12, 1);

    canvas.drawCircle(
      Offset(left - radius * 2 + padding * 2 + progress * radius, top - (progress / 2) * radius + padding),
      radius - padding,
      Paint()..color = backgroundColor,
    );

    drawStar(canvas, size);
    drawStar(canvas, size, 4, 2);
    drawStar(canvas, size, 1.5, 2.3, size.height / 15);
  }

  @override
  bool shouldRepaint(_DayNightPainter oldDelegate) => progress != oldDelegate.progress || padding != oldDelegate.padding;

  /// Draws a cloud.
  void drawCloud(Canvas canvas, Size size, double sunLeft, [double topDivisor = 10, double moonLeftDivisor = 8, double sunLeftDivisor = 1.8]) {
    double height = size.height / 10;
    double width = size.width / 2.5;

    canvas.drawOval(
      Rect.fromLTWH(
        utils.mixDoubles(sunLeft + padding - (size.width / sunLeftDivisor), padding + (size.width / moonLeftDivisor), progress),
        padding + size.height / topDivisor,
        utils.mixDoubles(width, height, progress),
        height,
      ),
      Paint()..color = _Colors.CLOUDS_COLOR,
    );
  }

  /// Draws a star.
  void drawStar(Canvas canvas, Size size, [double topDivisor = 1.4, double leftDivisor = 5, double radius]) {
    canvas.drawCircle(
      Offset(size.width / leftDivisor, size.height / topDivisor),
      utils.mixDoubles(0, radius ?? size.height / 10, progress),
      Paint()..color = _Colors.STARS_COLOR,
    );
  }

  /// Draws a moon crater.
  void drawCrater(Canvas canvas, double radius, double left, [double leftDivisor = 2, double topDivisor = 2]) {
    canvas.drawCircle(
      Offset(left + radius / leftDivisor, padding + radius / topDivisor),
      radius / 5,
      Paint()..color = utils.mixColors(Colors.transparent, _Colors.CRATERS_COLOR, progress),
    );
  }
}

class _DayNightIconPainter extends CustomPainter {
  /// The widget inner padding.
  final double padding;

  /// The progress.
  final double progress;

  /// Creates a new day / night icon painter instance.
  _DayNightIconPainter({
    this.padding = 5,
    @required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.height / 2;
    Offset center = Offset(size.width / 2, radius);
    Color backgroundColor = utils.mixColors(_Colors.DAY_BACKGROUND_COLOR, _Colors.NIGHT_BACKGROUND_COLOR, progress);

    canvas.clipRRect(RRect.fromRectAndRadius(Rect.fromCircle(center: center, radius: radius), Radius.circular(radius)));

    canvas.drawCircle(
      center,
      radius,
      Paint()..color = backgroundColor,
    );

    canvas.drawCircle(
      Offset((size.width / 2), radius),
      radius - padding,
      Paint()..color = utils.mixColors(_Colors.SUN_COLOR, _Colors.MOON_COLOR, progress),
    );

    drawCrater(canvas, size);
    drawCrater(canvas, size, 11, 1.6, 1.6);

    drawCloud(canvas, size, 12, 2.6);
    drawCloud(canvas, size);

    canvas.drawCircle(
      Offset(progress * (size.width / 3), progress * (size.height / 3)),
      radius - padding,
      Paint()..color = backgroundColor,
    );
  }

  /// Draws a cloud.
  void drawCloud(Canvas canvas, Size size, [double leftDivisor = 7, double topDivisor = 2, double heightDivisor = 10, double widthDivisor = 2]) {
    canvas.drawOval(
      Rect.fromLTWH(
        size.width / leftDivisor,
        size.height / topDivisor,
        size.width / widthDivisor,
        size.height / heightDivisor,
      ),
      Paint()..color = utils.mixColors(_Colors.CLOUDS_COLOR, Colors.transparent, progress),
    );
  }

  /// Draws a moon crater.
  void drawCrater(Canvas canvas, Size size, [double radiusDivisor = 8, double heightDivisor = 2.5, double widthDivisor = 3]) {
    canvas.drawCircle(
      Offset(size.width / widthDivisor, size.height / heightDivisor),
      size.height / radiusDivisor,
      Paint()..color = utils.mixColors(Colors.transparent, _Colors.CRATERS_COLOR, progress),
    );
  }

  @override
  bool shouldRepaint(_DayNightIconPainter oldDelegate) => progress != oldDelegate.progress || padding != oldDelegate.padding;
}

/// Widget common colors.
class _Colors {
  /// The day background color.
  static const Color DAY_BACKGROUND_COLOR = Color(0xFF3498DB);

  /// The night background color.
  static const Color NIGHT_BACKGROUND_COLOR = Color(0xFF192734);

  /// The sun color.
  static const Color SUN_COLOR = Color(0xFFFFCF96);

  /// The moon color.
  static const Color MOON_COLOR = Color(0xFFFFE5B5);

  /// The stars color.
  static const Color STARS_COLOR = Colors.white;

  /// The clouds color.
  static const Color CLOUDS_COLOR = Colors.white;

  /// The craters color.
  static const Color CRATERS_COLOR = Color(0xFFE8CDA5);
}
