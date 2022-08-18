import 'package:flutter/material.dart';

import 'colors.dart';

enum TextType { small, medium, large }

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.value,
      style: getThemeByType(widget.textType)
          .copyWith(color: widget.dark ? null : white),
      textAlign: widget.textAlign,
    );
  }
}
