import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/title_widget.dart';
import 'package:widgets_example/widgets/arrow_painter.dart';
import 'package:widgets_example/widgets/listview.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

import 'custom_scroll_view_screen.dart';
import 'refresh_indicator_screen.dart';

class ScrollingScreen extends TitleWidget {
  const ScrollingScreen({Key? key}) : super(key: key);

  @override
  get title => 'Scrolling';

  @override
  State<ScrollingScreen> createState() => _ScrollingScreenState();
}

class _ScrollingScreenState extends State<ScrollingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppListView(children: [
      _customScrollView,
      _customScrollViewExample,
      _pageView,
      _pageViewExample,
      _refreshIndicator,
      _refreshIndicatorExample,
    ]);
  }

  get _customScrollView => const AppHeadlineSection(
      title: 'CustomScrollView',
      description:
          'ScrollView, который создает пользовательские эффекты прокрутки с помощью лент. '
          '\n\nCustomScrollView позволяет напрямую использовать sliver\'ы для создания '
          'различных эффектов прокрутки, таких как списки, сетки и расширяющиеся '
          'заголовки. \n\nНапример, чтобы создать представление прокрутки, содержащее '
          'расширяющуюся панель приложений, за которой следуют список и сетка, '
          'используйте список из трех sliver\'ов: SliverAppBar, SliverList и SliverGrid.');

  get _customScrollViewExample => AppSection(
          child: Column(
        children: [
          const AppText(
            value:
                'Этот пример кода показывает представление прокрутки, содержащее гибкую панель приложений, сетку и бесконечный список.',
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CustomScrollViewScreen()));
            },
            child: const AppText(
              value: 'Перейти к странице с CustomScrollView',
            ),
          ),
        ],
      ));

  get _pageView => const AppHeadlineSection(
      title: 'PageView',
      description:
          'Прокручиваемый список, который работает постранично. \n\nКаждый дочерний элемент представления страницы должен быть того же размера, что и область просмотра.');

  get _pageViewExample => AppSection(
        child: SizedBox(
          height: 300,
          child: PageView(
            controller: PageController(),
            children: <Widget>[
              _page('Первая страница'),
              _page('Вторая страница',
                  subtitle: 'Листать в любую сторону',
                  isBackgroundDark: true,
                  twoArrows: true),
              _page('Третья страница',
                  subtitle: 'Листать влево', firstArrowToLeft: true),
            ],
          ),
        ),
      );

  _page(String title,
          {String subtitle = 'Листать вправо',
          bool isBackgroundDark = false,
          bool twoArrows = false,
          bool firstArrowToLeft = false}) =>
      Container(
        decoration: BoxDecoration(
            color: isBackgroundDark ? purple900 : white,
            border: isBackgroundDark
                ? null
                : Border.all(color: purple900, width: 10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              value: title,
              textType: TextType.large,
              dark: !isBackgroundDark,
            ),
            AppText(
              value: subtitle,
              dark: !isBackgroundDark,
            ),
            Transform.rotate(
              angle: firstArrowToLeft ? pi : 0,
              child: CustomPaint(
                painter: ArrowPainter(dark: !isBackgroundDark),
                size: const Size(200, 50),
              ),
            ),
            if (twoArrows)
              Transform.rotate(
                angle: pi,
                child: CustomPaint(
                  painter: ArrowPainter(dark: !isBackgroundDark),
                  size: const Size(200, 20),
                ),
              ),
          ],
        ),
      );

  get _refreshIndicator => const AppHeadlineSection(
      title: 'RefreshIndicator',
      description:
          'Виджет, поддерживающий идиому Material "проведите пальцем, чтобы обновить".');

  get _refreshIndicatorExample => AppSection(
        child: Column(
          children: [
            const AppText(
              value:
                  'В примере при обновлении добавляются новые элементы списка',
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RefreshIndicatorScreen()));
              },
              child: const AppText(
                value: 'Перейти к странице с RefreshIndicator',
              ),
            ),
          ],
        ),
      );
}
