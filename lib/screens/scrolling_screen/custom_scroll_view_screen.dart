import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/widgets/text.dart';

enum SliverFixedExtentListCount { count10, count50, countInfinity }

class CustomScrollViewScreen extends StatefulWidget {
  const CustomScrollViewScreen({Key? key}) : super(key: key);

  @override
  State<CustomScrollViewScreen> createState() => _CustomScrollViewScreenState();
}

class _CustomScrollViewScreenState extends State<CustomScrollViewScreen> {
  static const Map<SliverFixedExtentListCount, String> _names = {
    SliverFixedExtentListCount.count10: '10 элементов',
    SliverFixedExtentListCount.count50: '50 элементов',
    SliverFixedExtentListCount.countInfinity: 'Бесконечное количество',
  };
  final ScrollController _scrollController = ScrollController();
  bool _showActionButton = false;
  int? _currentCount = 10;

  void _onSelected(SliverFixedExtentListCount count) {
    setState(() {
      switch (count) {
        case SliverFixedExtentListCount.count10:
          _currentCount = 10;
          break;
        case SliverFixedExtentListCount.count50:
          _currentCount = 50;
          break;
        case SliverFixedExtentListCount.countInfinity:
          _currentCount = null;
          break;
      }
    });
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.position.pixels > 100) {
          _showActionButton = true;
        } else {
          _showActionButton = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showActionButton
          ? FloatingActionButton(
              mini: true,
              child: const Icon(Icons.arrow_upward),
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
            )
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: _background,
              title: const AppText(
                value: 'CustomScrollView',
                textType: TextType.large,
                dark: false,
              ),
            ),
            actions: [
              PopupMenuButton<SliverFixedExtentListCount>(
                  tooltip: 'выбор количества элементов',
                  onSelected: _onSelected,
                  itemBuilder: (context) {
                    return _names.entries
                        .map((MapEntry<SliverFixedExtentListCount, String> e) =>
                            PopupMenuItem<SliverFixedExtentListCount>(
                                key:
                                    ValueKey<SliverFixedExtentListCount>(e.key),
                                value: e.key,
                                child: AppText(
                                  value: e.value,
                                )))
                        .toList();
                  })
            ],
          ),
          _description(
              'SliverGrid',
              'Sliver, который размещает несколько дочерних '
                  'элементов бокса в двухмерном расположении. \n\nSliverGrid размещает свои дочерние элементы в произвольных позициях, определяемых gridDelegate. Каждый дочерний элемент принудительно имеет размер, заданный gridDelegate.'),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.purple[300 + (index % 5 + 1) * 100],
                  child: AppText(
                    value: 'я ребенок SliverGrid ${index + 1}',
                    dark: false,
                  ),
                );
              },
              childCount: 20,
            ),
          ),
          _description(
              'SliverFixedExtentList',
              'Sliver, который размещает несколько дочерних элементов бокса с '
                  'одинаковой протяженностью главной оси в линейном массиве. \n\nЕсли не указать childCount, то количество элементов будет бесконечным'),
          SliverFixedExtentList(
            itemExtent: 70.0,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.purple[300 + (index % 5 + 1) * 100],
                    borderRadius: const BorderRadius.all(Radius.circular(70))),
                child: AppText(
                  value: 'я ребенок SliverFixedExtentList ${index + 1}',
                  dark: false,
                ),
              );
            }, childCount: _currentCount),
          ),
          _description('Конец списка',
              'Сюда не долистать при бесконечном количестве элементов')
        ],
      ),
    );
  }

  _description(String title, String description) => SliverToBoxAdapter(
        child: Container(
          color: purple900,
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppText(
                value: title,
                dark: false,
                textType: TextType.large,
              ),
              AppText(
                value: description,
                dark: false,
                textType: TextType.medium,
              ),
            ],
          ),
        ),
      );
  get _background => Opacity(
    opacity: 0.5,
    child: FittedBox(
        fit: BoxFit.cover,
        child: ConstrainedBox(
          constraints:
          const BoxConstraints(minHeight: 250, minWidth: 100),
          child: Image.network(
              'https://www.meme-arsenal.com/memes/acb008ff147c7838ff4e798811f31b3d.jpg'),
        )),
  );
}
