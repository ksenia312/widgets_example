import 'package:flutter/material.dart';
import 'package:widgets_example/screens/cupertino_screen/cupertino_screen.dart';
import 'package:widgets_example/screens/interaction_models_screen/interaction_models_screen.dart';
import 'package:widgets_example/screens/scrolling_screen/scrolling_screen.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/title_widget.dart';

import 'animations_screen/animations_screen.dart';
import 'annotation_screen/annotation_screen.dart';
import 'assets_screen/assets_screen.dart';
import 'basics_screen/basics_screen.dart';
import 'input_screen/input_screen.dart';
import 'layout_screen/layout_screen.dart';
import 'material_components_screen/material_components_screen.dart';
import 'painting_screen/painting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _screenIndex = 0;

  void _onChanged(int? value) {
    setState(() {
      _screenIndex = value!;
    });
  }

  Function(int) get setDropDownValue => _onChanged;

  @override
  Widget build(BuildContext context) {
    final List<TitleWidget> _screens = [
      AnnotationScreen(setDropDownValue: setDropDownValue),
      const BasicsScreen(),
      const AnimationsScreen(),
      const AssetsScreen(),
      const CupertinoScreen(),
      const InputScreen(),
      const InteractionModelScreen(),
      const LayoutScreen(),
      const MaterialComponentsScreen(),
      const PaintingScreen(),
      const ScrollingScreen()
    ];
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: DropdownButton<int>(
            value: _screenIndex,
            items: _getItems(_screens),
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

  _getItems(List<TitleWidget> screens) => screens
      .map((e) => DropdownMenuItem<int>(
            child: Text(e.title),
            value: screens.indexOf(e),
            alignment: Alignment.center,
          ))
      .toList();
}
