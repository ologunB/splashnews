import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foxfund_alpha/core/view_models/news_vm.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';
import 'package:foxfund_alpha/utils/base_view.dart';
import 'package:foxfund_alpha/utils/navigator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foxfund_alpha/ui/styles/spacing.dart';
import 'package:foxfund_alpha/ui/widgets/error_widget.dart';
import 'package:foxfund_alpha/ui/widgets/type_item.dart';
import 'package:foxfund_alpha/utils/constants/routes.dart';
import 'package:shimmer/shimmer.dart';

import '../../locator.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({Key key}) : super(key: key);

  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  int newsTypeSelected = 0;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BaseView<NewsViewModel>(
        onModelReady: (NewsViewModel model) {
          model.getByCategory(types[newsTypeSelected]);
          scrollController.addListener(() {
            if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
              print('Getting more Data...');
              model.getByCategory(types[newsTypeSelected]);
            }
          });
        },
        builder: (_, NewsViewModel model, __) => ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                  height: screenAwareSize(60, context),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                      itemCount: types.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            scrollController.animateTo(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                            newsTypeSelected = index;
                            setState(() {});
                            model.getByCategory(types[newsTypeSelected]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CustomText(
                                  types[index],
                                  fontSize: newsTypeSelected == index ? 18 : 14,
                                  centerText: true,
                                  color: newsTypeSelected == index
                                      ? Styles.colorPurple
                                      : Styles.colorGrey,
                                  fontWeight: newsTypeSelected == index
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ),
                                if (newsTypeSelected == index)
                                  Container(
                                      height: screenAwareSize(3, context),
                                      width: screenAwareSize(25, context,
                                          width: true),
                                      decoration: BoxDecoration(
                                          color: Styles.colorPurple,
                                          borderRadius:
                                              BorderRadius.circular(20)))
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  height: screenAwareSize(270, context),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: model.busy
                      ? ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(.5),
                                highlightColor: Colors.white60,
                                child: CategoryItem(),
                              ),
                            );
                          })
                      : model.categoriesArticles == null
                          ? ErrorOccurredWidget(error: model.error1)
                          : model.categoriesArticles.isEmpty
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
                              : ListView(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  children: <Widget>[
                                    ListView.builder(
                                        itemCount:
                                            model.categoriesArticles.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                              onTap: () {
                                                locator<NavigationService>()
                                                    .navigateTo(NewsDetailsView,
                                                        arguments: model
                                                            .categoriesArticles[
                                                                index]
                                                            .toJson());
                                              },
                                              child: CategoryItem(type: types[newsTypeSelected],
                                                  article:
                                                      model.categoriesArticles[
                                                          index]));
                                        }),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(30.0),
                                      child: const CupertinoActivityIndicator(),
                                    )
                                  ],
                                ),
                ),
              ],
            ));
  }
}

List<String> types = <String>[
  'General',
  'Business',
  'Entertainment',
  'Health',
  'Science',
  'Sports',
  'Politics',
  'Technology'
];
