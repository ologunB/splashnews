import 'package:flutter/material.dart';
import 'package:foxfund_alpha/core/view_models/news_vm.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';
import 'package:foxfund_alpha/ui/styles/spacing.dart';
import 'package:foxfund_alpha/ui/widgets/custom_textfield.dart';
import 'package:foxfund_alpha/ui/widgets/saved_item.dart';
import 'package:foxfund_alpha/utils/base_view.dart';
import 'package:foxfund_alpha/utils/constants/routes.dart';
import 'package:foxfund_alpha/utils/navigator.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foxfund_alpha/ui/widgets/error_widget.dart';

import '../../locator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<NewsViewModel>(
        builder: (_, NewsViewModel model, __) => Scaffold(
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: model.busy
                    ? Container(
                        height: screenHeight(context),
                        alignment: Alignment.center,
                        child: const CupertinoActivityIndicator())
                    : model.searchedArticles == null
                        ? ErrorOccurredWidget(error: model.error3)
                        : model.searchedArticles.isEmpty
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
                                itemCount: model.searchedArticles.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        locator<NavigationService>().navigateTo(
                                            NewsDetailsView,
                                            arguments: model
                                                .searchedArticles[index]
                                                .toJson());
                                      },
                                      child: SavedItem(
                                          article:
                                              model.searchedArticles[index]));
                                }),
              ),
              appBar: AppBar(
                  titleSpacing: 0,
                  title: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CustomTextField(
                      hintText: 'Search...',
                      maxLines: 1,
                      autoFocus: true,
                      onChanged: (String a) {
                        model.search(a);
                      },
                    ),
                  ),
                  iconTheme: const IconThemeData(color: Colors.black),
                  centerTitle: true,
                  elevation: 1),
            ));
  }
}
