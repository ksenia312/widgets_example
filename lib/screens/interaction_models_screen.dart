import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/messenger.dart';
import 'package:widgets_example/utils/title_widget.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

class InteractionModelScreen extends TitleWidget {
  const InteractionModelScreen({Key? key}) : super(key: key);

  @override
  get title => 'Interaction models';

  @override
  State<InteractionModelScreen> createState() => _InteractionModelScreenState();
}

class _InteractionModelScreenState extends State<InteractionModelScreen>
    with TickerProviderStateMixin {
  final Map<int, String> _deletedItems = {};
  late Map<int, String> _dismissibleItemsMap;

  @override
  void initState() {
    _dismissibleItemsMap =
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _annotation,
        _absorbPointer,
        _absorbPointerExample,
        _dismissible,
        _dismissibleExample
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
    if (_deletedItems.isNotEmpty) {
      var index = _deletedItems.keys.last;
      setState(() {
        _dismissibleItemsMap.addAll({index: _deletedItems.values.last});
      });
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        setState(() {
          _deletedItems.remove(index);
        });
      });
    } else {
      AppMessenger.show(context, value: 'Вы ничего не удалили!');
    }
  }

  _onDismissed(DismissDirection direction, mapEntry) {
    setState(() {
      _deletedItems.addAll({mapEntry.key: mapEntry.value});
      _dismissibleItemsMap.remove(mapEntry.key);
    });
  }

  _returnedDecoration(key) => BoxDecoration(
        boxShadow:
            _deletedItems.values.isNotEmpty && _deletedItems.keys.last == key
                ? [BoxShadow(color: purple800, blurRadius: 3, spreadRadius: 2)]
                : null,
        color: const Color(0xFFEDDDEF),
      );

  SplayTreeMap<int, String> _sortMap(Map<int, String> map) {
    return SplayTreeMap<int, String>.from(map, (a, b) => a.compareTo(b));
  }
}
