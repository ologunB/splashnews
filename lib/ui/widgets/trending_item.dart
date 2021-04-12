import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foxfund_alpha/core/model/all_articles.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';

import 'custom_text_widget.dart';

class TrendingItem extends StatefulWidget {
  const TrendingItem({Key key, this.article}) : super(key: key);

  final Article article;

  @override
  _TrendingItemState createState() => _TrendingItemState();
}

class _TrendingItemState extends State<TrendingItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .75),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Styles.colorWhite,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.deepPurpleAccent.withOpacity(.2), blurRadius: 10)
          ]),
      margin: const EdgeInsets.all(8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: widget.article?.urlToImage?? '',
              fit: BoxFit.fill,
              width: screenAwareSize(130, context),
              placeholder: (BuildContext context, String url) => Image(
                  image: const AssetImage('images/placeholder.png'),
                  width: screenAwareSize(130, context),
                  fit: BoxFit.fill),
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  Image(
                      image: const AssetImage('images/placeholder.png'),
                      width: screenAwareSize(130, context),
                      fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    widget.article?.title?? '',
                    fontSize: 14,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      widget.article?.publishedAt?.substring(0, 10) ?? '',
                      fontSize: 11,
                      color: Styles.colorGrey.withOpacity(.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
