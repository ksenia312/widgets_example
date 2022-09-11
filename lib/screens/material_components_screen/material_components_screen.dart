import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/widgets/listview.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

import 'sliver_appbar_screen.dart';
import 'tab_bar_screen.dart';

class MaterialComponentsScreen extends StatefulWidget {
  const MaterialComponentsScreen({Key? key}) : super(key: key);


  @override
  State<MaterialComponentsScreen> createState() =>
      _MaterialComponentsScreenState();
}

class _MaterialComponentsScreenState extends State<MaterialComponentsScreen> {
  late Map<int, Widget> _chips;
  late Map<int, Widget> _chipsModified;
  final ScrollController _scrollController = ScrollController();
  int _stepIndex = 0;

  @override
  void initState() {
    _chips = Map.fromIterables(List.generate(5, (index) => index),
        List.generate(5, (index) => _chipView(index, 'я чип ${index + 1}')));
    _chipsModified = Map.from(_chips);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppListView(
      controller: _scrollController,
      children: [
        _annotation,
        _sliverAppBar,
        _sliverAppBarExample,
        _tabBar,
        _tabBarExample,
        _stepper,
        _stepperExample,
        _chip,
        _chipExample,
      ],
    );
  }

  get _annotation => const AppSection(
        child: AppText(value: 'Показаны только малоизученные мной виджеты'),
      );

  get _sliverAppBar => const AppHeadlineSection(
      title: 'SliverAppBar',
      description: 'SliverAppBar обычно используются'
          ' в качестве первого дочернего элемента CustomScrollView, '
          'что позволяет интегрировать панель приложений с представлением '
          'прокрутки таким образом, что она может меняться по высоте в зависимости '
          'от смещения прокрутки или плавать над другим содержимым в представлении '
          'прокрутки. \n\nДля панели приложений фиксированной высоты в верхней части экрана '
          'смотрите AppBar, '
          'которая используется в слоте Scaffold.appBar.');

  get _sliverAppBarExample => AppSection(
          child: Column(
        children: [
          const AppText(
            value:
                'Я нагло украла весь пример с официального сайта, потому что он замечательный',
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SliverAppBarScreen()));
            },
            child: const AppText(
              value: 'Перейти к странице с SliverAppBar',
            ),
          ),
        ],
      ));

  get _tabBar => const AppHeadlineSection(
      title: 'TabBar',
      description:
          'Виджет Material Design, отображающий горизонтальный ряд вкладок. Обычно создается как нижняя часть AppBar.bottom в AppBar и в сочетании с TabBarView.');

  get _tabBarExample => AppSection(
        child: Column(
          children: [
            const AppText(
              value:
                  'Если TabController не указан, то вместо него должен быть указан предок DefaultTabController. \n\nДлина TabController.length контроллера вкладок должна быть равна длине списка вкладок и длине списка TabBarView.children.',
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TabBarScreen()));
              },
              child: const AppText(
                value: 'Перейти к странице с TabBar',
              ),
            ),
          ],
        ),
      );

  get _stepper => const AppHeadlineSection(
      title: 'Stepper',
      description:
          'Stepper отображает прогресс выполнения последовательности шагов. \n\nСтепперы особенно полезны в случае форм, где один шаг требует завершения другого шага, или где необходимо выполнить несколько шагов, чтобы отправить всю форму. Виджет является гибкой оберткой. Родительский класс должен передать currentStep этому виджету на основе некоторой логики, вызванной тремя обратными вызовами, которые он предоставляет.');

  get _stepperExample => AppSection(
      child: Stepper(
          physics: const NeverScrollableScrollPhysics(),
          currentStep: _stepIndex,
          onStepCancel: () {
            setState(() {
              _stepIndex -= 1;
            });
          },
          onStepContinue: () {
            setState(() {
              _stepIndex += 1;
            });
          },
          onStepTapped: (int index) {
            setState(() {
              _stepIndex = index;
            });
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Column(
              children: [
                OutlinedButton(
                  onPressed: _stepIndex == 4 ? null : details.onStepContinue,
                  child: const Text('Следующий шаг'),
                  style: _buttonStyle(),
                ),
                const SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                  onPressed: _stepIndex == 0 ? null : details.onStepCancel,
                  style: _buttonStyle(blockedIndex: 0),
                  child: const Text(
                    'К предыдущему шагу',
                  ),
                ),
              ],
            );
          },
          steps: List.generate(
              5,
              (index) => Step(
                    title: Text('Шаг ${index + 1}'),
                    content: Text('Описание шага ${index + 1}'),
                  ))));

  _buttonStyle({int blockedIndex = 4}) => ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color?>(
            _stepIndex == blockedIndex ? const Color(0x9eb680ea) : null),
        side: MaterialStateProperty.all<BorderSide?>(BorderSide(
            color: _stepIndex == blockedIndex
                ? const Color(0x9eb680ea)
                : purple900)),
      );

  get _chip => const AppHeadlineSection(
      title: 'Chip',
      description:
          'Chip\'ы - это компактные элементы, представляющие атрибут, текст, объект или действие. Если предоставить не нулевой обратный вызов onDeleted, chip будет включать кнопку для удаления chip.');

  get _chipExample => AppSection(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(children: _chipsModified.values.toList()),
          OutlinedButton(
              onPressed: () {
                setState(() {
                  _chipsModified = Map.from(_chips);
                });
                Future.delayed(const Duration(milliseconds: 100), () {
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent + 20,
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 300));
                });
              },
              child: const AppText(
                value: 'Восстановить',
              ))
        ],
      ));

  _chipView(int index, String text) => Chip(
        avatar: CircleAvatar(
          backgroundColor: purple900,
          child: const Text('K'),
        ),
        label: AppText(value: text),
        backgroundColor: purple900.withOpacity(0.1),
        deleteIconColor: purple900,
        onDeleted: () {
          setState(() {
            _chipsModified.remove(index);
          });
        },
      );
}
