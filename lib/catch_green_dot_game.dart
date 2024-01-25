// 🎯 Dart imports:
import 'dart:async';
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: CatchGreenDotGame(),
    );
  }
}

class CatchGreenDotGame extends StatefulWidget {
  const CatchGreenDotGame({super.key});

  @override
  State<CatchGreenDotGame> createState() => _CatchGreenDotGameState();
}

class _CatchGreenDotGameState extends State<CatchGreenDotGame> {
  // 타이머 관련 상태
  int _elapsedTime = 0;
  Timer? _timer;

  // 녹색원 관련 상태
  double _circleX = 0;
  double _circleY = 0;
  bool _showCircle = false;
  final double _circleRadius = 30;
  final _milliseconds = const Duration(milliseconds: 1);

  // 타이머 시작
  void _startTimer() {
    _setPosition();
    _showCircle = true;
    _elapsedTime = 0;
    _timer = Timer.periodic(_milliseconds, (timer) {
      setState(() {
        _elapsedTime++; // 1ms씩 증가
      });
    });
  }

  // 타이머 정지
  void _stopTimer() {
    _showCircle = false;
    _timer?.cancel();
    _timer = null;
    setState(() {});
  }

  // 랜덤한 원의 위치 선정
  void _setPosition() {
    _circleX = Random().nextDouble() * 300;
    _circleY = Random().nextDouble() * 500;
    print('X: $_circleX, Y: $_circleY');
  }

  // 탭 이벤트 체크
  void _onTap(TapDownDetails tapped) {
    // 탭된 위치
    print('Tapped: ${tapped.localPosition}');
    // 녹색원 위치
    final circle = Offset(_circleX, _circleY);
    // 둘 사이의 거리가 원의 크기보다 작으면 탭 성공
    if ((circle - tapped.localPosition).distance < 30) {
      print('SUCCESS!!!!!!!!');
      _stopTimer(); // 타이머 정지
    }
  }

  String _formatTime(int millis) {
    var s = millis ~/ 1000;
    final m = s ~/ 60;
    final ms = millis % 1000;
    s = s % 60;
    return '${m.padZero(2)}:${s.padZero(2)}.${ms.padZero(3)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catch Green Game',
          style: GoogleFonts.firaCode(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _showCircle ? null : _startTimer,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE6E6FA),
            ),
            child: Text(
              'Start!',
              style: GoogleFonts.firaCode(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF371C4B),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(_formatTime(_elapsedTime), style: GoogleFonts.firaCode()),
          GestureDetector(
            onTapDown: _onTap,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
                Visibility(
                  visible: _showCircle,
                  child: CustomPaint(
                    painter: CirclePainter(
                      circleX: _circleX,
                      circleY: _circleY,
                      radius: _circleRadius,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  const CirclePainter({
    required this.circleX,
    required this.circleY,
    required this.radius,
  });

  final double circleX;
  final double circleY;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    canvas.drawCircle(Offset(circleX, circleY), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

extension on num {
  String padZero(int digit) {
    return toString().padLeft(digit, '0');
  }
}
