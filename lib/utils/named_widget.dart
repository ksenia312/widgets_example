import 'package:flutter/material.dart';

class NamedWidget extends StatefulWidget {
  String get name => 'name';

  const NamedWidget({Key? key}) : super(key: key);

  @override
  State<NamedWidget> createState() => _NamedWidgetState();
}

class _NamedWidgetState extends State<NamedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
