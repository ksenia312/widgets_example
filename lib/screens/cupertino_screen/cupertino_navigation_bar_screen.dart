import 'package:flutter/cupertino.dart';
import 'package:widgets_example/widgets/section.dart';

class CupertinoNavigationBarScreen extends StatelessWidget {
  const CupertinoNavigationBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
        middle: const Text('Я бар'),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          AppHeadlineSection(
              title: 'Тут есть бар в стиле IOS', description: 'как дела'),
        ],
      ),
    );
  }
}
