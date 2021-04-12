import 'package:flutter/material.dart';
 import 'package:foxfund_alpha/ui/screens/trending_section.dart';
import 'package:foxfund_alpha/ui/widgets/custom_textfield.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';
import 'package:foxfund_alpha/ui/styles/spacing.dart';
import 'package:foxfund_alpha/utils/constants/routes.dart';
import 'package:foxfund_alpha/utils/navigator.dart';
import 'package:foxfund_alpha/utils/util.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';

import '../../locator.dart';
import 'category_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Util.offKeyboard(context),
      child: Scaffold(
          backgroundColor: Styles.colorWhite,
          body: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SafeArea(bottom: false, child: verticalSpaceMedium),
              GestureDetector(
                onTap: () =>
                    locator<NavigationService>().navigateTo(SearchView),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: CustomTextField(
                    hintText: 'Search...',
                    maxLines: 1,
                    enabled: false,
                  ),
                ),
              ),
              const CategorySection(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomText('Trending',
                        fontSize: 18,
                        centerText: true,
                        color: Styles.colorPurple,
                        fontWeight: FontWeight.w700),
                    GestureDetector(
                      onTap: () =>
                          locator<NavigationService>().navigateTo(SeeMoreView),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Styles.colorPurple,
                            borderRadius: BorderRadius.circular(20)),
                        child: CustomText('More...',
                            fontSize: 14,
                            centerText: true,
                            color: Styles.colorWhite,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              const TrendingSection(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomText('Recently Viewed',
                        fontSize: 18,
                        centerText: true,
                        color: Styles.colorPurple,
                        fontWeight: FontWeight.w700),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
