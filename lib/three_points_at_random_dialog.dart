/// This example code can be run immediately
/// via the dartpad at the following address.
/// Author: AndrewDongminYoo<ydm2790@gmail.com>
/// https://dartpad.dev/?id=bdc7814f180531073bc9db4d0d0ca69c

// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
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
      title: 'Three Points At Random Dialog',
      home: ThreePointsAtRandomDialog(),
    );
  }
}

class ThreePointsAtRandomDialog extends StatefulWidget {
  const ThreePointsAtRandomDialog({super.key});

  @override
  State<ThreePointsAtRandomDialog> createState() =>
      _ThreePointsAtRandomDialogState();
}

class _ThreePointsAtRandomDialogState extends State<ThreePointsAtRandomDialog> {
  int score = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<int>(
              duration: const Duration(milliseconds: 300),
              tween: IntTween(begin: 0, end: score),
              builder: (context, value, child) {
                return Text(
                  'Your Point: $value',
                  style: GoogleFonts.firaCode(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: Text(
                'I want more points!',
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Choose your next point!!',
                        style: GoogleFonts.firaCode(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: Text(
                        'Choose one of the points below!\n'
                        "If you don't make a selection, your current score will be retained.",
                        style: GoogleFonts.firaSans(),
                      ),
                      actions: [
                        _buildChoice(context),
                        _buildChoice(context),
                        _buildChoice(context),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoice(BuildContext context) {
    final value = Random().nextInt(100);
    return TextButton(
      child: Text(
        '$value',
        style: GoogleFonts.firaCode(
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: () {
        setState(() {
          score += value;
          Navigator.pop(context, value);
        });
      },
    );
  }
}
