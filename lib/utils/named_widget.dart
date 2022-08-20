import 'package:flutter/material.dart';

class NamedWidget extends StatefulWidget {
  const NamedWidget({Key? key}) : super(key: key);

  String get name => '';

  @override
  State<NamedWidget> createState() => _NamedWidgetState();
}

class _NamedWidgetState extends State<NamedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
