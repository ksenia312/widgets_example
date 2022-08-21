import 'package:flutter/material.dart';
import 'package:widgets_example/screens/cupertino_screen.dart';
import 'package:widgets_example/screens/interaction_models_screen.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/title_widget.dart';

/*import 'accessibility_screen.dart';*/
import 'animations_screen.dart';
import 'assets_screen.dart';
import 'basics_screen.dart';
import 'input_screen.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final List<TitleWidget> _screens = [
    const BasicsScreen(),
    /*const AccessibilityScreen(),*/
    const AnimationsScreen(),
    const AssetsScreen(),
    const CupertinoScreen(),
    const InputScreen(),
    const InteractionModelScreen()
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
      body: Center(
        child: AnimatedSwitcher(
          child: _screens.elementAt(_screenIndex ?? 0),
          duration: const Duration(milliseconds: 700),
          switchInCurve: Curves.fastOutSlowIn,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
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
            child: Text(e.title),
            value: _screens.indexOf(e),
            alignment: Alignment.center,
          ))
      .toList();
}
