
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ImageType {
  localFile,
  cachedFile,
  networkFile
}

class RoundImage extends StatelessWidget {
  const RoundImage({
    Key? key,
    this.width,
    this.height,
    required this.imageString,
    this.type,
  }) : super(key: key);
  final double? width;
  final double? height;
  final String imageString;
  final ImageType? type;

  @override
  Widget build(BuildContext context) {
    return type == ImageType.cachedFile ?
    Container(
      width: width,
      height: height,
      child: Image.file(File(imageString)),
      decoration: const BoxDecoration(
        shape: BoxShape.circle, //File(imagePath)
      ),
    )
        : type == ImageType.localFile ?
    Container(
      width: height ?? width ?? 92,
      height: height ?? width ?? 92,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage(imageString),
            fit: BoxFit.cover
        ),
      ),
    ) :
    CircleAvatar(
      radius: width ?? height ?? 48,
      backgroundImage: NetworkImage(imageString),
    );
  }
}