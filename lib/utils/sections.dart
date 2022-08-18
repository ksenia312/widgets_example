import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final Widget? child;
  final bool expanded;
  final bool colored;

  const Section(
      {Key? key,
      required this.child,
      this.expanded = false,
      this.colored = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return expanded ? Expanded(child: _container()) : _container();
  }

  _container() => Container(
        margin: const EdgeInsets.only(top: 5, right: 5, left: 5),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: child,
        decoration: SectionDecoration.basic(colored: colored),
      );
}

class SectionDecoration {
  static BoxDecoration basic({bool colored = false}) => BoxDecoration(
        color: colored ? Colors.purple.shade900 : Color(0xFFF3E8F5),
        borderRadius: BorderRadius.all(const Radius.circular(10)),
        //border: colored
        //? Border.all(color: const Color(0xFF945DD7))
        //: Border.all(color: Colors.purpleAccent),
       boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Colors.black87,
              offset: Offset(0, 2))
        ],
      );
}
