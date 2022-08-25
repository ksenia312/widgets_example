import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/title_widget.dart';
import 'package:widgets_example/widgets/listview.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

class BasicsScreen extends TitleWidget {
  @override
  String get title => 'Basics';

  const BasicsScreen({Key? key}) : super(key: key);

  @override
  State<BasicsScreen> createState() => _BasicsState();
}

class _BasicsState extends State<BasicsScreen> {
  bool showCleanColumn = false;

  @override
  Widget build(BuildContext context) {
    return showCleanColumn ? _cleanColumn : _mainListView;
  }

  get _mainListView => AppListView(
        children: [
          _redirectButton,
          _column,
          _sizedBoxColumn,
          _sizedBoxColumnCenter,
          _row,
          _rowCenter,
          _rowSizedBoxCenter,
          _placeholder,
          _placeholderColumn,
          _placeholderRow
        ],
      );

  get _cleanColumn => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
                  color: white,
                  child: const AppText(
                      value:
                          'Высота не задана, но я внутри Expanded контейнера'))),
          Expanded(
            child: Container(
              color: white,
              child: const Center(
                child: AppText(
                  value: 'А я внутри Center в Expanded контейнере',
                ),
              ),
            ),
          ),
          Container(
            color: white,
            child: const Center(
              child: AppText(
                value:
                    'А я внутри Center, но не в Expanded контейнере. Рисуюсь по максимальной высоте контента, а ширина максимальная доступная',
              ),
            ),
          ),
          Container(
              height: 170,
              color: white,
              child: const Center(
                child: AppText(
                  value:
                      'Я внутри Center, но не в Expanded контейнере. Моя высота - 170',
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                  color: white,
                  child: const Center(
                    child: AppText(
                      value:
                          'Я внутри Expanded контейнера с flex=2. Я автоматически заполняю в 2 раза больше пространства, чем доступно автоматически заполнить остальным (при равном распределении контента)',
                    ),
                  ))),
          _redirectButton
        ],
      );

  get _redirectButton => AppSection(
          child: OutlinedButton(
        child: Text(showCleanColumn
            ? 'Вернуться к ListView'
            : 'Посмотреть Column без ListView'),
        onPressed: () {
          setState(() {
            showCleanColumn = !showCleanColumn;
          });
        },
      ));

  get _column => AppSection(
        colored: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
                value: 'Column', dark: false, textType: TextType.large),
            Container(
              color: white,
              child: const AppText(value: 'Я в контейнере'),
            ),
            const AppText(
                value:
                    'Мы не можем использовать Expanded пока для Column не задана высота. Здесь установлен textAlign center и строк больше одной, поэтому CrossAxisAlignment.start не повлиял на этот блок',
                dark: false),
            Container(
              color: white,
              child: const AppText(
                value:
                    'Это строение вертикально в ряд. Здесь зададим textAlign start, чтобы текст тоже поехал',
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
      );

  get _sizedBoxColumn => AppSection(
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AppText(
                value: 'SizedBox( height: 200, child: Column )',
                textType: TextType.large,
              ),
              Expanded(
                child: Container(
                  color: purple900,
                  child: const AppText(
                    value: 'Я в Expanded контейнере',
                    dark: false,
                  ),
                ),
              ),
              const AppText(
                value:
                    '\nExpanded обозначает заполнение максимального доступного объема по главной оси. Ширина будет по контенту, если ее не задать.',
              )
            ],
          ),
        ),
      );

  get _sizedBoxColumnCenter => AppSection(
        child: SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const AppText(
                value: 'Column with Center',
                textType: TextType.large,
              ),
              Expanded(
                child: Container(
                  color: purple900,
                  child: const Center(
                      child: AppText(
                    value: 'Я в Expanded контейнере, и в Center',
                    dark: false,
                  )),
                ),
              ),
              const AppText(
                value:
                    '\nВиджет Center используется для центрирования своего дочернего элемента внутри себя (как по вертикали, так и по горизонтали). Так как ему нужно центрировать текст внутри себя, он центрирует относительно всего доступного объема и по ширине, поэтому он стал больше. \n\nMainAxisAlignment.end игнорируется, потому что есть блок, заполняющий все пространство',
              ),
            ],
          ),
        ),
      );

  get _row => AppSection(
        colored: true,
        child: Row(
          children: [
            const Expanded(
              child: AppText(
                value: 'Row',
                textType: TextType.large,
                dark: false,
              ),
            ),
            const Expanded(
              flex: 3,
              child: AppText(
                value:
                    'Здесь нет скролла по горизонтали, значит Row ограничен шириной экрана и мы можем использовать Expanded. Более того, так как в Row у нас текст, мы используем Expanded везде, иначе он пишется в одну строку, так как не видит ограничений ширины внутри Row и мы выходим из экрана.',
                dark: false,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: white,
                child: const AppText(
                  value: 'Это строение горизонтально в ряд',
                ),
              ),
            )
          ],
        ),
      );

  get _rowCenter => AppSection(
        child: Row(
          children: [
            const Expanded(
              child: AppText(
                value: 'Row with Center',
                textType: TextType.large,
              ),
            ),
            const Expanded(
                flex: 4,
                child: AppText(
                  value:
                      'Почему мой ряд имеет желто-черную предупредительную полосу? Если негибкое содержимое строки (то, что не заключено в расширенные или гибкие виджеты) вместе шире, чем сама строка, то считается, что строка переполнена. Когда строка переполняется, в строке не остается места, которое можно разделить между ее дочерними элементами Expanded и Flexible. Строка сообщает об этом, рисуя желтую и черную полосатую предупреждающую рамку на переполненном краю.',
                )),
            Expanded(
              flex: 3,
              child: Container(
                color: purple900,
                child: const Center(
                  child: AppText(
                    value:
                        'Я в Expanded контейнере, и в Center. Как видим, Center не расширил блок до предела. Но у нашей строки и не задана высота, она рисуется по контенту',
                    dark: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  get _rowSizedBoxCenter => AppSection(
        child: SizedBox(
          height: 200,
          child: Row(
            children: [
              const Expanded(
                child: AppText(
                  value: 'Row with SizedBox and Center',
                  textType: TextType.large,
                ),
              ),
              const Expanded(
                flex: 2,
                child: AppText(
                  value:
                      'Высота строки - 200. Сработало! Теперь Center видит границу высоты строки, а значит центрирует текст и относительно ее',
                ),
              ),
              Expanded(
                child: Container(
                  color: purple900,
                  child: const Center(
                    child: AppText(
                      value: 'Я в Expanded контейнере, и в Center.',
                      dark: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  get _placeholder => const AppHeadlineSection(
        title: 'Placeholder',
        description:
            'Виджет, который рисует поле, представляющее собой место, куда однажды будут добавлены другие виджеты.Этот виджет полезен во время разработки, чтобы указать, что интерфейс еще не завершен.',
      );

  get _placeholderColumn => AppSection(
        child: Column(
          children: [
            const AppText(
                value:
                    'Я Placeholder, я рисую крестик. По умолчанию размер заполнителя соответствует размеру его контейнера. Если заполнитель находится в неограниченном пространстве, он будет иметь размер в соответствии с заданными значениями fallbackWidth и fallbackHeight.'),
            const AppText(
                value:
                    '\nЗаданы оба параметра. Применяется только высота, так как в колонке неограничена только высота. Наша колонка рисуется по ширине экрана, и эта ширина и так ограничена, поэтому заданная ширина игнорируется, она не имеет приоритет.\n'),
            Placeholder(
              color: purple800,
              fallbackHeight: 150,
              fallbackWidth: 150,
            ),
          ],
        ),
      );

  get _placeholderRow => AppSection(
        child: SizedBox(
          height: 400,
          child: Row(
            children: [
              const Expanded(
                child: AppText(
                    textType: TextType.large,
                    value: 'Place-holder. Я в строке высотой 400.'),
              ),
              const Expanded(
                child: AppText(
                    value:
                        'Заданы оба параметра. Применяется только ширина, так как в строке неограничена только ширина. Наша строка рисуется по заданной высоте, и эта высота и так ограничена, поэтому заданная высота игнорируется, она не имеет приоритет.'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Placeholder(
                  color: purple800,
                  fallbackHeight: 150,
                  fallbackWidth: 150,
                ),
              ),
            ],
          ),
        ),
      );
}
