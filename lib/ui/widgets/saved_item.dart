import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foxfund_alpha/core/model/all_articles.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';
import 'package:foxfund_alpha/ui/styles/styles.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';

import 'custom_text_widget.dart';

class SavedItem extends StatelessWidget {
  const SavedItem({Key key, this.article, this.type}) : super(key: key);

  final Article article;
  final String type;

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
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: article?.urlToImage ?? '',
              fit: BoxFit.fill,
              height: screenAwareSize(110, context),
              width: screenAwareSize(130, context),
              placeholder: (BuildContext context, String url) => Image(
                  image: const AssetImage('images/placeholder.png'),
                  height: screenAwareSize(110, context),
                  width: screenAwareSize(130, context),
                  fit: BoxFit.fill),
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  Image(
                      image: const AssetImage('images/placeholder.png'),
                      width: screenAwareSize(110, context),
                      height: screenAwareSize(130, context),
                      fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (type != null)
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: CustomText(
                            type,
                            fontSize: 14,
                            color: Styles.colorGrey.withOpacity(.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                            onTap: deleteItem,
                            child: Icon(Icons.delete,
                                color: Styles.redColor, size: 22)),
                      ],
                    ),
                  CustomText(
                    article?.title ?? '',
                    fontSize: 14,
                    maxLines: 2,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      article?.publishedAt?.substring(0, 10) ?? '',
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

  void deleteItem() {}
}
