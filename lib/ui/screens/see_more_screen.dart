import 'package:flutter/material.dart';
import 'package:foxfund_alpha/core/view_models/news_vm.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';
import 'package:foxfund_alpha/ui/styles/spacing.dart';
import 'package:foxfund_alpha/ui/widgets/saved_item.dart';
 import 'package:foxfund_alpha/utils/base_view.dart';
import 'package:foxfund_alpha/utils/constants/routes.dart';
import 'package:foxfund_alpha/utils/navigator.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foxfund_alpha/ui/widgets/error_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../locator.dart';

class SeeMoreScreen extends StatefulWidget {
  const SeeMoreScreen({Key key}) : super(key: key);

  @override
  _SeeMoreScreenState createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<NewsViewModel>(
          onModelReady: (NewsViewModel model) => model.getAll(),
          builder: (_, NewsViewModel model, __) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: model.busy
                    ? ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(.5),
                              highlightColor: Colors.white60,
                              child: const SavedItem(),
                            ),
                          );
                        })
                    : model.trendingArticles == null
                        ? ErrorOccurredWidget(error: model.error2)
                        : model.trendingArticles.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'images/empty.svg',
                                      height: screenAwareSize(50, context),
                                    ),
                                    verticalSpaceMedium,
                                    CustomText(
                                        'Unfortunately, There is no\nnews currently in your present\nlocation',
                                        fontSize: 16,
                                        centerText: true,
                                        fontWeight: FontWeight.w600,
                                        color: Styles.colorBlack),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: model.trendingArticles.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        locator<NavigationService>().navigateTo(
                                            NewsDetailsView,
                                            arguments: model
                                                .trendingArticles[index]
                                                .toJson());
                                      },
                                      child: SavedItem(
                                          article:
                                              model.trendingArticles[index]));
                                }),
              )),
      appBar: AppBar(
          title: const CustomText('All News',
              fontSize: 18, fontWeight: FontWeight.bold),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 1),
    );
  }
}
