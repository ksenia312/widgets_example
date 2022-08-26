import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/widgets/text.dart';

class RefreshIndicatorScreen extends StatefulWidget {
  const RefreshIndicatorScreen({Key? key}) : super(key: key);

  @override
  State<RefreshIndicatorScreen> createState() => _RefreshIndicatorScreenState();
}

class _RefreshIndicatorScreenState extends State<RefreshIndicatorScreen> {
  late List<String> data;

  @override
  void initState() {
    data = List.generate(5, (index) => 'я ребенок ${index + 1}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppText(
            value: "RefreshIndicator",
            dark: false,
            textType: TextType.large,
          ),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              updateData();
            },
            child: ListView(
              children: List.generate(
                data.length + 1,
                (index) => Card(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors
                        .purple[index != 0 ? 400 + ((index - 1) % 5) * 100 : 0],
                    child: AppText(
                        value: index == 0
                            ? 'Проведите пальцем по экрану для обновления'
                            : data[index - 1],
                        dark: index == 0),
                  ),
                ),
              ),
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              itemExtent: 50,
            ),
            color: Colors.white,
            backgroundColor: purple900,
            triggerMode: RefreshIndicatorTriggerMode.anywhere));
  }

  void updateData() {
    int i = data.length + 1;
    data.addAll(List.generate(5, (index) => "я ребенок ${i + index}"));
    setState(() {});
  }
}
