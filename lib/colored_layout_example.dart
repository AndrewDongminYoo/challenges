/// This example code can be run immediately
/// via the dartpad at the following address.
/// Author: AndrewDongminYoo<ydm2790@gmail.com>
/// https://dartpad.dev/?id=eeb77afc9cb9fea29662a61d622670f0

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'I can layout like this',
      home: Scaffold(body: ColoredLayoutExample()),
    );
  }
}

class ColoredLayoutExample extends StatefulWidget {
  const ColoredLayoutExample({super.key});

  @override
  State<ColoredLayoutExample> createState() => _ColoredLayoutExampleState();
}

class _ColoredLayoutExampleState extends State<ColoredLayoutExample> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('I can layout this'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: size.width / 2,
                  width: size.width / 2,
                  color: Colors.grey,
                ),
                Column(
                  children: [
                    Container(
                      height: size.width / 4,
                      width: size.width / 2,
                      color: Colors.blue,
                    ),
                    Container(
                      height: size.width / 4,
                      width: size.width / 2,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: size.width / 2,
                  width: size.width / 2,
                  child: Column(
                    children: [
                      Expanded(flex: 2, child: Container(color: Colors.white)),
                      Expanded(child: Container(color: Colors.green)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: size.width / 2,
                      width: size.width / 2,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                            ),
                            child: Container(
                              height: size.width / 4 - 10,
                              width: size.width / 2 - 10,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: size.width * 4,
              child: Expanded(
                child: Column(
                  children: [
                    Container(height: size.height / 4, color: Colors.yellow),
                    Container(height: size.height / 6, color: Colors.brown),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
