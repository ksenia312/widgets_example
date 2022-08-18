import 'package:flutter/material.dart';
import 'package:widgets_example/utils/text.dart';

import 'colors.dart';

class Section extends StatelessWidget {
  final Widget? child;
  final bool expanded;
  final bool colored;

  const Section(
      {Key? key,
      required this.child,
      this.expanded = false,
      this.colored = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return expanded ? Expanded(child: _container()) : _container();
  }

  _container() => Container(
        margin: const EdgeInsets.only(top: 5, right: 5, left: 5),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: child,
        decoration: SectionDecoration.basic(colored: colored),
      );
}

class SectionDecoration {
  static BoxDecoration basic({bool colored = false}) => BoxDecoration(
        color: colored ? purple900 : white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const [
          BoxShadow(blurRadius: 4, color: Colors.black87, offset: Offset(0, 2))
        ],
      );
}

class HeadlineSection extends StatelessWidget {
  final String title;
  final String description;

  const HeadlineSection(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section(
      colored: true,
      child: Column(
        children: [
          AppText(
            value: title,
            textType: TextType.large,
            dark: false,
          ),
          AppText(
            value: description,
            dark: false,
          )
        ],
      ),
    );
  }
}
