import 'dart:math';

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
  int _animatedAlignPosition = 0;
  bool _animatedCrossFadeFirst = true;
  bool _animatedModalBarrierShow = false;
  bool _animatedPhysicalModelFirst = false;
  late Animation<Color?> _colorAnimation;
  late AnimationController _colorController;
  late AnimationController _rotateController;
  late AnimationController _tweenController;

  @override
  void initState() {
    _colorController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat(reverse: true);
    _colorAnimation = ColorTween(
            begin: Colors.purple.withOpacity(0.5),
            end: purple900.withOpacity(0.5))
        .animate(_colorController)
      ..addListener(() {
        setState(() {});
      });
    _rotateController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _tweenController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _colorController.dispose();
    _rotateController.dispose();
    _tweenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _annotation,
        _animatedAlign,
        _animatedAlignExample,
        _animatedCrossFade,
        _animatedCrossFadeExample,
        _animatedModalBarrier,
        _animatedModalBarrierExample,
        _animatedPhysicalModel,
        _animatedPhysicalModelExample,
        _animatedWidget,
        _animatedWidgetExample,
        _decoratedBoxTransition,
        _decoratedBoxTransitionExample,
        _hero,
        _heroExample,
        _conclusion
      ],
    );
  }

  get _annotation => const Section(
        child: AppText(value: 'Только анимации, которые я редко использовала'),
      );

  get _animatedAlign => const HeadlineSection(
      title: 'AnimatedAlign',
      description:
          'Виджет, с помощью которого можно менять положение объекта пр изменении зависимости');

  get _animatedAlignExample => Section(
        child: Column(
          children: [
            Container(
              color: purple900,
              height: 150,
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: getAlignPosition(_animatedAlignPosition),
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
                    _animatedAlignPosition = (_animatedAlignPosition + 1) % 4;
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

  get _animatedCrossFade => const HeadlineSection(
      title: 'AnimatedCrossFade',
      description:
          'Виджет, который переливается между двумя заданными дочерними элементами и анимирует себя между их размерами.');

  get _animatedCrossFadeExample => Section(
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

  get _animatedModalBarrier => const HeadlineSection(
        title: 'AnimatedModalBarrier',
        description:
            'Виджет, который не позволяет пользователю взаимодействовать с виджетами позади себя, и может быть настроен на анимированное значение цвета.',
      );

  get _animatedModalBarrierExample => Section(
        child: SizedBox(
          height: 200,
          child: Stack(alignment: Alignment.topCenter, children: [
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
                    ),
                  ),
                ),
              ),
            ),
            _visibility(
              child: AnimatedModalBarrier(
                color: _colorAnimation,
              ),
            ),
            _visibility(child: _modal)
          ]),
        ),
      );

  get _modal => SizedBox(
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
      );

  _visibility({required Widget child}) =>
      Visibility(visible: _animatedModalBarrierShow, child: child);

  get _animatedPhysicalModel => const HeadlineSection(
      title: 'AnimatedPhysicalModel',
      description:
          'Анимированная версия PhysicalModel. Анимируются borderRadius и elevation. Цвет анимируется, если установлено свойство animateColor. В противном случае цвет изменяется сразу после начала анимации для двух других свойств. Это позволяет анимировать цвет независимо (например, потому что он управляется анимационной темой). Форма не анимируется.');

  get _animatedPhysicalModelExample => Section(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  _physicalModel(
                      text: 'У меня анимированные цвет и тень',
                      color: purple900,
                      animateColor: true,
                      shape: BoxShape.rectangle),
                  const SizedBox(width: 15),
                  _physicalModel(
                      text: 'У меня меняется цвет, но он не анимирован',
                      color: purple800,
                      animateColor: false,
                      shape: BoxShape.circle),
                ],
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    _animatedPhysicalModelFirst = !_animatedPhysicalModelFirst;
                  });
                },
                child: const AppText(
                  value: 'Анимировать модели',
                )),
          ],
        ),
      );

  _physicalModel(
          {required String text,
          required Color color,
          required bool animateColor,
          required BoxShape shape}) =>
      Expanded(
        child: AnimatedPhysicalModel(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: AppText(
                  value: text,
                  dark: !_animatedPhysicalModelFirst,
                ),
              ),
            ),
            animateColor: animateColor,
            curve: Curves.fastOutSlowIn,
            shape: shape,
            elevation: _animatedPhysicalModelFirst ? 10 : 2,
            color: _animatedPhysicalModelFirst ? color : white,
            shadowColor: purple900,
            duration: const Duration(seconds: 1)),
      );

  get _animatedWidget => const HeadlineSection(
      title: 'AnimatedWidget',
      description:
          'Виджет, который перестраивается при изменении значения заданного Listenable. AnimatedWidget чаще всего используется с объектами Animation, которые являются прослушиваемыми, но его можно использовать с любыми прослушиваемыми, включая ChangeNotifier и ValueNotifier. AnimatedWidget наиболее полезен для виджетов, которые в других случаях не имеют состояния. Чтобы использовать AnimatedWidget, просто создайте его подкласс и реализуйте функцию build.');

  get _animatedWidgetExample => Section(
          child: Column(
        children: [
          const AppText(
            value:
                'Квадрат ниже - отдельный виджет, который наследуется от AnimatedWidget. Мы передаем ему контроллер и объявляем его как Listenable',
          ),
          SizedBox(
              height: 100,
              child: Center(
                  child: SpinningContainer(controller: _rotateController))),
        ],
      ));

  get _decoratedBoxTransition => const HeadlineSection(
      title: 'DecoratedBoxTransition',
      description:
          'Анимированная версия DecoratedBox, которая анимирует различные свойства его Decoration. Анимации Tween, конечно, самые загадочные. \nИх отличие от Animation - они задаются объектом Tween и контроллером. Чтобы ее оживить, передается \ndecoration:_decorationTween.animate(_tweenController)\nВ Animation же обычно к анимации привязывается ее контроллер при инициализации.');

  DecorationTween get _decorationTween => DecorationTween(
        begin: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(60.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x66666666),
              blurRadius: 10.0,
              spreadRadius: 3.0,
              offset: Offset(0, 6.0),
            )
          ],
        ),
        end: BoxDecoration(
          color: purple900,
          borderRadius: BorderRadius.zero,
        ),
      );

  get _decoratedBoxTransitionExample => Section(
        child: DecoratedBoxTransition(
          decoration: _decorationTween.animate(_tweenController),
          child: Center(
            child: Container(
              width: 150,
              height: 150,
              color: white,
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: AppText(
                  value:
                      'Я внутри DecorationTween. Все вокруг меня декорируется одной анимацией',
                ),
              ),
            ),
          ),
        ),
      );

  get _hero => const HeadlineSection(
      title: 'Hero',
      description:
          'Виджет, который помечает своего ребенка как кандидата на анимацию Hero.\n\n * Пример анимации Hero: на экране отображается список миниатюр, представляющих товары на продажу. При выборе товара он перелетает на новый экран, содержащий более подробную информацию и кнопку "Купить". Перемещение изображения с одного экрана на другой называется во Flutter анимацией Hero, хотя это же движение иногда называют переходом от одного элемента к другому.');

  get _heroExample => Section(
        child: Column(
          children: [
            Hero(
              tag: 'hero-rectangle',
              child: _circle(const Size(50, 50)),
            ),
            OutlinedButton(
              onPressed: () {
                _gotoDetailsPage(context);
              },
              child: const AppText(
                value: 'Перейти на новую страницу',
              ),
            )
          ],
        ),
      );

  Widget _circle(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          color: purple900,
          borderRadius: BorderRadius.all(Radius.circular(size.width))),
    );
  }

  void _gotoDetailsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const AppText(
              value: 'Описание колобка',
              dark: false,
              textType: TextType.large,
            ),
          ),
          body: Center(
            child: SizedBox(
              height: 300,
              child: Section(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'hero-rectangle',
                      child: _circle(const Size(200, 200)),
                    ),
                    const AppText(
                      value: 'я колобок',
                      textType: TextType.large,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  get _conclusion => const Section(
          child: AppText(
        value:
            'Анимации бывают разные. \nЕсли окончание Transition - он хочет в качестве параметра получить анимацию значения. \nЕсли начало - Animated, то хочет получить статическое значение (меняющееся по зависимостям). \nТакже анимации можем задать по-разному, простые - CurvedAnimation, посложнее - Tween. ',
      ));
}

class SpinningContainer extends AnimatedWidget {
  const SpinningContainer({
    Key? key,
    required AnimationController controller,
  }) : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _progress.value * 2.0 * pi,
      child: Container(width: 50.0, height: 50.0, color: purple900),
    );
  }
}
