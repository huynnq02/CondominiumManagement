import 'package:flutter/cupertino.dart';

enum esize {
  big,
  medium,
  belowmedium,
  small,
}

class CustomImage extends StatelessWidget {
  String imageUrl;
  esize size;
  CustomImage({Key? key, required this.imageUrl, required this.size})
      : super(key: key);

  double getSize(esize size) {
    double big = 250;
    double belowmedium = 60;
    double medium = 150;
    double small = 24;
    switch (size) {
      case esize.big:
        return big;

      case esize.belowmedium:
        return belowmedium;

      case esize.medium:
        return medium;

      case esize.small:
        return small;
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageUrl == ""
        ? Image.asset(
            'assets/logo.png',
            fit: BoxFit.fitWidth,
            width: getSize(size),
            height: getSize(size),
          )
        : Image.network(
            imageUrl,
            fit: BoxFit.fitWidth,
            width: getSize(size),
            height: getSize(size),
          );
  }
}
