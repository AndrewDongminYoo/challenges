/// This example code can be run immediately
/// via the dartpad at the following address.
/// Author: AndrewDongminYoo<ydm2790@gmail.com>
/// https://dartpad.dev/?id=d2e0092cf5b61e3b1640fdb3c52f997f

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
      title: 'Fancy Glowy Button',
      home: FancyGlowyButton(),
    );
  }
}

class FancyGlowyButton extends StatefulWidget {
  const FancyGlowyButton({super.key});

  @override
  State<FancyGlowyButton> createState() => _FancyGlowyButtonState();
}

class _FancyGlowyButtonState extends State<FancyGlowyButton>
    with SingleTickerProviderStateMixin {
  final duration = const Duration(seconds: 3);
  late AnimationController _controller;
  late Animation<Color?> shadowColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: duration,
      animationBehavior: AnimationBehavior.preserve,
    )..repeat();
    shadowColor = ColorTween(
      begin: const Color(0xFFFF5F1F),
      end: const Color(0xFFFF9800),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                boxShadow: [
                  const BoxShadow(
                    color: Color(0xFFFF481F),
                    spreadRadius: 6,
                    blurRadius: 4,
                  ),
                  const BoxShadow(
                    color: Color(0xFFFF481F),
                    spreadRadius: -6,
                    blurRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset.fromDirection(_controller.value * 4, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Text(
                'Fancy Glowy Button\n'
                'Click Me 😎',
                style: GoogleFonts.lobster(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(color: shadowColor.value!, blurRadius: 10),
                    Shadow(color: shadowColor.value!, blurRadius: 5),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
