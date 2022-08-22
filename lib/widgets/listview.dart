import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';

class AppListView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;

  const AppListView({Key? key, required this.children, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: scaffold,
      child: ListView(
        controller: controller,
        children: children.followedBy([
          const SizedBox(
            height: 8.0,
          )
        ]).toList(),
      ),
    );
  }
}
