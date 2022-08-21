import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/widgets/text.dart';

class AppMessenger {
  static SnackBar _snackBar({required String value}) => SnackBar(
        content: AppText(value: value, dark: false,),
        duration: const Duration(seconds: 1),
       /* margin: const EdgeInsets.all(5.0),*/
        padding: const EdgeInsets.all(15.0),
        backgroundColor: purple800,
      );

  static void show(context, {required String value}) {
    ScaffoldMessenger.of(context).showSnackBar(
      _snackBar(value: value),
    );
  }
}
