import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/messenger.dart';
import 'package:widgets_example/utils/title_widget.dart';
import 'package:widgets_example/widgets/arrow_painter.dart';
import 'package:widgets_example/widgets/listview.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

import 'draggable_scroll_sheet_screen.dart';

class InteractionModelScreen extends TitleWidget {
  const InteractionModelScreen({Key? key}) : super(key: key);

  @override
  get title => 'Interaction models';

  @override
  State<InteractionModelScreen> createState() => _InteractionModelScreenState();
}

class _InteractionModelScreenState extends State<InteractionModelScreen>
    with TickerProviderStateMixin {
  // dismissible
  final Map<int, String> _dismissibleDeleted = {};
  final Map<int, String> _dismissibleItemsMap =
      Map.fromIterables(List.generate(11, (index) => index), [
    'познакомимся?',
    'как настроение?',
    'ты классный!!',
    'я Ксюша',
    'привет',
    'не удаляй меня пожалуйста!!',
    'я хороший я хороший',
    'абрикос',
    'помнишь колобка? он мой друг',
    'ты подумай',
    'я все знаю.',
  ]);

  // draggable
  int _draggableListLength = 0;
  Color? _draggableColor;
  final List<String> _draggableList = [];
  final ScrollController _scrollController = ScrollController();
  final String _draggableText =
      'на самом деле если говорить откровенно я очень сильно люблю и обожаю всей душой карбонару !!!';

  @override
  Widget build(BuildContext context) {
    return AppListView(
      controller: _scrollController,
      children: [
        _annotation,
        _absorbPointer,
        _absorbPointerExample,
        _dismissible,
        _dismissibleExample,
        _draggable,
        _draggableExample,
        _draggableScrollableSheet,
        _draggableScrollableSheetExample
      ],
    );
  }

  get _annotation => const AppSection(
        child: AppText(
          value:
              'Реагируют на события прикосновения и направляет пользователей к различным видам.\n\nTouch interactions\nRouting',
        ),
      );

  get _absorbPointer => const AppHeadlineSection(
      title: 'AbsorbPointer',
      description:
          'Виджет, который поглощает указатели во время тестирования на попадание. Когда значение absorbing равно true, этот виджет не позволяет своему поддереву получать события указателей, завершая проверку на попадание в себя. Он по-прежнему занимает место при компоновке и рисует свои дочерние элементы как обычно. Он просто не позволяет своим дочерним элементам быть целью расположенных событий, поскольку возвращает true из RenderBox.hitTest.');

  get _absorbPointerExample => AppSection(
          child: Column(
        children: [
          const AppText(
              value:
                  'AbsorbPointer обертывает кнопку на вершине стека, которая поглощает события указателя, не позволяя своей дочерней кнопке и кнопке ниже ее в стеке получать события указателя.'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _drawFigure(isAbsorb: true),
                _drawFigure(isAbsorb: false),
              ],
            ),
          )
        ],
      ));

  _drawFigure({required bool isAbsorb}) {
    var foregroundButton = Container(
      width: 50.0,
      height: 50.0,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: purple900,
        ),
        onPressed: () {},
        child: null,
      ),
    );
    return ConstrainedBox(
      constraints: const BoxConstraints.tightForFinite(height: 160),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {},
              child: null,
            ),
          ),
          isAbsorb
              ? AbsorbPointer(
                  child: foregroundButton,
                )
              : foregroundButton,
          Positioned(
              top: 60,
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightForFinite(width: 150),
                child: AppText(
                  value: isAbsorb
                      ? "нажатие на верхнюю кнопку заблокировано absorb'ом"
                      : "на верхнюю кнопку можно нажать и увидеть анимацию, хоть и onPressed - пустой",
                ),
              ))
        ],
      ),
    );
  }

  get _dismissible => const AppHeadlineSection(
      title: 'Dismissible',
      description:
          'Виджет, который можно убрать, перетащив его в указанном направлении. Перетаскивание или отбрасывание этого виджета в направлении DismissDirection приводит к тому, что дочерний элемент исчезает из поля зрения. После анимации скольжения, если resizeDuration не является null, виджет Dismissible анимирует свою высоту (или ширину, в зависимости от того, что перпендикулярно направлению удаления) до нуля в течение resizeDuration.');

  get _dismissibleExample => AppSection(
          child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: AppText(
                  textAlign: TextAlign.start,
                  value:
                      'Если потянуть вправо - элемент исчезнет. \nЕсли нажать на кнопку - вернется удаленный последний элемент',
                ),
              ),
              IconButton(
                onPressed: _onRestorePressed,
                icon: Icon(Icons.restore, color: purple800),
                tooltip: 'Вернуть последнее удаление',
              )
            ],
          ),
          ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _sortMap(_dismissibleItemsMap).entries.map(
                (mapEntry) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Dismissible(
                      movementDuration: Duration.zero,
                      background: Container(
                        color: purple800,
                      ),
                      key: ValueKey<String>(mapEntry.value),
                      onDismissed: (direction) {
                        _onDismissed(direction, mapEntry);
                      },
                      child: _dismissibleItem(mapEntry),
                    ),
                  );
                },
              ).toList())
        ],
      ));

  _dismissibleItem(mapEntry) => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: double.infinity,
        decoration: _returnedDecoration(mapEntry.key),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: AppText(
            value: mapEntry.value,
          ),
        ),
      );

  void _onRestorePressed() {
    if (_dismissibleDeleted.isNotEmpty) {
      var index = _dismissibleDeleted.keys.last;
      setState(() {
        _dismissibleItemsMap.addAll({index: _dismissibleDeleted.values.last});
      });
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        setState(() {
          _dismissibleDeleted.remove(index);
        });
      });
    } else {
      AppMessenger.show(context, value: 'Вы ничего не удалили!');
    }
  }

  _onDismissed(DismissDirection direction, mapEntry) {
    setState(() {
      _dismissibleDeleted.addAll({mapEntry.key: mapEntry.value});
      _dismissibleItemsMap.remove(mapEntry.key);
    });
  }

  _returnedDecoration(key) => BoxDecoration(
        boxShadow: _dismissibleDeleted.values.isNotEmpty &&
                _dismissibleDeleted.keys.last == key
            ? [BoxShadow(color: purple800, blurRadius: 3, spreadRadius: 2)]
            : null,
        color: const Color(0xFFEDDDEF),
      );

  SplayTreeMap<int, String> _sortMap(Map<int, String> map) {
    return SplayTreeMap<int, String>.from(map, (a, b) => a.compareTo(b));
  }

  get _draggable => const AppHeadlineSection(
      title: 'Draggable',
      description:
          'Виджет, который можно перетащить к цели DragTarget. \n\n Когда перетаскиваемый виджет распознает начало жеста перетаскивания, он отображает виджет обратной связи, который отслеживает перемещение пальца пользователя по экрану. Если пользователь поднимает палец, находясь над целью перетаскивания, этой цели предоставляется возможность принять данные, переносимые перетаскиваемым объектом.');

  get _draggableExample {
    List<Widget> _column =
        _draggableList.map<Widget>((e) => AppText(value: e)).toList();
    _column.addAll([
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Draggable<int>(
            data: 1,
            feedback: _draggableElement(
                size: 50.0,
                color: purple900,
                border: Border.all(color: purple900)),
            childWhenDragging: _draggableElement(
                color: white, border: Border.all(color: purple900)),
            child: _draggableElement(color: purple900),
          ),
          Expanded(
              child: Column(
            children: [
              const AppText(
                value: 'Перетащите левый кружок к правому',
              ),
              CustomPaint(
                size: const Size(200, 50),
                painter: ArrowPainter(),
              ),
            ],
          )),
          DragTarget<int>(
            onMove: (_) {
              setState(() {
                _draggableColor ??= purple900;
              });
            },
            onAcceptWithDetails: (_) {
              setState(() {
                _draggableColor = null;
              });
            },
            onLeave: (_) {
              setState(() {
                _draggableColor = null;
              });
            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return _draggableElement(
                  color: _draggableColor != null
                      ? _draggableColor!
                      : Colors.purple.shade300);
            },
            onAccept: (int value) {
              setState(() {
                _draggableListLength += value;
                if (_draggableListLength <= _draggableText.split(' ').length) {
                  _draggableList
                      .add(_draggableText.split(' ')[_draggableListLength - 1]);
                } else {
                  _draggableList.clear();
                  _draggableListLength = 0;
                }
              });
              if (_draggableList.isNotEmpty) {
                _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent + 20,
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 300));
              }
            },
          ),
        ],
      ),
    ]);
    return AppSection(child: Column(children: _column));
  }

  _draggableElement(
          {double size = 100, required Color color, Border? border}) =>
      Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(size)),
            color: color,
            border: border),
      );

  get _draggableScrollableSheet => const AppHeadlineSection(
      title: 'DraggableScrollSheet',
      description:
          'Контейнер для Scrollable, который реагирует на жесты перетаскивания, изменяя размер прокручиваемого объекта до достижения предела, а затем прокручивая его.');

  get _draggableScrollableSheetExample => AppSection(
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DraggableScrollSheetScreen()));
          },
          child: const AppText(
            value: 'Перейти на страницу с DraggableScrollableSheet',
          ),
        ),
      );
}
