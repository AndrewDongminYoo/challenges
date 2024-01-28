/// This example code can be run immediately
/// via the dartpad at the following address.
/// Author: AndrewDongminYoo<ydm2790@gmail.com>
/// https://dartpad.dev/?id=6092cf39c283b94ced48fafc188636a1

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
      home: AutoFocusTextField(),
    );
  }
}

class AutoFocusTextField extends StatefulWidget {
  const AutoFocusTextField({super.key});

  @override
  State<AutoFocusTextField> createState() => _AutoFocusTextFieldState();
}

class _AutoFocusTextFieldState extends State<AutoFocusTextField> {
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final renderKey = GlobalKey();
  final controller = TextEditingController(text: 'Hello');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello TextField!',
          style: GoogleFonts.notoSansKr(fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        width: width,
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextFormField(
                key: renderKey,
                controller: controller,
                focusNode: focusNode1,
                onChanged: (value) {
                  final formLength = renderKey.currentContext!.size!.width;
                  final textLength = controller.value.text.length * 10;
                  if (formLength < textLength) {
                    focusNode2.requestFocus();
                  }
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: TextFormField(
                initialValue: 'FlutterBoot!',
                focusNode: focusNode2,
                onChanged: (value) {
                  if (value.isEmpty) {
                    focusNode1.requestFocus();
                  }
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
