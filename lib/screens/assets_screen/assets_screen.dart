import 'package:flutter/material.dart';
import 'package:widgets_example/utils/colors.dart';
import 'package:widgets_example/utils/title_widget.dart';
import 'package:widgets_example/widgets/listview.dart';
import 'package:widgets_example/widgets/section.dart';

import 'dart:convert' show json;

import 'package:widgets_example/widgets/text.dart';

class AssetsScreen extends TitleWidget {
  const AssetsScreen({Key? key}) : super(key: key);

  @override
  String get title => 'Assets & Images & Icons';

  @override
  State<AssetsScreen> createState() => _AssetsState();
}

class _AssetsState extends State<AssetsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppListView(
      children: [
        _assetBundle,
        _assetBundleExample,
        _icon,
        _iconExample,
        _image,
        _imageExample
      ],
    );
  }

  get _assetBundle => const AppHeadlineSection(
      title: 'AssetBundle / DefaultAssetBundle',
      description:
          'Набор ресурсов, используемых приложением. \n\nПакеты активов содержат ресурсы, такие как изображения и строки, которые могут быть использованы приложением. Доступ к этим ресурсам асинхронный, поэтому они могут быть прозрачно загружены по сети (например, из NetworkAssetBundle) или из локальной файловой системы без блокирования пользовательского интерфейса приложения.\n\nТакже есть rootBundle, но лучше использовать DefaultAssetBundle');

  get _assetBundleExample => AppSection(
        child: Column(
          children: [
            const AppText(
                value: 'Данные загружаются из файла person.json с помощью'),
            const AppText(
              value:
                  'DefaultAssetBundle.of(context)\n.loadString("assets/person.json")',
              textType: TextType.code,
            ),
            const AppText(value: 'в качестве future в FutureBuilder'),
            _futureBuilder,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  AppText(
                    value: 'AssetImage для загрузки картинки',
                    textType: TextType.large,
                  ),
                  AppText(
                    value: 'Image(image: AssetImage("assets/crocodile.jpg"))',
                    textType: TextType.code,
                  ),
                ],
              ),
            ),
            const Image(
              image: AssetImage('assets/crocodile.jpg'),
            )
          ],
        ),
      );

  get _futureBuilder => FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString("assets/person.json"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = json.decode(snapshot.data.toString());
            return ListView.builder(
              shrinkWrap: true,
              physics:
                  const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return _item(data, index);
              },
            );
          }
          return const CircularProgressIndicator();
        },
      );

  _item(data, index) => Container(
        margin: const EdgeInsets.only(top: 5, right: 5, left: 5),
        color: purple900,
        child: ListTile(
          title: AppText(
            value: "Name: ${data[index]["name"]}",
            textAlign: TextAlign.start,
            dark: false,
          ),
          subtitle: AppText(
            value: "Age: ${data[index]["age"]}",
            textAlign: TextAlign.start,
            dark: false,
          ),
          trailing: AppText(
            value: "Height: ${data[index]["height"]}",
            dark: false,
          ),
        ),
      );

  get _icon => const AppHeadlineSection(
        title: 'Icon',
        description:
            'Виджет графической иконки, нарисованный глифом из шрифта, описанного в IconData, например, в предопределенных Material Icons. Иконки не являются интерактивными. Для интерактивной иконки рассмотрите IconButton',
      );

  get _iconExample => AppSection(
          child: Column(
        children: [
          _iconsRow(
              ImageIcon(
                const AssetImage("assets/custom_icon.png"),
                size: 24.0,
                color: purple800,
              ),
              'ImageIcon - иконка из загруженной картинки. Здесь формат png'),
          Divider(color: purple900),
          _iconsRow(
              Icon(
                Icons.favorite,
                color: purple800,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              'Icon - иконка из Material App')
        ],
      ));

  _iconsRow(Widget icon, String text) => Row(
        children: [
          icon,
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: AppText(
            value: text,
            textAlign: TextAlign.start,
          )),
        ],
      );

  get _image => const AppHeadlineSection(
      title: 'Image', description: 'Виджет, отображающий изображение.');

  get _imageExample {
    return AppSection(
      child: Column(
        children: [
          _imageRow(Image.asset('assets/crocodile.jpg'),
              'Image.asset("assets/crocodile.jpg")'),
          _imageRow(
              Image.network(
                  "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
              'Image.network(%URL%)'),
        ],
      ),
    );
  }

  _imageRow(Image image, String code) => Row(
        children: [
          Expanded(
              flex: 2,
              child: Center(
                child: AppText(
                  value: code,
                  textType: TextType.code,
                ),
              )),
          Expanded(child: Center(child: image)),
        ],
      );
}
