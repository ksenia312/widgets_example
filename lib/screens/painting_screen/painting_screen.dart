import 'dart:math';
import "dart:ui";
import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/title_widget.dart';
import 'package:widgets_example/widgets/arrow_painter.dart';
import 'package:widgets_example/widgets/listview.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

class PaintingScreen extends TitleWidget {
  const PaintingScreen({Key? key}) : super(key: key);

  @override
  get title => 'Painting & effect ';

  @override
  State<PaintingScreen> createState() => _PaintingsScreenState();
}

class _PaintingsScreenState extends State<PaintingScreen> {
  static const _opacityDescription = 'каждый блок обернут в Opacity';

  @override
  Widget build(BuildContext context) {
    return AppListView(children: [
      _backdropFilter,
      _backdropFilterExample,
      _customPaint,
      _customPaintExample,
      _opacity,
      _opacityExample
    ]);
  }

  get _backdropFilter => const AppHeadlineSection(
      title: 'BackdropFilter',
      description:
          'Виджет, который применяет фильтр к существующему закрашенному содержимому, а затем закрашивает дочернее. \n\nФильтр будет применен ко всей области в пределах клипа виджета-родителя или предка. Если клип отсутствует, фильтр будет применен ко всему экрану.');

  get _backdropFilterExample => AppSection(
        child: Column(
          children: [
            const AppText(
              value:
                  'С помощью ClipRect применяем фильтр к ребенку по указанной в ребенке области',
            ),
            const AppText(
              value:
                  'ClipRect(// <-- clips to the size \n// [Container] below\n   child: BackdropFilter(\n      filter: ImageFilter.blur(),\n      child: Container(/*with size*/),\n   ),\n),',
              textType: TextType.code,
            ),
            SizedBox(
              height: 300,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  AppText(value: '0' * 10000),
                  Center(
                    child: ClipRect(
                      // <-- clips to the 200x200 [Container] below
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 3.0,
                          sigmaY: 3.0,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 200.0,
                          height: 200.0,
                          child: const AppText(
                            value: 'Hello World',
                            textType: TextType.large,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  get _customPaint => const AppHeadlineSection(
      title: 'CustomPaint',
      description:
          'Виджет, предоставляющий холст, на котором можно рисовать во время фазы рисования.');

  get _customPaintExample => AppSection(
        child: Column(
          children: [
            const AppText(
                value:
                    'Позволяет рисовать разные фигуры с помощью кастомных или дефолтных painter\'ов'),
            const Divider(),
            const AppText(
                textType: TextType.small,
                value:
                    'Ниже нарисованы стрелки с помощью Arrow Painter, созданного кастомно'),
            CustomPaint(
              size: const Size(200, 50),
              painter: ArrowPainter(),
            ),
            Transform.rotate(
              angle: pi,
              child: CustomPaint(
                size: const Size(200, 50),
                painter: ArrowPainter(),
              ),
            ),
          ],
        ),
      );

  get _opacity => const AppHeadlineSection(
      title: 'Opacity',
      description:
          'Виджет, который делает своего ребенка частично прозрачным. Этот класс закрашивает дочерний виджет в промежуточный буфер, а затем накладывает его обратно частично прозрачным.');

  get _opacityExample => AppSection(
        child: SizedBox(
          height: 200,
          child: Column(
            children: List.generate(
              5,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Opacity(
                    opacity: (index + 5) / 10,
                    child: Container(
                      color: purple900,
                      child: Center(
                        child: AppText(
                          dark: false,
                          textType: TextType.large,
                          value: _opacityDescription.split(' ')[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
