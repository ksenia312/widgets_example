import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/named_widget.dart';
import 'package:widgets_example/utils/sections.dart';
import 'package:widgets_example/utils/text.dart';

class Cupertino extends NamedWidget {
  const Cupertino({Key? key}) : super(key: key);

  @override
  String get name => 'Cupertino';

  @override
  State<Cupertino> createState() => _CupertinoState();
}

class _CupertinoState extends State<Cupertino> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: ListView(
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

  get _annotation => const Section(
        child: CupertinoTextField(
            placeholder: 'Добро пожаловать в мой Iphone 28', enabled: false),
      );

  get _cupertinoActionSheet => const HeadlineSection(
      title: 'CupertinoActionSheet', description: 'Лист действий в стиле iOS.');

  get _cupertinoActionSheetExample => Section(
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

  get _cupertinoActivityIndicator => const HeadlineSection(
      title: 'CupertinoActivityIndicator ',
      description:
          'Индикатор активности в стиле iOS, вращающийся по часовой стрелке.');

  get _cupertinoActivityIndicatorExample => const Section(
        child: CupertinoActivityIndicator(radius: 20),
      );

  get _cupertinoAlertDialog => const HeadlineSection(
      title: 'CupertinoAlertDialog',
      description: 'Диалоговое окно оповещения в стиле iOS.');

  get _cupertinoAlertDialogExample => Section(
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

  get _cupertinoButton => const HeadlineSection(
      title: 'CupertinoButton',
      description:
          'Кнопка в стиле iOS. Принимает текст или значок, который исчезает и появляется при прикосновении. По желанию может иметь фон. По умолчанию отступ составляет 16,0 пикселей. При использовании CupertinoButton внутри родительского элемента фиксированной высоты, например CupertinoNavigationBar, следует использовать меньший или даже EdgeInsets.zero, чтобы предотвратить обрезание более крупных дочерних виджетов.');

  get _cupertinoButtonExample => Section(
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

  get _cupertinoContextMenu => const HeadlineSection(
      title: 'CupertinoContextMenu',
      description:
          'Полноэкранный модальный маршрут, который открывается при длительном нажатии на дочернее меню. При открытии CupertinoContextMenu показывает дочерний элемент или виджет, возвращаемый previewBuilder, если он задан, в большом полноэкранном Overlay со списком кнопок, заданных действиями. Ребенок/превью помещается в расширенный виджет, так что он будет расти и заполнять оверлей, если его размер не ограничен.');

  get _cupertinoContextMenuExample => Section(
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
              child: Section(
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

  get _cupertinoNavigationBar => const HeadlineSection(
      title: 'CupertinoNavigationBar',
      description:
          'An iOS-styled navigation bar. The navigation bar is a toolbar that minimally consists of a widget, normally a page title, in the middle of the toolbar.');

  get _cupertinoNavigationBarExample => Section(
        child: CupertinoButton.filled(
            child: const Text(
              'Перейти на страницу с CupertinoNavigationBar',
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      // Try removing opacity to observe the lack of a blur effect and of sliding content.
                      backgroundColor:
                          CupertinoColors.systemGrey.withOpacity(0.5),
                      middle: const Text('Я бар'),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        HeadlineSection(
                            title: 'Тут есть бар в стиле IOS',
                            description: 'как дела'),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
  
}
