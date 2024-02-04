/// This example code can be run immediately
/// via the dartpad at the following address.
/// Author: AndrewDongminYoo<ydm2790@gmail.com>
/// https://dartpad.dev/?id=19c668f491b1be50bb363ecffd308e6d

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Year of discovery for each celestial object',
      home: const CelestialDiscovery(),
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.purple,
        textTheme: GoogleFonts.notoSansKrTextTheme(),
      ),
    );
  }
}

// cSpell:ignore Hongdaeyong,YORP,Choemuseon
final spaceData = {
  'NGC 162': 1862,
  '87 Sylvia': 1866,
  'R 136a1': 1985,
  '28978 Ixion': 2001,
  'NGC 6715': 1778,
  '94400 Hongdaeyong': 2001,
  '6354 Vangelis': 1934,
  'C/2020 F3': 2020,
  'Cartwheel Galaxy': 1941,
  'Sculptor Dwarf Elliptical Galaxy': 1937,
  'Eight-Burst Nebula': 1835,
  'Rhea': 1672,
  'C/1702 H1': 1702,
  'Messier 5': 1702,
  'Messier 50': 1711,
  'Cassiopeia A': 1680,
  'Great Comet of 1680': 1680,
  'Butterfly Cluster': 1654,
  'Triangulum Galaxy': 1654,
  'Comet of 1729': 1729,
  'Omega Nebula': 1745,
  'Eagle Nebula': 1745,
  'Small Sagittarius Star Cloud': 1764,
  'Dumbbell Nebula': 1764,
  '54509 YORP': 2000,
  'Dia': 2000,
  '63145 Choemuseon': 2000,
};

class CelestialDiscovery extends StatefulWidget {
  const CelestialDiscovery({super.key});

  @override
  State<CelestialDiscovery> createState() => _CelestialDiscoveryState();
}

class _CelestialDiscoveryState extends State<CelestialDiscovery> {
  final _entries = spaceData.entries.toList()
    ..sort((a, b) => a.value.compareTo(b.value));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Year of discovery!',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.purple.shade50,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView(
          primary: true,
          children: _entries.map((e) {
            return Info(data: e);
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(CupertinoIcons.arrowtriangle_up_fill),
        onPressed: () => context.scrollToTop(),
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.data,
  });

  final MapEntry<String, int> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        '🛰️ ${data.key} was discovered in ${data.value}',
      ),
    );
  }
}

extension on BuildContext {
  void scrollToTop() {
    PrimaryScrollController.maybeOf(this)?.animateTo(
      /** top offset */ 0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceIn,
    );
  }
}
