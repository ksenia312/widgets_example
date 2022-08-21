import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets_example/widgets/text_field.dart';
import 'package:widgets_example/utils/title_widget.dart';
import 'package:widgets_example/utils/messenger.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

class InputScreen extends TitleWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  get title => 'Input';

  @override
  State<InputScreen> createState() => _InputState();
}

class _InputState extends State<InputScreen> {
  static const List<String> _kOptions = <String>[
    'привет',
    'привет как дела',
    'привет как настроение',
    'привет ты лучшая',
    'привет ты молодец',
    'привет ты молодец ваще',
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _autoComplete,
        _autoCompleteExample,
        _form,
        _formExample,
        _rowKeyboardListener,
        _rowKeyboardListenerExample
      ],
    );
  }

  get _autoComplete => const AppHeadlineSection(
      title: 'AutoComplete',
      description:
          'Виджет, помогающий пользователю сделать выбор путем ввода некоторого текста и выбора из списка вариантов.');

  get _autoCompleteExample => AppSection(
        child: Column(
          children: [
            const AppText(
              value:
                  'Текст, вводимый пользователем, поступает в поле, построенное с помощью параметра fieldViewBuilder. Параметры для отображения определяются с помощью optionsBuilder и отображаются с помощью optionsViewBuilder.',
            ),
            const SizedBox(
              height: 10,
            ),
            Autocomplete<String>(
              fieldViewBuilder: (BuildContext context,
                  TextEditingController controller,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return AppTextField(
                  controller: controller,
                  focusNode: focusNode,
                  hintText: 'привет как',
                  helperText:
                      'Если вы введете текст по подсказке, то увидите опции',
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return _kOptions.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                AppMessenger.show(context, value: 'Вы выбрали "$selection"');
              },
            )
          ],
        ),
      );

  get _form => const AppHeadlineSection(
      title: 'Form',
      description:
          'Необязательный контейнер для объединения нескольких виджетов полей формы (например, виджетов TextField). \n\nКаждое отдельное поле формы должно быть обернуто в виджет FormField, а виджет Form является их общим предком. Вызывайте методы FormState для сохранения, сброса или проверки каждого поля формы, которое является потомком этой формы. \n\nДля получения состояния FormState можно использовать Form.of с контекстом, предком которого является Form, или передать конструктору Form ключ GlobalKey и вызвать GlobalKey.currentState.');

  get _formExample => AppSection(
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const AppText(
              value:
                  'В этом примере показана форма с одним текстовым полем TextFormField для ввода адреса электронной почты и кнопкой для отправки формы. Для идентификации формы и проверки ввода здесь используется GlobalKey.',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextField(
                hintText: 'Введите ваш email',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите что-нибудь';
                  }
                  AppMessenger.show(context, value: 'Вы что-то ввели!');
                  return null;
                },
              ),
            ),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ));

  get _rowKeyboardListener => const AppHeadlineSection(
      title: 'RowKeyboardListener',
      description:
          'Виджет, который вызывает обратный вызов всякий раз, когда пользователь нажимает или отпускает клавишу на клавиатуре. \n\nRawKeyboardListener полезен для прослушивания необработанных ключевых событий и аппаратных кнопок, представленных в виде клавиш. \nОбычно используется играми и другими приложениями, которые используют клавиатуру не только для ввода текста, но и для других целей. \n\nДля ввода текста рассмотрите возможность использования EditableText, который интегрируется с экранными клавиатурами и редакторами методов ввода (IME).');

  get _rowKeyboardListenerExample {
    var _controller = TextEditingController();
    return AppSection(
        child: Column(
      children: [
        const AppText(
          value: 'Название кнопки высвечивается с помощью следующего поиска:',
        ),
        const AppText(
            textType: TextType.code,
            value:
                'LogicalKeyboardKey.findKeyByKeyId(\nkey.logicalKey.keyId)?.keyLabel'),
        const SizedBox(
          height: 30,
        ),
        RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (key) => _handleKey(key),
          child: AppTextField(
            controller: _controller,
            helperText: 'При нажатии на Backspace высвечивается уведомление',
            hintText: 'Нажмите Backspace',
            onChanged: (_) {
              _controller.clear();
            },
          ),
        ),
      ],
    ));
  }

  _handleKey(RawKeyEvent key) {
    if (key.logicalKey == LogicalKeyboardKey.backspace &&
        key is RawKeyDownEvent) {
      AppMessenger.show(context,
          value:
              "Нажата клавиша ${LogicalKeyboardKey.findKeyByKeyId(key.logicalKey.keyId)?.keyLabel ?? '<NOT DETECTED>'}");
    }
  }
}
