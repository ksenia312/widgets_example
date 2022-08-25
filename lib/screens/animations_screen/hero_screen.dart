import 'package:flutter/material.dart';
import 'package:widgets_example/widgets/section.dart';
import 'package:widgets_example/widgets/text.dart';

class HeroScreen extends StatelessWidget {
  final Widget heroChild;
  const HeroScreen({Key? key, required this.heroChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          value: 'Описание колобка',
          dark: false,
          textType: TextType.large,
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          child: AppSection(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'hero-rectangle',
                  child: heroChild,
                ),
                const AppText(
                  value: 'я колобок',
                  textType: TextType.large,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
