import 'package:flutter/material.dart';
import 'package:widgets_example/utils/title_widget.dart';
import 'package:widgets_example/widgets/listview.dart';

class LayoutScreen extends TitleWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  get title => 'Layout';

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return AppListView(children: []);
  }
  
}
