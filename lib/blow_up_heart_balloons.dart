/// This example code can be run immediately
/// via the dartpad at the following address.
/// Author: AndrewDongminYoo<ydm2790@gmail.com>
/// https://dartpad.dev/?id=82f21e52a8fc6fc0ee8846608fbce587

// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blow Up Heart Balloons',
      home: BlowUpHeartBalloons(),
    );
  }
}

const src =
    'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https://blog.kakaocdn.net/dn/13qh9/btrXwiu0qp4/gmWplBPh3eWp50gZbHq8zK/img.png';

class BlowUpHeartBalloons extends StatefulWidget {
  const BlowUpHeartBalloons({super.key});

  @override
  State<BlowUpHeartBalloons> createState() => _BlowUpHeartBalloonsState();
}

class _BlowUpHeartBalloonsState extends State<BlowUpHeartBalloons> {
  final NetworkImage _background = const NetworkImage(src);
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _background,
            fit: BoxFit.cover,
          ),
        ),
      ),
      floatingActionButton: InkWell(
        key: _key,
        onTap: blowHeart,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: const Color(0xFFE93D1E)),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white54,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.suit_heart_fill,
              color: Color(0xFFE93D1E),
              size: 40,
            ),
          ),
        ),
      ),
    );
  }

  void blowHeart() {
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        final renderBox = _key.currentContext!.findRenderObject()! as RenderBox;
        final beginOffset = renderBox.localToGlobal(Offset.zero);

        return HeartBalloon(
          offset: beginOffset,
          entry: overlayEntry,
          arrival: MediaQuery.sizeOf(context).height / 2,
        );
      },
    );

    Overlay.of(context).insert(overlayEntry);
  }
}

class HeartBalloon extends StatefulWidget {
  const HeartBalloon({
    super.key,
    required this.offset,
    required this.entry,
    required this.arrival,
  });

  final Offset offset;
  final OverlayEntry? entry;
  final double arrival;

  @override
  State<HeartBalloon> createState() => _HeartBalloonState();
}

class _HeartBalloonState extends State<HeartBalloon>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationX;
  late Animation<double> _animationY;
  late double _currentX;
  late double _currentY;
  late double _iconSize;
  late Color _iconColor;

  int genInteger(int maxValue) {
    return Random().nextInt(maxValue);
  }

  double genDouble(int maxValue) {
    return Random().nextDouble() * maxValue;
  }

  Color getRandomColor() {
    return Color.fromRGBO(
      genInteger(256),
      genInteger(25),
      genInteger(25),
      genDouble(1),
    );
  }

  double getRandomSize() {
    return 30 + genDouble(30);
  }

  /// 이 함수는 중심점을 중심으로 무언가를 지정된 횟수만큼 수평으로 앞뒤로 움직이는 데 필요한 애니메이션 값을 생성합니다.
  TweenSequence<double> generateOscillatingTweenSequence(
    double position,
    int count,
  ) {
    final items = <TweenSequenceItem<double>>[];

    for (var i = 0; i < count; i++) {
      final gap = 2 + genInteger(80) / 10;
      items.add(
        TweenSequenceItem<double>(
          tween: Tween<double>(
            // 각 루프에서 임의의 간격을 계산하여 위치의 왼쪽 또는 오른쪽으로 이동합니다.
            begin: position + (i.isEven ? -gap : gap),
            // 좌우 반복을 위해 각 루프에서 임의의 간격을 계산하여 반대 위치를 지정합니다.
            end: position + (i.isEven ? gap : -gap),
          ),
          // 가중치 값은 애니메이션의 각 부분에 얼마나 많은 상대적 시간이 소요되는지를 결정합니다.
          weight: 20,
        ),
      );
    }
    // Flutter에서는 시간에 따라 값이 변하는 애니메이션을 정의할 때 TweenSequence를 사용합니다.
    // TweenSequence를 빌드하는 데는 약간의 비용이 들기 때문에
    // 가능하면 매 프레임마다 다시 빌드하는 것보다 한 번 빌드한 것을 재사용하는 것이 좋습니다.
    return TweenSequence<double>(items);
  }

  @override
  void initState() {
    super.initState();

    _currentX = widget.offset.dx - 10 + genInteger(30);
    _currentY = widget.offset.dy;

    _iconColor = getRandomColor();
    _iconSize = getRandomSize();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();

    _animationX =
        // 애니메이션X는 트윈 시퀀스를 사용하여 x 위치를 앞뒤로 수평으로 움직이는 애니메이션을 만듭니다.
        // 이렇게 하면 하트 아이콘이 위로 떠오르면서 좌우로 흔들립니다.
        generateOscillatingTweenSequence(_currentX, 8).animate(_controller);

    _animationY = Tween<double>(
      begin: widget.offset.dy,
      end: widget.arrival,
    ).animate(_controller)
      ..addListener(() {
        // 애니메이션Y가 실행되면 애니메이션 값을 적용하기 위해
        // _currentX 및 _currentY 상태 변수가 업데이트됩니다.
        // 이렇게 하면 하트 아이콘이 매 프레임마다 위치를 이동합니다.
        setState(() {
          _currentX = _animationX.value;
          _currentY = _animationY.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            // animationY가 완료되면 오버레이 항목이 제거되어 떠 있는 하트 아이콘이 닫힙니다.
            widget.entry?.remove();
          });
        }
      });
    // 결과적으로 하트는 탭 위치에서 지정된 도착 높이까지 5초 동안 떠 있다가 자동으로 닫힙니다.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_currentX, _currentY),
              child: Icon(
                CupertinoIcons.suit_heart_fill,
                size: _iconSize,
                color: _iconColor,
              ),
            );
          },
        ),
      ],
    );
  }
}
