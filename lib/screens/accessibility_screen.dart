import 'package:flutter/material.dart';
import 'package:widgets_example/widgets/text.dart';
import '../widgets/section.dart';
import '../utils/title_widget.dart';

class AccessibilityScreen extends TitleWidget {
  @override
  String get title => 'Accessibility';

  const AccessibilityScreen({Key? key}) : super(key: key);

  @override
  State<AccessibilityScreen> createState() => _AccessibilityState();
}

class _AccessibilityState extends State<AccessibilityScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppSection(
          colored: true,
          child: AppText(
            value: 'Доступность',
            dark: false,
            textType: TextType.large,
          ),
        ),
        const AppSection(
          colored: true,
          child: AppText(
              value:
                  'Семантика - это виджет, который аннотирует дерево виджетов описанием смысла виджетов. Используется инструментами доступности, поисковыми системами и другими программами семантического анализа для определения смысла приложения. Семантика - это мощный виджет, который добавляет "функции" дочернему виджету, например, устанавливает его в качестве заголовка, дает ему возможности "кнопки" и теги и т.д. ',
              dark: false),
        ),
        AppSection(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              AppText(
                value: 'ExcludeSemantics',
                textType: TextType.large,
              ),
              AppText(
                value:
                    'Исключает поддерево из дерева семантики (что может быть полезно, если оно, например, полностью декоративно и не важно для пользователя).\n',
              ),
              ExcludeSemantics(
                  excluding: true,
                  child: AppText(value: 'It\'s ExcludeSemantics widget')),
            ],
          ),
        ),
        const AppSection(child: SemanticsExample()),
      ],
    );
  }
}

class SemanticsExample extends StatefulWidget {
  const SemanticsExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SemanticsExampleState();
  }
}

class _SemanticsExampleState extends State<SemanticsExample> {
  bool _showCard = false;

  Widget _buildCard() {
    return Card(
      color: Colors.purple,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            title: AppText(
                value: 'Сейчас семантика остального заблокирована',
                textAlign: TextAlign.start,
                dark: false),
          ),
          ButtonTheme(
            child: ButtonBar(
              children: <Widget>[
                TextButton(
                  child: const AppText(
                    value: 'OK',
                    textType: TextType.small,
                    dark: false,
                  ),
                  onPressed: () => setState(() {
                    _showCard = false;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          BlockSemantics(
            blocking: _showCard,
            child: Column(
              children: [
                const AppText(
                  value: 'BlockSemantics',
                  textType: TextType.large,
                ),
                const AppText(
                  value:
                      'Виджет, который сохраняет семантику всех виджетов, которые были нарисованы до него в том же семантическом контейнере. Это полезно для скрытия виджетов от инструментов доступности, которые нарисованы за определенным виджетом, например, оповещение обычно запрещает взаимодействие с любым виджетом, расположенным "за" оповещением (даже если они все еще частично видны).',
                ),
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Доступна внутри семантического контейнера'),
                      duration: Duration(seconds: 1),
                    ));
                  },
                  child: const Text('Проверка доступности'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: OutlinedButton(
              child: const Text('Show Card'),
              onPressed: () => setState(() {
                _showCard = true;
              }),
            ),
          ),
          BlockSemantics(
            blocking: _showCard,
            child: Visibility(
              visible: _showCard,
              child: _buildCard(),
            ),
          )
        ],
      ),
    );
  }
}
