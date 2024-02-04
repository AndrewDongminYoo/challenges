/// This example code can be run immediately
/// via the dartpad at the following address.
/// Author: AndrewDongminYoo<ydm2790@gmail.com>
/// https://dartpad.dev/?id=0d1d82c470aa780ca1cac4dbb0738755

// 🎯 Dart imports:
import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
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
      title: 'Left Or Right?',
      home: TinderSwipeCard(),
    );
  }
}

class TinderSwipeCard extends StatefulWidget {
  const TinderSwipeCard({super.key});

  @override
  State<TinderSwipeCard> createState() => _TinderSwipeCardState();
}

class _TinderSwipeCardState extends State<TinderSwipeCard> {
  final cards = profiles.map(TinderProfileCard.new).toList();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CardSwiper(
          cardsCount: cards.length,
          cardBuilder: (
            context,
            index,
            horizontalThresholdPercentage,
            verticalThresholdPercentage,
          ) {
            return cards[index];
          },
        ),
      ),
    );
  }
}

class TinderProfileCard extends StatelessWidget {
  const TinderProfileCard(
    this.profile, {
    super.key,
  });
  final GradientCard profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network(profile.image).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: GoogleFonts.notoSansKr(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  profile.job,
                  style: GoogleFonts.notoSansKr(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  profile.bio,
                  style: GoogleFonts.notoSansKr(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GradientCard {
  const GradientCard({
    required this.name,
    required this.job,
    required this.bio,
    required this.image,
  });

  final String name;
  final String job;
  final String bio;
  final String image;
}

const List<GradientCard> profiles = [
  GradientCard(
    name: 'Kim, 29',
    job: 'Developer',
    bio: '난 가끔... 아무도 몰래 바닷가를 다녀와요. 그런데 둘이 가서 혼자 돌아옵니다.',
    image: 'https://images.unsplash.com/photo-1705899354898-bbc30144e432',
  ),
  GradientCard(
    name: 'Cho, 32',
    job: 'Manager',
    bio: '대화와 협상을 통한 문제해결을 좋아하는 be폭력주의자 PM 입니다.',
    image: 'https://images.unsplash.com/photo-1706354924674-0304751469e8',
  ),
  GradientCard(
    name: 'Lee, 23',
    job: 'Engineer',
    bio: '저는 제주(Jeju)도(island)에서 귀여운 (cute) 강아지(puppy)와 함께 살고(live) 있습니다.',
    image: 'https://images.unsplash.com/photo-1669442458571-d13cd471e307',
  ),
  GradientCard(
    name: 'Park, 34',
    job: 'Designer',
    bio: '히히히히 휴가 중이니까 말 시키지 마세요 꺄아',
    image: 'https://images.unsplash.com/photo-1704267619900-d22f2061682d',
  ),
];

class CardSwiper extends StatefulWidget {
  const CardSwiper({
    required this.cardBuilder,
    required this.cardsCount,
    this.controller,
    this.onTapDisabled,
    this.onSwipe,
    this.onEnd,
    this.onUndo,
    super.key,
  });

  /// 스택의 각 카드를 빌드하는 함수입니다.
  ///
  /// 이 함수는 빌드할 카드의 인덱스, 빌드 컨텍스트, [threshold]에 대한 수직 드래그의 비율(백분율), [threshold]에 대한 수평 드래그의 비율(백분율)과 함께 호출됩니다.
  /// 이 함수는 주어진 인덱스에서 카드를 나타내는 위젯을 반환해야 합니다.
  /// 이 함수는 `null`을 반환할 수 있으며, 이 경우 빈 카드가 표시됩니다.
  final Widget? Function(
    BuildContext context,
    int index,
    int horizontalOffsetPercentage,
    int verticalOffsetPercentage,
  ) cardBuilder;

  /// 스택에 있는 카드의 수입니다.
  ///
  /// [cardsCount] 매개변수는 스택에 표시할 카드의 수를 지정합니다.
  ///
  /// 이 매개변수는 필수이며 0보다 커야 합니다.
  final int cardsCount;

  /// 외부에서 스위퍼를 제어하는 데 사용되는 [SwipeController].
  ///
  /// `null`이면 스와이퍼는 사용자 입력으로만 제어할 수 있습니다.
  final SwipeController? controller;

  /// 스와이프 동작이 수행될 때 호출되는 콜백 함수입니다.
  ///
  /// 이 함수는 oldIndex, currentIndex 및 스와이프 방향과 함께 호출됩니다.
  /// 함수가 `false`를 반환하면 스와이프 동작이 취소되고 현재 카드가 스택의 맨 위에 유지됩니다.
  /// 함수가 `true`를 반환하면 예상대로 스와이프 동작이 수행됩니다.
  final FutureOr<bool> Function(
    int previousIndex,
    int? currentIndex,
    SwipeDirection direction,
  )? onSwipe;

  /// 스와이프할 카드가 더 이상 없을 때 호출되는 콜백 함수입니다.
  final FutureOr<void> Function()? onEnd;

  /// 스와이퍼가 비활성화될 때 호출되는 콜백 함수입니다.
  final FutureOr<void> Function()? onTapDisabled;

  /// 카드를 스와이프 해제할 때 호출되는 콜백 함수입니다.
  ///
  /// 이 함수는 이전 인덱스, 현재 인덱스 및 이전 스와이프 방향과 함께 호출됩니다.
  /// 함수가 `false`를 반환하면 실행 취소 작업이 취소되고 현재 카드가 스택 위에 남아 있습니다.
  /// 함수가 `true`를 반환하면 실행 취소 동작이 예상대로 수행됩니다.
  final bool Function(
    int? previousIndex,
    int currentIndex,
    SwipeDirection direction,
  )? onUndo;

  @override
  State createState() => _CardSwiperState();
}

class _CardSwiperState<T extends Widget> extends State<CardSwiper>
    with SingleTickerProviderStateMixin {
  /// 앞면 카드 뒤에 있는 카드의 배율입니다.
  ///
  /// [scale] 및 [backCardOffset]은 모두 뒷면 카드의 위치에 영향을 줍니다.
  /// [scale]을 변경한 후에도 뒷면 카드 위치를 동일하게 유지하려면 [backCardOffset]도 조정해야 합니다.
  /// * 경험상 [scale]을 0.1 변경하면 [backCardOffset]은 ~35px가 됩니다.
  ///
  /// 0에서 1 사이여야 합니다.
  /// 기본값은 `0.9`입니다.
  final double scale = 0.9;

  /// 스와이프 비활성화 여부.
  ///
  /// `true`이면 [controller]에 의해 트리거되는 경우를 제외하고 스와이프가 비활성화됩니다.
  ///
  /// 기본값은 `false`입니다.
  final bool isDisabled = false;

  /// 처음에 표시할 카드의 인덱스입니다.
  ///
  /// 기본값은 `0`으로, 스택의 첫 번째 카드가 처음에 표시됩니다.
  final int initialIndex = 0;

  /// 각 스와이프 애니메이션의 지속 시간입니다.
  ///
  /// 기본값은 `Duration(milliseconds: 200)`입니다.
  final Duration duration = const Duration(milliseconds: 200);

  /// 스와이퍼 주변의 패딩.
  ///
  /// 기본값은 `EdgeInsets.symmetric(horizontal: 20, vertical: 25)`입니다.
  final EdgeInsetsGeometry padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 25);

  /// 스와이프하는 동안 카드가 닿는 최대 각도입니다.
  ///
  /// 0도에서 360도 사이여야 합니다.
  /// 기본값은 `30`도입니다.
  final double maxAngle = 30;

  /// 카드가 스와이프되는 임계값입니다.
  ///
  /// 카드 너비의 1~100% 사이여야 합니다.
  /// 기본값은 50%입니다.
  final int threshold = 50;

  /// 카드 스택을 반복할지 여부를 결정하는 부울 값입니다.
  /// 마지막 카드를 스와이프할 때 isLoop가 `true`이면 첫 번째 카드가 다시 마지막 카드가 됩니다.
  /// 기본값은 `true`입니다.
  final bool isLoop = true;

  /// 동시에 표시되는 카드의 수를 결정하는 정수입니다.
  /// 기본값은 `2`입니다.
  /// 카드를 하나 이상 표시해야 하며 [cardsCount] 매개변수보다 많지 않아야 합니다.
  final int numberOfCardsDisplayed = 2;

  /// 앞면 카드에서 뒷면 카드의 오프셋입니다.
  ///
  /// [backCardOffset]을 변경한 후 뒷면 카드 위치를 동일하게 유지하려면 [scale]도 조정해야 합니다.
  /// * 대략적인 경험에 따르면, [backCardOffset]을 35px 변경하면 [scale]이 0.1 변경되는 효과가 있습니다.
  ///
  /// 양수 값이어야 합니다.
  /// 기본값은 `Offset(0, 40)`입니다.
  final Offset backCardOffset = const Offset(0, 40);

  late CardAnimation _cardAnimation;
  late AnimationController _animationController;

  SwipeType _swipeType = SwipeType.none;
  SwipeDirection _detectedDirection = SwipeDirection.none;
  bool _tappedOnTop = false;

  final _undoableIndex = Undoable<int?>(null);
  final Queue<SwipeDirection> _directionHistory = Queue();

  int? get _currentIndex => _undoableIndex.state;
  int? get _nextIndex => getValidIndexOffset(1);
  bool get _canSwipe => _currentIndex != null && !isDisabled;

  @override
  void initState() {
    super.initState();

    _undoableIndex.state = initialIndex;

    widget.controller?.events.listen(_controllerListener);

    _animationController = AnimationController(
      duration: duration,
      vsync: this,
    )
      ..addListener(_animationListener)
      ..addStatusListener(_animationStatusListener);

    _cardAnimation = CardAnimation(
      animationController: _animationController,
      maxAngle: maxAngle,
      initialScale: scale,
      initialOffset: backCardOffset,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: padding,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: List.generate(numberOfCardsOnScreen(), (index) {
                  if (index == 0) {
                    return _frontItem(constraints);
                  }
                  return _backItem(constraints, index);
                }).reversed.toList(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _frontItem(constraints) {
    return Positioned(
      left: _cardAnimation.left,
      top: _cardAnimation.top,
      child: GestureDetector(
        child: Transform.rotate(
          angle: _cardAnimation.angle,
          child: ConstrainedBox(
            constraints: constraints,
            child: widget.cardBuilder(
              context,
              _currentIndex!,
              (100 * _cardAnimation.left / threshold).ceil(),
              (100 * _cardAnimation.top / threshold).ceil(),
            ),
          ),
        ),
        onTap: () async {
          if (isDisabled) {
            await widget.onTapDisabled?.call();
          }
        },
        onPanStart: (tapInfo) {
          if (!isDisabled) {
            final renderBox = context.findRenderObject()! as RenderBox;
            final position = renderBox.globalToLocal(tapInfo.globalPosition);

            if (position.dy < renderBox.size.height / 2) {
              _tappedOnTop = true;
            }
          }
        },
        onPanUpdate: (tapInfo) {
          if (!isDisabled) {
            setState(
              () => _cardAnimation.update(
                tapInfo.delta.dx,
                tapInfo.delta.dy,
                _tappedOnTop,
              ),
            );
          }
        },
        onPanEnd: (tapInfo) {
          if (_canSwipe) {
            _tappedOnTop = false;
            _onEndAnimation();
          }
        },
      ),
    );
  }

  Widget _backItem(BoxConstraints constraints, int index) {
    return Positioned(
      top: (backCardOffset.dy * index) - _cardAnimation.difference.dy,
      left: (backCardOffset.dx * index) - _cardAnimation.difference.dx,
      child: Transform.scale(
        scale: _cardAnimation.scale - ((1 - scale) * (index - 1)),
        child: ConstrainedBox(
          constraints: constraints,
          child: widget.cardBuilder(context, getValidIndexOffset(index)!, 0, 0),
        ),
      ),
    );
  }

  void _controllerListener(ISwipeEvent event) {
    return switch (event) {
      SwipeEvent(:final direction) => _swipe(direction),
      UndoEvent() => _undo(),
      MoveEvent(:final index) => _moveTo(index),
    };
  }

  void _animationListener() {
    if (_animationController.status == AnimationStatus.forward) {
      setState(_cardAnimation.sync);
    }
  }

  Future<void> _animationStatusListener(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      switch (_swipeType) {
        case SwipeType.swipe:
          await _handleCompleteSwipe();
        default:
          break;
      }

      _reset();
    }
  }

  Future<void> _handleCompleteSwipe() async {
    if (await widget.onSwipe
            ?.call(_currentIndex!, _nextIndex, _detectedDirection) ==
        false) {
      return;
    }

    _undoableIndex.state = _nextIndex;
    _directionHistory.add(_detectedDirection);

    if (_currentIndex! == widget.cardsCount - 1) {
      widget.onEnd?.call();
    }
  }

  void _reset() {
    _detectedDirection = SwipeDirection.none;
    setState(() {
      _animationController.reset();
      _cardAnimation.reset();
      _swipeType = SwipeType.none;
    });
  }

  void _onEndAnimation() {
    _swipe(_getEndAnimationDirection());
  }

  SwipeDirection _getEndAnimationDirection() {
    if (_cardAnimation.left.abs() > threshold) {
      return _cardAnimation.left.isNegative
          ? SwipeDirection.left
          : SwipeDirection.right;
    }
    if (_cardAnimation.top.abs() > threshold) {
      return _cardAnimation.top.isNegative
          ? SwipeDirection.top
          : SwipeDirection.bottom;
    }
    return SwipeDirection.none;
  }

  void _swipe(SwipeDirection direction) {
    if (_currentIndex == null) {
      return;
    }
    _swipeType = SwipeType.swipe;
    _detectedDirection = direction;
    _cardAnimation.animate(context, direction);
  }

  void _undo() {
    if (_directionHistory.isEmpty) {
      return;
    }
    if (_undoableIndex.previousState == null) {
      return;
    }

    if (widget.onUndo?.call(
          _currentIndex,
          _undoableIndex.previousState!,
          _directionHistory.last,
        ) ==
        false) {
      return;
    }

    _undoableIndex.undo();
    _directionHistory.removeLast();
    _swipeType = SwipeType.undo;
    _cardAnimation.animateUndo(context, _directionHistory.last);
  }

  void _moveTo(int index) {
    if (index == _currentIndex) {
      return;
    }
    if (index < 0 || index >= widget.cardsCount) {
      return;
    }

    setState(() {
      _undoableIndex.state = index;
    });
  }

  int numberOfCardsOnScreen() {
    if (isLoop) {
      return numberOfCardsDisplayed;
    }
    if (_currentIndex == null) {
      return 0;
    }

    return math.min(
      numberOfCardsDisplayed,
      widget.cardsCount - _currentIndex!,
    );
  }

  int? getValidIndexOffset(int offset) {
    if (_currentIndex == null) {
      return null;
    }

    final index = _currentIndex! + offset;
    if (!isLoop && !(0 <= index && index <= widget.cardsCount - 1)) {
      return null;
    }
    return index % widget.cardsCount;
  }
}

class CardAnimation {
  CardAnimation({
    required this.animationController,
    required this.maxAngle,
    required this.initialScale,
    required this.initialOffset,
    this.isHorizontalSwipingEnabled = true,
    this.isVerticalSwipingEnabled = true,
    this.onSwipeDirectionChanged,
  }) : scale = initialScale;

  final double maxAngle;
  final double initialScale;
  final Offset initialOffset;
  final AnimationController animationController;
  final bool isHorizontalSwipingEnabled;
  final bool isVerticalSwipingEnabled;
  final ValueChanged<SwipeDirection>? onSwipeDirectionChanged;

  double left = 0;
  double top = 0;
  double total = 0;
  double angle = 0;
  double scale;
  Offset difference = Offset.zero;

  late Animation<double> _leftAnimation;
  late Animation<double> _topAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _differenceAnimation;

  double get _maxAngleInRadian => maxAngle * (math.pi / 180);

  void sync() {
    left = _leftAnimation.value;
    top = _topAnimation.value;
    scale = _scaleAnimation.value;
    difference = _differenceAnimation.value;
  }

  void reset() {
    animationController.reset();
    left = 0;
    top = 0;
    total = 0;
    angle = 0;
    scale = initialScale;
    difference = Offset.zero;
  }

  void update(double dx, double dy, bool inverseAngle) {
    if (left > 0) {
      onSwipeDirectionChanged?.call(SwipeDirection.right);
    } else if (left < 0) {
      onSwipeDirectionChanged?.call(SwipeDirection.left);
    }
    left += dx;
    if (top > 0) {
      onSwipeDirectionChanged?.call(SwipeDirection.bottom);
    } else if (top < 0) {
      onSwipeDirectionChanged?.call(SwipeDirection.top);
    }
    top += dy;

    total = left + top;
    updateAngle(inverseAngle);
    updateScale();
    updateDifference();
  }

  void updateAngle(bool inverse) {
    angle = clampDouble(
      _maxAngleInRadian * left / 1000,
      -_maxAngleInRadian,
      _maxAngleInRadian,
    );
    if (inverse) {
      angle *= -1;
    }
  }

  void updateScale() {
    scale = clampDouble(initialScale + (total.abs() / 5000), initialScale, 1);
  }

  void updateDifference() {
    final discrepancy = (total / 10).abs();

    var diffX = 0.0;
    var diffY = 0.0;

    if (initialOffset.dx > 0) {
      diffX = discrepancy;
    } else if (initialOffset.dx < 0) {
      diffX = -discrepancy;
    }

    if (initialOffset.dy < 0) {
      diffY = -discrepancy;
    } else if (initialOffset.dy > 0) {
      diffY = discrepancy;
    }

    difference = Offset(diffX, diffY);
  }

  void animate(BuildContext context, SwipeDirection direction) {
    return switch (direction) {
      SwipeDirection.left => animateHorizontally(context, false),
      SwipeDirection.right => animateHorizontally(context, true),
      SwipeDirection.top => animateVertically(context, false),
      SwipeDirection.bottom => animateVertically(context, true),
      SwipeDirection.none => null,
    };
  }

  void animateHorizontally(BuildContext context, bool isToRight) {
    final size = MediaQuery.sizeOf(context);
    _leftAnimation = Tween<double>(
      begin: left,
      end: isToRight ? size.width : -size.width,
    ).animate(animationController);
    _topAnimation = Tween<double>(
      begin: top,
      end: top + top,
    ).animate(animationController);
    _scaleAnimation = Tween<double>(
      begin: scale,
      end: 1,
    ).animate(animationController);
    _differenceAnimation = Tween<Offset>(
      begin: difference,
      end: initialOffset,
    ).animate(animationController);
    animationController.forward();
  }

  void animateVertically(BuildContext context, bool isToBottom) {
    final size = MediaQuery.sizeOf(context);
    _leftAnimation = Tween<double>(
      begin: left,
      end: left + left,
    ).animate(animationController);
    _topAnimation = Tween<double>(
      begin: top,
      end: isToBottom ? size.height : -size.height,
    ).animate(animationController);
    _scaleAnimation = Tween<double>(
      begin: scale,
      end: 1,
    ).animate(animationController);
    _differenceAnimation = Tween<Offset>(
      begin: difference,
      end: initialOffset,
    ).animate(animationController);
    animationController.forward();
  }

  void animateBack(BuildContext context) {
    _leftAnimation = Tween<double>(
      begin: left,
      end: 0,
    ).animate(animationController);
    _topAnimation = Tween<double>(
      begin: top,
      end: 0,
    ).animate(animationController);
    _scaleAnimation = Tween<double>(
      begin: scale,
      end: initialScale,
    ).animate(animationController);
    _differenceAnimation = Tween<Offset>(
      begin: difference,
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
  }

  void animateUndo(BuildContext context, SwipeDirection direction) {
    return switch (direction) {
      SwipeDirection.left => animateUndoHorizontally(context, false),
      SwipeDirection.right => animateUndoHorizontally(context, true),
      SwipeDirection.top => animateUndoVertically(context, false),
      SwipeDirection.bottom => animateUndoVertically(context, true),
      _ => null
    };
  }

  void animateUndoHorizontally(BuildContext context, bool isToRight) {
    final size = MediaQuery.sizeOf(context);
    _leftAnimation = Tween<double>(
      begin: isToRight ? size.width : -size.width,
      end: 0,
    ).animate(animationController);
    _topAnimation = Tween<double>(
      begin: top,
      end: top + top,
    ).animate(animationController);
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: scale,
    ).animate(animationController);
    _differenceAnimation = Tween<Offset>(
      begin: initialOffset,
      end: difference,
    ).animate(animationController);
    animationController.forward();
  }

  void animateUndoVertically(BuildContext context, bool isToBottom) {
    final size = MediaQuery.sizeOf(context);
    _leftAnimation = Tween<double>(
      begin: left,
      end: left + left,
    ).animate(animationController);
    _topAnimation = Tween<double>(
      begin: isToBottom ? -size.height : size.height,
      end: 0,
    ).animate(animationController);
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: scale,
    ).animate(animationController);
    _differenceAnimation = Tween<Offset>(
      begin: initialOffset,
      end: difference,
    ).animate(animationController);
    animationController.forward();
  }
}

class Undoable<T> {
  Undoable(this._value, {Undoable<T>? previous}) : _previous = previous;

  T _value;
  Undoable<T>? _previous;

  T get state => _value;
  T? get previousState => _previous?.state;

  set state(T newValue) {
    _previous = Undoable(_value, previous: _previous);
    _value = newValue;
  }

  void undo() {
    if (_previous != null) {
      _value = _previous!._value;
      _previous = _previous?._previous;
    }
  }
}

/// CardSwiper 위젯에서 스와이프를 트리거하는 데 사용할 수 있는 컨트롤러입니다.
class SwipeController {
  final _controller = StreamController<ISwipeEvent>.broadcast();

  /// 카드를 스와이프하는 데 사용할 수 있는 이벤트 스트림입니다.
  Stream<ISwipeEvent> get events => _controller.stream;

  /// 카드를 특정 방향으로 스와이프합니다.
  void swipe(SwipeDirection direction) {
    _controller.add(SwipeEvent(direction));
  }

  // 마지막 스와이프를 실행 취소합니다.
  void undo() {
    _controller.add(const UndoEvent());
  }

  // 맨 위 카드를 특정 인덱스로 변경합니다.
  void moveTo(int index) {
    _controller.add(MoveEvent(index));
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}

sealed class ISwipeEvent {
  const ISwipeEvent();
}

class SwipeEvent extends ISwipeEvent {
  const SwipeEvent(this.direction);
  final SwipeDirection direction;
}

class UndoEvent extends ISwipeEvent {
  const UndoEvent();
}

class MoveEvent extends ISwipeEvent {
  const MoveEvent(this.index);
  final int index;
}

enum SwipeDirection { none, left, right, top, bottom }

enum SwipeType { none, swipe, back, undo }
