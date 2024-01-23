// 🎯 Dart imports:
import 'dart:async';
import 'dart:ui';

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
      home: TapToScoreGame(),
    );
  }
}

class TapToScoreGame extends StatefulWidget {
  const TapToScoreGame({super.key});

  @override
  State<TapToScoreGame> createState() => _TapToScoreGameState();
}

class _TapToScoreGameState extends State<TapToScoreGame> {
  final double maxBarHeight = 400;
  late Timer gaugeTimer;
  int score = 0;
  double gaugeHeight = 0;
  bool isTapping = false;

  @override
  void initState() {
    super.initState();
    gaugeTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        if (!isTapping) {
          if (gaugeHeight > 25.0) {
            setState(() {
              gaugeHeight -= 25.0;
            });
          } else {
            setState(() {
              gaugeHeight = 0;
              score = 0;
            });
          }
        }
      },
    );
  }

  @override
  void dispose() {
    gaugeTimer.cancel();
    super.dispose();
  }

  void _incrementGauge() {
    if (gaugeHeight < maxBarHeight - 50.0) {
      setState(() {
        gaugeHeight += 50.0;
      });
    } else {
      setState(() {
        gaugeHeight = maxBarHeight;
      });
    }
    if (gaugeHeight > 0.9 * maxBarHeight) {
      setState(() {
        score++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap To Score Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: maxBarHeight,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: AnimatedFractionallySizedBox(
                alignment: Alignment.bottomCenter,
                duration: const Duration(milliseconds: 100),
                heightFactor: gaugeHeight / maxBarHeight,
                child: Container(
                  width: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFADD6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTapDown: (_) {
                isTapping = true;
                setState(() {});
                _incrementGauge();
              },
              onTapUp: (_) {
                isTapping = false;
                setState(() {});
              },
              child: Container(
                height: 50,
                width: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFADD6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '+',
                    style: GoogleFonts.sourceCodePro(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your Score',
              style: GoogleFonts.roboto(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$score',
              style: GoogleFonts.sourceCodePro(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                fontFeatures: [const FontFeature.slashedZero()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
