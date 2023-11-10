import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ImageFullScreen extends StatelessWidget {
  const ImageFullScreen(this.url, {super.key});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.network(
        url,
      ),
    );
  }
}
