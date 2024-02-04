/// This example code can be run immediately
/// via the dartpad at the following address.
/// Author: AndrewDongminYoo<ydm2790@gmail.com>
/// https://dartpad.dev/?id=0da630db490a658ab8a8d19db197937c

// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rolling Star',
      home: Scaffold(body: RollingStarAnimation()),
    );
  }
}

class RollingStarAnimation extends StatefulWidget {
  const RollingStarAnimation({super.key});

  @override
  State<RollingStarAnimation> createState() => _RollingStarAnimationState();
}

class _RollingStarAnimationState extends State<RollingStarAnimation>
    with TickerProviderStateMixin {
  late AnimationController _rollController;
  late Animation<double> _rollAnimation;
  double top = 0;
  double left = -30;

  @override
  void initState() {
    super.initState();

    _rollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _rollAnimation = Tween<double>(
      begin: 0,
      end: 15 * pi,
    ).animate(_rollController);

    _rollController.repeat();
  }

  @override
  void dispose() {
    _rollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        Positioned(
          top: top, // Adjust the initial vertical position
          left: left, // Start off-screen to the left
          child: AnimatedBuilder(
            animation: _rollAnimation,
            builder: (context, child) {
              final screen = MediaQuery.sizeOf(context);

              // Calculate left position based on the animation value
              final leftPosition = (_rollAnimation.value * 100) % screen.width;

              // Calculate top position based on the animation value and screen height
              final topPosition = (_rollAnimation.value % (2 * pi)) /
                  (2 * pi) *
                  screen.height; // Adjust the factor as needed

              return Positioned(
                top: topPosition,
                left: leftPosition,
                child: Transform.rotate(
                  angle: _rollAnimation.value,
                  child: _buildStar(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStar() {
    return CustomPaint(
      painter: StarPainter(),
      size: const Size(20, 20),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    final radius = size.width / 2;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Calculate the outer points of the star
    final outerPoints = <Offset>[];
    for (var i = 0; i < 5; i++) {
      final angle = (i * 2 * pi / 5) - (pi / 2);
      outerPoints.add(
        Offset(centerX + radius * cos(angle), centerY + radius * sin(angle)),
      );
    }

    // Draw the star
    for (var i = 0; i < 5; i++) {
      canvas.drawLine(outerPoints[i], outerPoints[(i + 2) % 5], paint);
    }
  }

  @override
  // covariant(공변량)는 일반 유형 매개변수가 공변적으로 변할 수 있음을 나타냅니다.
  // 하위 유형 인자(예: List<Cat>)가 있는 제네릭 유형을 상위 유형 인자(예: List<Animal>)가 있는 제네릭 유형의 하위 유형으로 취급할 수 있습니다.
  // 이를 통해 보다 유연하고 재사용 가능한 제네릭 코드를 작성할 수 있습니다.
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
