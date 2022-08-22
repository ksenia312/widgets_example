import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/title_widget.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

class AnnotationScreen extends TitleWidget {
  final Function(int) setDropDownValue;

  const AnnotationScreen({Key? key, required this.setDropDownValue})
      : super(key: key);

  @override
  get title => 'Annotation';

  @override
  State<AnnotationScreen> createState() => _AnnotationScreenState();
}

class _AnnotationScreenState extends State<AnnotationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: scaffold,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppHeadlineSection(
              title: 'Приветствую! Меня зовут Ксения',
              description:
                  'Это мое тестовое приложение, где отображены основные виджеты по категориям из документации Flutter'),
          AppSection(
              child: Column(
            children: [
              OutlinedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.category, size: 20, color: purple800),
                    const SizedBox(width: 5),
                    const AppText(value: 'Перейти к категориям'),
                  ],
                ),
                onPressed: () {
                  widget.setDropDownValue(1);
                },
              ),
              OutlinedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    FlutterLogo(size: 20),
                    SizedBox(width: 5),
                    AppText(value: 'Открыть документацию'),
                  ],
                ),
                onPressed: () async {
                  await launchUrl(
                      Uri(
                          scheme: 'https',
                          host: 'docs.flutter.dev',
                          path: 'development/ui/widgets'),
                      mode: LaunchMode.externalApplication);
                },
              ),
            ],
          )),
        ],
      ),
    );
  }
}
