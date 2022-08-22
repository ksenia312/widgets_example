import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/widgets/text.dart';

class AppSection extends StatelessWidget {
  final Widget? child;
  final bool expanded;
  final bool colored;

  const AppSection(
      {Key? key,
      required this.child,
      this.expanded = false,
      this.colored = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return expanded
        ? Expanded(child: _decoratedContainer)
        : _decoratedContainer;
  }

  Container get _decoratedContainer => Container(
        margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: child,
        decoration: _sectionDecoration,
      );

  BoxDecoration get _sectionDecoration => BoxDecoration(
        color: colored ? purple900 : white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              color: Colors.purple.shade700,
              offset: const Offset(0, 1))
        ],
      );
}

class AppHeadlineSection extends StatelessWidget {
  final String title;
  final String description;

  const AppHeadlineSection(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppSection(
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