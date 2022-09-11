import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgets_example/screens/layout_screen/widgets/flow_menu.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/widgets/arrow_painter.dart';
import 'package:widgets_example/widgets/listview.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppListView(children: [
      _aspectRatio,
      _aspectRatioExample,
      _baseLine,
      _baseLineExample,
      _fittedBox,
      _fittedBoxExample,
      _fractionallySizedBox,
      _fractionallySizedBoxExample,
      _transform,
      _transformExample,
      _flow,
      _flowExample,
      _gridView,
      _gridViewExample,
      _indexedStack,
      _indexedStackExample,
      _table,
      _tableExample
    ]);
  }

  get _aspectRatio => const AppHeadlineSection(
      title: 'AspectRatio',
      description:
          'Виджет, который пытается изменить размер дочернего элемента в соответствии с определенным соотношением сторон. Сначала виджет пытается выбрать наибольшую ширину, разрешенную ограничениями макета. Высота виджета определяется путем применения заданного соотношения сторон к ширине, выраженной как отношение ширины к высоте.');

  get _aspectRatioExample => AppSection(
          child: Column(
        children: [
          const AppText(value: 'Размер контейнера: '),
          const AppText(
            value: '  height: 280, width: 280',
            textType: TextType.code,
          ),
          const SizedBox(height: 5),
          const AppText(
              value: 'Соответственно, размер одной полосочки - 280 : 40'),
          const SizedBox(height: 5),
          Stack(
            children: [
              SizedBox(
                height: 280, //360/9 = 40
                width: 280,
                child: Column(
                    children: List.generate(7, (index) {
                  var multiplier = (index + 1) / 7;
                  var containerSize = 7 / 1;
                  return Expanded(
                      child: Container(
                    color: Colors.purple.shade100,
                    alignment: Alignment.centerLeft,
                    child: AspectRatio(
                      aspectRatio: multiplier * containerSize,
                      child: Container(
                        color: purple800.withOpacity(multiplier * 0.7),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 5),
                        child: AppText(
                          value: '${(index + 1)} : 1',
                          dark: false,
                        ),
                      ),
                    ),
                  ));
                }).toList()),
              ),
              SizedBox(
                height: 280, //360/9 = 40
                width: 280,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (index) {
                    var multiplier = (index + 1) / 7;
                    var containerSize = 7 / 1;
                    return Expanded(
                      child: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            'часть от полоски: ${(multiplier * containerSize).toInt()} / 7',
                            style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          )),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ],
      ));

  get _baseLine => const AppHeadlineSection(
      title: 'Baseline',
      description:
          'Виджет, который позиционирует дочерний элемент в соответствии с Baseline дочернего элемента.');

  get _baseLineExample => AppSection(
        child: Column(
          children: [
            Container(
              color: Colors.purple.shade400,
              height: 100,
              padding: const EdgeInsets.all(10),
              child: const AppText(
                value:
                    'Я внутри Container высотой 100.\n Я просто позиционируюсь по top по дефолту',
                dark: false,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              color: Colors.purple.shade200,
              height: 50,
              child: const Baseline(
                baselineType: TextBaseline.alphabetic,
                baseline: -20,
                child: AppText(
                  value: 'Я внутри Container высотой 50 и обернут в Baseline.',
                ),
              ),
            ),
            const SizedBox(
              height: 50,
              child: AppText(
                  textType: TextType.small,
                  value: 'Текст над контейнером, потому что baseline = -20'),
            ),
            Container(
              color: Colors.purple.shade200,
              height: 50,
              child: const Baseline(
                baselineType: TextBaseline.alphabetic,
                baseline: 0,
                child: AppText(
                  value: 'Я внутри Container высотой 50 и обернут в Baseline.',
                ),
              ),
            ),
            const SizedBox(
              height: 50,
              child: AppText(
                  textType: TextType.small,
                  value: 'Текст сидит на контейнере, потому что baseline = 0'),
            ),
            Container(
              color: Colors.purple.shade400,
              height: 50,
              child: const Baseline(
                baselineType: TextBaseline.alphabetic,
                baseline: 20,
                child: AppText(
                  dark: false,
                  value: 'Я внутри Container высотой 50 и обернут в Baseline.',
                ),
              ),
            ),
            const SizedBox(
              height: 50,
              child: AppText(
                  textType: TextType.small,
                  value: 'Текст внутри контейнера, потому что baseline = 20'),
            ),
          ],
        ),
      );

  get _fittedBox => const AppHeadlineSection(
      title: 'FittedBox',
      description:
          'Масштабирует и размещает ребенка внутри себя в соответствии с fit.');

  get _fittedBoxExample => AppSection(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _image(
                fit: BoxFit.fill,
              ),
              _imageDescription(
                  code: 'BoxFit.fill',
                  text: 'Заполняет контейнер искажая картинку')
            ],
          ),
          const Divider(),
          Row(
            children: [
              _image(fit: BoxFit.fitWidth),
              _imageDescription(
                  code: 'BoxFit.fitWidth',
                  text: 'Contain по ширине. Пример когда высоты не хватает')
            ],
          ),
          const Divider(),
          Row(
            children: [
              _image(fit: BoxFit.fitWidth, width: 100, height: 150),
              _imageDescription(
                  code: 'BoxFit.fitWidth',
                  text: 'Contain по ширине. Пример когда высоты хватает')
            ],
          ),
          const Divider(),
          Row(
            children: [
              _image(fit: BoxFit.fitHeight, width: 100, height: 150),
              _imageDescription(
                  code: 'BoxFit.fitHeight',
                  text: 'Contain по высоте. Пример когда ширины не хватает')
            ],
          ),
          const Divider(),
          Row(
            children: [
              _image(fit: BoxFit.fitHeight, width: 150, height: 100),
              _imageDescription(
                  code: 'BoxFit.fitHeight',
                  text: 'Contain по высоте. Пример когда высоты хватает')
            ],
          ),
          const Divider(),
          Row(
            children: [
              _image(fit: BoxFit.cover, height: 100, width: 150),
              _imageDescription(
                  code: 'BoxFit.cover',
                  text:
                      'Настолько маленький, насколько \nэто возможно, но при этом охватывающий весь контейнер. fitHeight + fitWidth по сути')
            ],
          ),
          const Divider(),
          Row(
            children: [
              _image(fit: BoxFit.scaleDown, width: 150, height: 200),
              _imageDescription(
                  code: 'BoxFit.scaleDown',
                  text:
                      'Уменьшает scale, если необходимо. Это то же самое, что и contain, если нужно уменьшение изображения, в противном случае это то же самое, что и none')
            ],
          ),
          const Divider(),
          Row(
            children: [
              _image(fit: BoxFit.none),
              _imageDescription(
                  code: 'BoxFit.none', text: 'Ему все равно, он богема')
            ],
          ),
          const Divider(),
          Row(
            children: [
              _image(fit: BoxFit.contain),
              _imageDescription(
                  code: 'BoxFit.contain',
                  text: 'Как можно большего размера в пределах контейнера')
            ],
          ),
        ],
      ));

  _image({double width = 200, double height = 100, required BoxFit fit}) =>
      Container(
        width: width,
        height: height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 1, color: purple900, offset: const Offset(0, 1))
            ],
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: FittedBox(
          clipBehavior: Clip.hardEdge,
          fit: fit,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: height,
                minWidth: width),
            child: Image.network(
              'https://static10.tgstat.ru/channels/_0/7e/7ed35fe88e5d84da058e9d3f911f1cdf.jpg',
            ),
          ),
        ),
      );

  _imageDescription({required String text, required String code}) => Expanded(
          child: Column(
        children: [
          AppText(textType: TextType.code, value: code),
          AppText(textType: TextType.small, value: text),
        ],
      ));

  get _fractionallySizedBox => const AppHeadlineSection(
      title: 'FractionallySizedBox ',
      description:
          'Виджет, который изменяет размер своего дочернего элемента на часть от общего доступного пространства.');

  get _fractionallySizedBoxExample => AppSection(
          child: SizedBox(
        height: 300,
        child: Column(
          children: [
            _fractionallyContainer('width - 100%\nheight - 70%', 1.0, 0.7),
            const SizedBox(height: 15),
            _fractionallyContainer('width - 70%\nheight - 100%', 0.7, 1.0),
            const SizedBox(height: 15),
            _fractionallyContainer('width - 70%\nheight - 70%', 0.7, 0.7),
          ],
        ),
      ));

  _fractionallyContainer(
          String text, double widthFactor, double heightFactor) =>
      Expanded(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.purple.shade300,
              boxShadow: [
                BoxShadow(
                    blurRadius: 1, color: purple900, offset: const Offset(0, 1))
              ],
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: FractionallySizedBox(
                widthFactor: widthFactor,
                heightFactor: heightFactor,
                child: Container(
                  color: Colors.purple.shade800,
                  child: Center(
                      child: AppText(
                    value: text,
                    dark: false,
                    textAlign: TextAlign.start,
                  )),
                )),
          ),
        ),
      );

  get _transform => const AppHeadlineSection(
      title: 'Transform',
      description:
          'Виджет, который применяет трансформацию перед рисованием своего дочернего объекта.');

  get _transformExample => AppSection(
          child: Column(
        children: [
          _transformRow(Matrix4.skewY(0.3)..rotateZ(-pi / 12.0),
              'Matrix4.skewY(0.3)\n..rotateZ(-pi / 12.0)'),
          _transformRow(Matrix4.skewX(-0.6)..rotateX(pi / 6.0),
              'Matrix4.skewX(-0.4)\n..rotateX(pi / 6.0)'),
          _transformRow(Matrix4.skewY(0.0)..rotateZ(-pi / 3.0),
              'Matrix4.skewY(0.0)\n..rotateZ(-pi / 3.0)'),
          const SizedBox(height: 80)
        ],
      ));

  _transformRow(transform, text) => Row(
        children: [
          Container(
            color: purple900,
            child: Transform(
              alignment: Alignment.topRight,
              transform: transform,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.purple,
                child: const AppText(
                  value: 'Apartment for rent!',
                  dark: false,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
              child: AppText(
            textType: TextType.code,
            value: text,
          ))
        ],
      );

  get _flow => const AppHeadlineSection(
      title: 'Flow',
      description: 'Виджет, который эффективно изменяет размеры и '
          'положение дочерних элементов в соответствии с логикой в делегате'
          ' FlowDelegate. Макеты Flow оптимизированы для изменения положения'
          ' детей с помощью матриц трансформации.');

  get _flowExample => AppSection(
          child: Stack(
        children: [
          Container(
              alignment: Alignment.centerRight,
              child: const AppText(
                value: 'Открывается меню, меняется цвет'
                    '\nпри нажатии на элемент',
                textAlign: TextAlign.right,
              )),
          const Center(child: SizedBox(height: 50, child: FlowMenu())),
        ],
      ));

  get _gridView => const AppHeadlineSection(
      title: 'GridView',
      description:
          'Прокручиваемый двумерный массив виджетов. \n\nНаиболее часто используемыми компоновками сетки являются GridView.count, которая создает компоновку с фиксированным количеством плиток по поперечной оси, и GridView.extent, которая создает компоновку с плитками, имеющими максимальную протяженность по поперечной оси. \n\nПользовательский делегат SliverGridDelegate может создавать произвольное двумерное расположение дочерних элементов, включая расположение без выравнивания или с перекрытием.');

  get _gridViewExample => AppSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: _gridDescription(text: 'Листать вниз'),
                  ),
                ),
                _drawGridView(),
              ],
            ),
            const Divider(),
            _drawGridView(scrollDirection: Axis.horizontal),
            _gridDescription()
          ],
        ),
      );

  _drawGridView({Axis scrollDirection = Axis.vertical}) => SizedBox(
        height: 200,
        width: 200,
        child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            scrollDirection: scrollDirection,
            children: List.generate(
                6,
                (index) => Container(
                      color: purple800.withOpacity((index + 5) / 10),
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: AppText(
                        dark: false,
                        value: 'я ребенок  №${index + 1}',
                      )),
                    )).toList()),
      );

  _gridDescription({String text = 'Листать вправо'}) => Column(children: [
        AppText(value: text),
        CustomPaint(
          size: const Size(200, 50),
          painter: ArrowPainter(),
        )
      ]);

  get _indexedStack => const AppHeadlineSection(
      title: 'IndexedStack',
      description:
          'Стек, который показывает одного ребенка из списка детей. \n\nОтображаемый ребенок - это ребенок с заданным индексом. Размер стека всегда равен размеру самого большого ребенка. Если значение равно null, то ничего не отображается.');

  get _indexedStackExample => AppSection(
          child: Column(
        children: [
          const AppText(
              value:
                  'Индексированный стек принимает размер наибольшего элемента, '
                  'даже если не отображает его в данный момент времени. '
                  '\n\nВысота стека - 185'),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: purple900, width: 0.4)),
            child: IndexedStack(
              index: _screenIndex,
              alignment: Alignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  height: 200 - (index + 1) * 15,
                  decoration: BoxDecoration(
                    color: purple900.withOpacity((index + 1) / 20 + 0.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(180),
                    ),
                  ),
                  child: Center(
                      child: AppText(
                    value:
                        'я элемент ${index + 1} с высотой ${200 - (index + 1) * 15}',
                    //textType: TextType.large,
                    dark: false,
                  )),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: purple800,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton<int>(
              value: _screenIndex,
              items:
                  List.generate(5, (index) => {index: 'Элемент ${index + 1}'})
                      .map((e) => DropdownMenuItem<int>(
                            child: AppText(
                              value: e.values.first,
                              dark: false,
                            ),
                            value: e.keys.first,
                            alignment: Alignment.center,
                          ))
                      .toList(),
              onChanged: (e) {
                setState(() {
                  _screenIndex = e!;
                });
              },
              alignment: Alignment.center,
              isExpanded: true,
              dropdownColor: purple800,
              iconEnabledColor: white,
              underline: const Divider(
                color: Colors.transparent,
              ),
            ),
          )
        ],
      ));

  get _table => const AppHeadlineSection(
      title: 'Table',
      description:
          'Виджет, который использует алгоритм компоновки таблицы для своих дочерних элементов.');

  get _tableExample => AppSection(
        child: Column(
          children: [
            const AppText(
                textAlign: TextAlign.start,
                value: 'IntrinsicColumnWidth - '
                    'ширина столбца зависит от внутреннего содержимого ячеек'
                    '\n\nFlexColumnWidth - '
                    'ширина столбца получается из свободного пространства после определения ширины других столбцов'
                    '\n\nFixedColumnWidth - '
                    'фиксированная ширина ячеек'),
            const AppText(
                textType: TextType.code,
                value: '0: IntrinsicColumnWidth(),'
                    '\n1: FlexColumnWidth(),'
                    '\n2: FixedColumnWidth(64),'),
            const SizedBox(
              height: 20,
            ),
            Table(
              border: TableBorder.all(color: purple900),
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(64),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    Container(
                      height: 32,
                      color: purple900,
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.bottom,
                      child: Container(
                          height: 32, color: purple900.withOpacity(0.5)),
                    ),
                    Container(height: 96, color: purple900.withOpacity(0.8)),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color: purple900.withOpacity(0.1),
                  ),
                  children: <Widget>[
                    Container(height: 96, width: 128, color: purple900),
                    Container(height: 32, color: purple900.withOpacity(0.3)),
                    Center(
                      child: Container(height: 32, width: 32, color: purple900),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}
