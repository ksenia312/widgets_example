import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

class DraggableScrollSheetScreen extends StatefulWidget {
  const DraggableScrollSheetScreen({Key? key}) : super(key: key);

  @override
  State<DraggableScrollSheetScreen> createState() =>
      _DraggableScrollSheetScreenState();
}

class _DraggableScrollSheetScreenState
    extends State<DraggableScrollSheetScreen> {
  final List<int> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const AppText(
          value: 'DraggableScrollableSheet',
          textType: TextType.large,
          dark: false,
        ),
      ),
      body: Stack(children: [
        SizedBox.expand(
          child: Column(
            children: [
              AppSection(
                child: AppText(
                  value:
                      'Выбранные элементы: ${_selectedItems.isNotEmpty ? '\n${_selectedItems.join(', ')}' : ''}',
                  textType: TextType.large,
                ),
              ),
              const AppSection(
                  child: AppText(
                      value:
                          'Можно потянуть список снизу, и он вылезает!! \n\nЭлемент выбирается нажатием на звездочку. Аналогично элемент убирается нажатием на звездочку'))
            ],
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.25,
          maxChildSize: 0.7,
          minChildSize: 0.25,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      color: purple900,
                      offset: const Offset(0, 2))
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                controller: scrollController,
                itemCount: 25,
                itemBuilder: (BuildContext context, int builderIndex) {
                  int index = builderIndex + 1;
                  bool _selected = _selectedItems.any((el) => el == index);
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 1.5, color: Colors.grey[300]!),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          _selected
                              ? _selectedItems.removeWhere((el) => el == index)
                              : _selectedItems.add(index);
                          _selectedItems.sort((a, b) => a.compareTo(b));
                        });
                      },
                      title: AppText(
                        value: 'Я элемент №$index',
                        textAlign: TextAlign.start,
                      ),
                      leading: Icon(Icons.emoji_emotions, color: purple800),
                      trailing: _selected
                          ? const Icon(Icons.star)
                          : const Icon(Icons.star_outline),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ]),
    );
  }
}
