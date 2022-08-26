import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/title_widget.dart';
import 'package:widgets_example/widgets/listview.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

import 'cupertino_navigation_bar_screen.dart';

class CupertinoScreen extends TitleWidget {
  const CupertinoScreen({Key? key}) : super(key: key);

  @override
  String get title => 'Cupertino';

  @override
  State<CupertinoScreen> createState() => _CupertinoState();
}

class _CupertinoState extends State<CupertinoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: AppListView(
        children: [
          _annotation,
          _cupertinoActionSheet,
          _cupertinoActionSheetExample,
          _cupertinoActivityIndicator,
          _cupertinoActivityIndicatorExample,
          _cupertinoAlertDialog,
          _cupertinoAlertDialogExample,
          _cupertinoButton,
          _cupertinoButtonExample,
          _cupertinoContextMenu,
          _cupertinoContextMenuExample,
          _cupertinoNavigationBar,
          _cupertinoNavigationBarExample
        ],
      ),
    );
  }

  get _annotation => const AppSection(
        child: CupertinoTextField(
            placeholder: 'Добро пожаловать в мой Iphone 28', enabled: false),
      );

  get _cupertinoActionSheet => const AppHeadlineSection(
      title: 'CupertinoActionSheet', description: 'Лист действий в стиле iOS.');

  get _cupertinoActionSheetExample => AppSection(
        child: CupertinoButton.filled(
          onPressed: _showCupertinoActionSheet,
          child: const Text(
            'Открыть действия',
          ),
        ),
      );

  _showCupertinoActionSheet() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Базовое действие'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Действие'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Разрушительное действие'),
          )
        ],
      ),
    );
  }

  get _cupertinoActivityIndicator => const AppHeadlineSection(
      title: 'CupertinoActivityIndicator ',
      description:
          'Индикатор активности в стиле iOS, вращающийся по часовой стрелке.');

  get _cupertinoActivityIndicatorExample => const AppSection(
        child: CupertinoActivityIndicator(radius: 20),
      );

  get _cupertinoAlertDialog => const AppHeadlineSection(
      title: 'CupertinoAlertDialog',
      description: 'Диалоговое окно оповещения в стиле iOS.');

  get _cupertinoAlertDialogExample => AppSection(
          child: Column(
        children: [
          const AppText(
              value:
                  'Все диалоги и сообщения в IOS делаются с помощью конструкции'),
          const AppText(
              textType: TextType.code,
              value:
                  'showCupertinoModalPopup<void>(context: context, builder: (BuildContext context) => Widget);'),
          CupertinoButton.filled(
            onPressed: () {
              _showCupertinoAlertDialog(false);
            },
            child: const Text(
              '2 действия',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CupertinoButton(
            onPressed: () {
              _showCupertinoAlertDialog(true);
            },
            child: const Text('3 действия'),
          ),
        ],
      ));

  _showCupertinoAlertDialog(bool isColumn) {
    List<CupertinoDialogAction> _actions = [
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Нет'),
      ),
      CupertinoDialogAction(
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Да'),
      )
    ];
    if (isColumn) {
      _actions.insert(
        1,
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Я не знаю'),
        ),
      );
    }
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Уведомление'),
        content: const Text('Сделать что-то плохое?'),
        actions: _actions,
      ),
    );
  }

  get _cupertinoButton => const AppHeadlineSection(
      title: 'CupertinoButton',
      description:
          'Кнопка в стиле iOS. Принимает текст или значок, который исчезает и появляется при прикосновении. По желанию может иметь фон. По умолчанию отступ составляет 16,0 пикселей. При использовании CupertinoButton внутри родительского элемента фиксированной высоты, например CupertinoNavigationBar, следует использовать меньший или даже EdgeInsets.zero, чтобы предотвратить обрезание более крупных дочерних виджетов.');

  get _cupertinoButtonExample => AppSection(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: const [
                  AppText(
                      value:
                          'На этой странице мы уже использовали кнопки в стиле IOS, но здесь примеры разных вариаций. \nЕсли мы ставим'),
                  AppText(textType: TextType.code, value: 'onPressed: null,'),
                  AppText(
                      value:
                          'то кнопка понимает, что она заблокирована и применяет соответствующие стили. В остальных кнопках я такого не видела (Только отсутствие окрашивания цветом при нажатии)'),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CupertinoButton(
                  onPressed: null,
                  child: Text('Disabled'),
                ),
                const SizedBox(height: 10),
                const CupertinoButton.filled(
                  onPressed: null,
                  child: Text('Disabled'),
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  onPressed: () {},
                  child: const Text('Enabled'),
                ),
                const SizedBox(height: 10),
                CupertinoButton.filled(
                  onPressed: () {},
                  child: const Text('Enabled'),
                ),
              ],
            ),
          ],
        ),
      );

  get _cupertinoContextMenu => const AppHeadlineSection(
      title: 'CupertinoContextMenu',
      description:
          'Полноэкранный модальный маршрут, который открывается при длительном нажатии на дочернее меню. При открытии CupertinoContextMenu показывает дочерний элемент или виджет, возвращаемый previewBuilder, если он задан, в большом полноэкранном Overlay со списком кнопок, заданных действиями. Ребенок/превью помещается в расширенный виджет, так что он будет расти и заполнять оверлей, если его размер не ограничен.');

  get _cupertinoContextMenuExample => AppSection(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CupertinoContextMenu(
            actions: <Widget>[
              CupertinoContextMenuAction(
                child: const Text('Я круче'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoContextMenuAction(
                child: const Text('Ты молодец'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            child: Center(
              child: AppSection(
                child: Row(
                  children: [
                    const Expanded(
                      child: AppText(
                        value: 'Я крутой',
                        textType: TextType.large,
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: purple900,
                    ),
                    Icon(
                      Icons.done,
                      color: purple900,
                    ),
                    Icon(
                      Icons.supervisor_account,
                      color: purple900,
                    ),
                    Icon(
                      Icons.emoji_events,
                      color: purple900,
                    ),
                    Icon(
                      Icons.emoji_emotions,
                      color: purple900,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  get _cupertinoNavigationBar => const AppHeadlineSection(
      title: 'CupertinoNavigationBar',
      description:
          'An iOS-styled navigation bar. The navigation bar is a toolbar that minimally consists of a widget, normally a page title, in the middle of the toolbar.');

  get _cupertinoNavigationBarExample => AppSection(
        child: CupertinoButton.filled(
            child: const Text(
              'Перейти на страницу с CupertinoNavigationBar',
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CupertinoNavigationBarScreen(),
                ),
              );
            }),
      );

}
