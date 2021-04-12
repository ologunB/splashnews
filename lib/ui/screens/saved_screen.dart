import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foxfund_alpha/core/model/all_articles.dart';
import 'package:foxfund_alpha/core/storage/local_storage.dart';
import 'package:foxfund_alpha/ui/styles/spacing.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';
import 'package:foxfund_alpha/ui/widgets/saved_item.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';
import 'package:foxfund_alpha/utils/constants/routes.dart';
import 'package:foxfund_alpha/utils/navigator.dart';

import '../../locator.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key key}) : super(key: key);

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Article> allArticles = <Article>[];
    final List<String> allTypes = <String>[];
    AppCache.getSavedData().forEach((dynamic v) {
      allArticles.add(Article.fromJson(v['article']));
      allTypes.add(v['type'] as String);
    });
    return Scaffold(
      appBar: AppBar(
          title: const CustomText('Saved News',
              fontSize: 18, fontWeight: FontWeight.bold),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 2),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: allArticles.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'images/empty.svg',
                      height: screenAwareSize(80, context),
                    ),
                    verticalSpaceMedium,
                    CustomText('No saved Item yet',
                        fontSize: 17,
                        centerText: true,
                        fontWeight: FontWeight.w600,
                        color: Styles.colorBlack),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: allArticles.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => locator<NavigationService>().navigateTo(
                          NewsDetailsView,
                          arguments: allArticles[index].toJson()),
                      child: SavedItem(
                        article: allArticles[index],
                        type: allTypes[index],
                      ));
                }),
      ),
    );
  }
}
