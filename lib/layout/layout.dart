import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/named_widget.dart';

import 'accessibility.dart';
import 'animations.dart';
import 'basics.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final List<NamedWidget> _screens = [
    const Accessibility(),
    const Animations(),
    const Basics()
  ];
  int? _screenIndex = 0;

  void _onChanged(int? value) {
    setState(() {
      _screenIndex = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: DropdownButton<int>(
            value: _screenIndex,
            items: _getItems(),
            onChanged: _onChanged,
            alignment: Alignment.center,
            isExpanded: true,
            dropdownColor: white,
            icon: _icon(),
            style: _textStyle(),
            underline: const Divider(color: Colors.transparent),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Center(
          child: AnimatedSwitcher(
            child: _screens.elementAt(_screenIndex ?? 0),
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }

  _textStyle() =>
      TextStyle(color: purple900, fontSize: 16, fontWeight: FontWeight.w900);

  _icon() => Icon(
        Icons.arrow_drop_down,
        color: purple900,
      );

  _getItems() => _screens
      .map((e) => DropdownMenuItem<int>(
            child: Text(e.name),
            value: _screens.indexOf(e),
            alignment: Alignment.center,
          ))
      .toList();
}
