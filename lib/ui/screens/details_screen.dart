import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foxfund_alpha/core/model/all_articles.dart';
import 'package:foxfund_alpha/core/storage/local_storage.dart';
import 'package:foxfund_alpha/core/view_models/news_vm.dart';
import 'package:foxfund_alpha/ui/styles/spacing.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';
import 'package:foxfund_alpha/ui/widgets/cached_image.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';
import 'package:foxfund_alpha/utils/base_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Article article = Article.fromJson(arguments);

    return Scaffold(
      appBar: AppBar(
          title: const CustomText('Reader',
              fontSize: 18, fontWeight: FontWeight.bold),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 1),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Styles.colorWhite,
        onPressed: () {
          isSaved = !isSaved;
          setState(() {});
          if (isSaved) {
            AppCache.saveJsonData(article: <String, dynamic>{
              'type': 'Unknown',
              'article': article.toJson()
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
                backgroundColor: Styles.colorWhite,
                content: CustomText(
                  'News has been Saved',
                  centerText: true,
                  color: Styles.colorBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                )));
          }
        },
        child: Icon(
          isSaved ? Icons.bookmark : Icons.bookmark_border,
          color: Styles.colorPurple,
        ),
      ),
      body: ListView(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            child: CachedNetworkImage(
              imageUrl: article?.urlToImage ?? '',
              fit: BoxFit.fitWidth,
              placeholder: (BuildContext context, String url) => Image(
                  image: const AssetImage('images/placeholder.png'),
                  height: screenHeightFraction(context, dividedBy: 4),
                  fit: BoxFit.fill),
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  Image(
                      image: const AssetImage('images/placeholder.png'),
                      height: screenHeightFraction(context, dividedBy: 4),
                      fit: BoxFit.fill),
            ),
          ),
          CustomText(
            'TRENDING',
            fontSize: 12,
            topMargin: 10,
            leftMargin: 10,
            fontWeight: FontWeight.w700,
            color: Styles.colorPurple,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
            child: CustomText(
              article?.title ?? '',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                CachedImage(
                  dSize: 40,
                  imageUrl: article?.urlToImage ?? '',
                  isRound: true,
                ),
                horizontalSpaceSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        article?.author?.replaceAll('\n', ' ') ?? '',
                        fontSize: 14,
                        color: Styles.colorBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        article?.publishedAt?.substring(0, 10) ?? '',
                        fontSize: 11,
                        color: Styles.colorGrey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                height: screenAwareSize(4, context),
                width: screenAwareSize(50, context),
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 15),
                decoration: BoxDecoration(
                    color: Styles.colorPurple.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                  text: article?.content?.contains(']') ?? false
                      ? article?.content?.split('[')[0] ?? ''
                      : article?.content ?? '',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Styles.colorBlack,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (await canLaunch(article.url)) {
                            await launch(article.url);
                          } else {
                            throw 'Could not launch ${article.url}';
                          }
                        },
                      text: 'see more',
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Styles.colorPurple),
                    ),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomText('Recently Viewed',
                    fontSize: 16,
                    centerText: true,
                    color: Styles.colorPurple,
                    fontWeight: FontWeight.w700),
              ],
            ),
          ),
          BaseView<NewsViewModel>(
              onModelReady: (NewsViewModel model) {},
              builder: (_, NewsViewModel model, __) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                        itemCount: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                /*   locator<NavigationService>()
                                .navigateTo(NewsDetailsView);*/
                              },
                              child: //const SavedItem()
                                  const Text(''));
                        }),
                  )),
        ],
      ),
    );
  }
}
