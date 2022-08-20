import 'package:flutter/material.dart';

import 'colors.dart';

enum TextType { small, medium, large, code }

class AppText extends StatefulWidget {
  final String value;
  final TextType textType;
  final bool dark;
  final TextAlign textAlign;

  const AppText({
    Key? key,
    required this.value,
    this.textType = TextType.medium,
    this.dark = true,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  TextStyle getThemeByType(TextType type) {
    switch (type) {
      case TextType.small:
        return Theme.of(context).textTheme.bodySmall!;
      case TextType.medium:
        return Theme.of(context).textTheme.bodyMedium!;
      case TextType.large:
        return Theme.of(context).textTheme.bodyLarge!;
      case TextType.code:
        return Theme.of(context).textTheme.bodyMedium!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.textType == TextType.code
        ? Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
                color: widget.dark
                    ? Colors.purple.withOpacity(0.1)
                    : purple900.withOpacity(0.7),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: _codeText,
          )
        : _text;
  }

  Text get _text => Text(
        widget.value,
        style: getThemeByType(widget.textType)
            .copyWith(color: widget.dark ? null : white),
        textAlign: widget.textAlign,
      );

  Text get _codeText => Text(
        widget.value,
        style: getThemeByType(widget.textType).copyWith(
            color: widget.dark ? purple900 : white,
            fontWeight: FontWeight.w900,
            fontFamily: 'Monospace'),
        textAlign: TextAlign.start,
      );
}
