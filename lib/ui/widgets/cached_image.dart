import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({Key key, this.imageUrl, this.dSize, this.isRound = false})
      : super(key: key);

  final String imageUrl;
  final double dSize;
  final bool isRound;

  @override
  Widget build(BuildContext context) {
    final double size = screenAwareSize(dSize, context);
    const String person =
        'https://firebasestorage.googleapis.com/v0/b/proj-along.appspot.com/o/person.png?alt=media&token=54d54309-fa02-4000-b156-188ee2a38c7f';

    return ClipRRect(
      borderRadius: BorderRadius.circular(isRound ? size / 2 : 1),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? person,
        fit: BoxFit.fill,
        height: size,
        width: size,
        placeholder: (BuildContext context, String url) => Image(
            image: const AssetImage('images/placeholder.png'),
            height: size,
            width: size,
            fit: BoxFit.fill),
        errorWidget: (BuildContext context, String url, dynamic error) => Image(
            image: const AssetImage('images/placeholder.png'),
            height: size,
            width: size,
            fit: BoxFit.fill),
      ),
    );
  }
}
