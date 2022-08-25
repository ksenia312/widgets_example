import 'package:flutter/material.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const AppText(
            value: 'TabBar Screen',
            textType: TextType.large,
            dark: false,
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.emoji_emotions_outlined),
              ),
              Tab(
                icon: Icon(Icons.code),
              ),
              Tab(
                icon: Icon(Icons.emoji_emotions_outlined),
              ),
              Tab(
                icon: Icon(Icons.code),
              ),
              Tab(
                icon: Icon(Icons.emoji_emotions_outlined),
              ),
              Tab(
                icon: Icon(Icons.code),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _textSection('Я внутри TabBarView!'),
            _textSection(
                'body: const TabBarView(\n   children: <Widget>[\n ...\n]',
                textType: TextType.code),
            _textSection('Вкладки наверху - Tab, они находятся внутри TabBar'),
            _textSection(
                'bottom: const TabBar(\n   tabs: <Widget>[\n      Tab( ... ),\n      Tab( ... ),\n      Tab( ... ),\n      Tab( ... ),\n      Tab( ... ),\n      Tab( ... ),\n])',
                textType: TextType.code),
            _textSection(
                'Все это дело обернуто в Scaffold, а у него уже указан TabBar в качестве параметра bottom. \n\nScaffold же - ребенок DefaultTabController, так как TabBar иначе не заработает, ему нужен контроллер. Кастомный или дефолтный'),
            _textSection(
                'DefaultTabController(\n   child: Scaffold(\n      bottom: const TabBar(),\n   ),\n)',
                textType: TextType.code),
          ],
        ),
      ),
    );
  }

  _textSection(String text, {TextType textType = TextType.medium}) => Center(
        child: AppSection(
          child: AppText(
            value: text,
            textType: textType,
          ),
        ),
      );
}
