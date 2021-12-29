import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesst/services/baseController.dart';
import 'package:tesst/widgets/VideoPlayerItem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, BaseController {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    videoC.getVideo();
    likeC.getLikes();
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Stack(
        children: [
          PageView.builder(
            itemCount: videoC.videos.length,
            scrollDirection: Axis.vertical,
            onPageChanged: (value) async {
              print(value);
            },
            itemBuilder: (context, index) {
              final item = videoC.videos.elementAt(index);

              return VideoPlayerItem(
                videoUrl: '${item.videourl}',
                size: size,
                name: '${item.title}',
                caption: 'Video caption',
                songName: 'Song name!',
                profileImg:
                    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=388&q=80',
                comments: '1k',
                shares: '5',
                albumImg:
                    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=388&q=80',
                isLiked: true,
                id: item.id!,
              );
            },
          )
        ],
      ),
    );
  }
}
