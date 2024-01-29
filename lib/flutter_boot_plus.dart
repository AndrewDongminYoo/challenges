/// This example code can be run immediately
/// via the dartpad at the following address.
/// Author: AndrewDongminYoo<ydm2790@gmail.com>
/// https://dartpad.dev/?id=7f52e59b9167457fa5ff80763cc20a5a

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
      title: 'FlutterBoot Plus',
      home: FlutterBootPlus(),
    );
  }
}

class FlutterBootPlus extends StatefulWidget {
  const FlutterBootPlus({super.key});

  @override
  State<FlutterBootPlus> createState() => _FlutterBootPlusState();
}

class _FlutterBootPlusState extends State<FlutterBootPlus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 35),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                'FlutterBoot Plus',
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Feature(
              icon: CupertinoIcons.bolt_fill,
              title: 'Quickstart templates',
              content:
                  'You can deploy an AI app in seconds on Vercel, using our pre-built templates.',
            ),
            const Feature(
              icon: CupertinoIcons.flame_fill,
              title: 'Optimized compute',
              content:
                  'Deliver globally performant apps without additional infrastructure complexity.',
            ),
            const Feature(
              icon: Icons.speed,
              title: 'Zero-config streaming',
              content:
                  'Easily stream long-running LLM responses for a better user experience.',
            ),
            const Spacer(),
            const Text(
              'Restore subscription',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            const Text(r'Auto-renews for $25/month until canceled'),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                fixedSize: Size(MediaQuery.sizeOf(context).width, 35),
                splashFactory: NoSplash.splashFactory,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
              ),
              onPressed: () {},
              child: const Text(
                'Subscribe',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Feature extends StatelessWidget {
  const Feature({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: Icon(icon),
            iconSize: 30,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            onPressed: () {},
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
