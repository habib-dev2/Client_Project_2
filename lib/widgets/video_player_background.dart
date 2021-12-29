import 'package:flutter/material.dart';
import 'package:tesst/theme/colors.dart';

class VideoPlayerBackground extends StatelessWidget {
  final String? img;
  const VideoPlayerBackground({
    @required this.size, this.img,
  });

  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size!.height,
      width: size!.width,
      decoration: BoxDecoration(
          color: black,
      )
          // image: DecorationImage(
          //     image: NetworkImage(
          //         img),
          //     fit: BoxFit.cover)),
    );
  }
}