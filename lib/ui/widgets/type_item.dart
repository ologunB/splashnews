import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foxfund_alpha/core/model/all_articles.dart';
import 'package:foxfund_alpha/core/storage/local_storage.dart';
import 'package:foxfund_alpha/ui/styles/spacing.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';

import 'cached_image.dart';
import 'custom_text_widget.dart';

class CategoryItem extends StatefulWidget {
  CategoryItem({Key key, this.article, this.isSaved = false, this.type})
      : super(key: key);

  final String type;
  final Article article;
  bool isSaved;

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Styles.colorWhite,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.deepPurpleAccent.withOpacity(.2), blurRadius: 10)
          ]),
      margin: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.article?.urlToImage ?? '',
            fit: BoxFit.fitWidth,
            height: screenAwareSize(100, context),
            placeholder: (BuildContext context, String url) => Image(
                image: const AssetImage('images/placeholder.png'),
                height: screenAwareSize(100, context),
                fit: BoxFit.fitWidth),
            errorWidget: (BuildContext context, String url, dynamic error) =>
                Image(
                    image: const AssetImage('images/placeholder.png'),
                    height: screenAwareSize(100, context),
                    fit: BoxFit.fitWidth),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: CustomText(
              widget.article?.title ?? '',
              maxLines: 2,
              fontSize: screenAwareSize(14, context, width: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedImage(
                      dSize: 30,
                      imageUrl: widget.article?.urlToImage ?? '',
                      isRound: true),
                ),
                horizontalSpaceTiny,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        widget.article?.author?.replaceAll('\n', ' ') ??
                            'Unknown',
                        fontSize: 14,
                        maxLines: 1,
                        color: Styles.colorBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                          widget.article?.publishedAt?.substring(0, 10) ?? '',
                          fontSize: 11,
                          color: Styles.colorGrey),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      widget.isSaved = !widget.isSaved;
                      setState(() {});
                      AppCache.saveJsonData(article: <String, dynamic>{
                        'type': widget.type,
                        'article': widget.article.toJson()
                      });
                      if (widget.isSaved) {
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
                    child: Icon(widget.isSaved
                        ? Icons.bookmark
                        : Icons.bookmark_border))
              ],
            ),
          )
        ],
      ),
    );
  }
}
