import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/named_widget.dart';
import 'package:widgets_example/utils/sections.dart';
import 'package:widgets_example/utils/text.dart';

class Animations extends NamedWidget {
  @override
  String get name => 'Animations';

  const Animations({Key? key}) : super(key: key);

  @override
  State<Animations> createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations> with TickerProviderStateMixin {
  int animatedAlignPosition = 0;
  bool _animatedCrossFadeFirst = true;
  bool _animatedModalBarrierShow = false;
  late Animation<Color?> _animatedModalBarrierAnimation;
  late AnimationController _animatedModalBarrierController;

  @override
  void initState() {
    _animatedModalBarrierController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat(reverse: true);
    _animatedModalBarrierAnimation =
        ColorTween(begin: Colors.purple.withOpacity(0.5), end: purple900.withOpacity(0.5))
            .animate(_animatedModalBarrierController)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  void dispose() {
    _animatedModalBarrierController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _annotation(),
        _animatedAlign(),
        _animatedAlignExample(),
        _animatedCrossFade(),
        _animatedCrossFadeExample(),
        _animatedModalBarrier(),
        _animatedModalBarrierExample()
      ],
    );
  }

  _annotation() => const Section(
        child: AppText(value: 'Только анимации, которые я редко использовала'),
      );

  _animatedAlign() => const HeadlineSection(
      title: 'AnimatedAlign',
      description:
          'Виджет, с помощью которого можно менять положение объекта пр изменении зависимости');

  _animatedAlignExample() => Section(
        child: Column(
          children: [
            Container(
              color: purple900,
              height: 150,
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: getAlignPosition(animatedAlignPosition),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    animatedAlignPosition = (animatedAlignPosition + 1) % 4;
                  });
                },
                child: const AppText(
                  value: 'Изменить положение',
                )),
          ],
        ),
      );

  Alignment getAlignPosition(int pos) {
    if (pos == 0) {
      return Alignment.bottomLeft;
    } else if (pos == 1) {
      return Alignment.bottomRight;
    } else if (pos == 2) {
      return Alignment.topRight;
    } else {
      return Alignment.topLeft;
    }
  }

  _animatedCrossFade() => const HeadlineSection(
      title: 'AnimatedCrossFade',
      description:
          'Виджет, который переливается между двумя заданными дочерними элементами и анимирует себя между их размерами.');

  _animatedCrossFadeExample() => Section(
        child: Column(
          children: [
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 900),
              firstChild: Container(
                height: 50,
                width: 50,
                color: purple800,
                child: const Center(
                    child: AppText(
                  value: 'Я',
                  dark: false,
                )),
              ),
              secondChild: Container(
                height: 100,
                width: 100,
                color: purple900,
                child: const Center(
                    child: AppText(
                  value: 'Я большой',
                  dark: false,
                )),
              ),
              crossFadeState: _animatedCrossFadeFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    _animatedCrossFadeFirst = !_animatedCrossFadeFirst;
                  });
                },
                child: const AppText(
                  value: 'Изменить виджет',
                )),
          ],
        ),
      );

  _animatedModalBarrier() => const HeadlineSection(
        title: 'AnimatedModalBarrier',
        description:
            'Виджет, который не позволяет пользователю взаимодействовать с виджетами позади себя, и может быть настроен на анимированное значение цвета.',
      );

  _animatedModalBarrierExample() => Section(
        child: SizedBox(
          height: 200,
          child: Stack(children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _animatedModalBarrierShow = !_animatedModalBarrierShow;
                        });
                      },
                      child: const AppText(
                        value: 'Показать окно',
                      )),
                ),
              ),
            ),
            Center(
              child: Visibility(
                  visible: _animatedModalBarrierShow,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      AnimatedModalBarrier(
                        color: _animatedModalBarrierAnimation,
                      ),
                      SizedBox(
                        height: 130,
                        width: 250,
                        child: Section(
                          child: Column(
                            children: [
                              const AppText(
                                value:
                                    'Я не закрыт, поэтому кнопка "Показать окно" не нажмется.',
                              ),
                              OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _animatedModalBarrierShow = false;
                                    });
                                  },
                                  child: const AppText(
                                    value: 'Закрыть',
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ]),
        ),
      );
}
