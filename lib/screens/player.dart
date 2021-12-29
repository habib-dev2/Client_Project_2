import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tesst/widgets/tik_tok_icons.dart';
import 'package:video_player/video_player.dart';

class AllVideoPlayer extends StatefulWidget {
  const AllVideoPlayer({Key? key}) : super(key: key);

  @override
  _AllVideoPlayerState createState() => _AllVideoPlayerState();
}

class _AllVideoPlayerState extends State<AllVideoPlayer> {
  // ignore: unused_field
  late TargetPlatform _platform;
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 =
        VideoPlayerController.network('https://cdn.videvo.net/videvo_files/video/premium/video0208/large_watermarked/Cute%20girl%207-8%20years%20blowing%20soap%20bubbles%20and%20sitting%20in%20the%20grass%20on%20the%20glade%20of%20dandelions_preview.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      showControls: true,
      allowFullScreen: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cute girl's smile"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: 260,
            width: MediaQuery.of(context).size.width,
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Happiness is the beautiful',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'this video is taken from the 3rd party website',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: const Icon(TikTokIcons.heart), onPressed: () {}),
              IconButton(icon: const Icon(TikTokIcons.messages), onPressed: () {}),
              IconButton(icon: const Icon(Icons.share), onPressed: () {}),

            ],
          ),
          const SizedBox(
            height: 15,
          ),
          // const Text(
          //   "Comments",
          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // ListTile(
          //   title: Text('comment 1'),
          // ),
          // ListTile(
          //   title: Text('comment 1'),
          // ),
          // ListTile(
          //   title: Text('comment 1'),
          // ),
        ],
      ),
    );
  }
}
