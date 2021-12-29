import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesst/controllers/commentController.dart';
import 'package:tesst/controllers/likeController.dart';
import 'package:tesst/controllers/videoController.dart';
import 'package:tesst/screens/Auth/loginpage.dart';
import 'package:tesst/theme/colors.dart';
import 'package:tesst/widgets/column_social_icon.dart';
import 'package:tesst/widgets/header_home_page.dart';
import 'package:tesst/widgets/left_panel.dart';
import 'package:tesst/widgets/tik_tok_icons.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _videoC = Get.put(VideoController());
  final _likeC = Get.put(LikeController());

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _videoC.getVideo();
    _likeC.getLikes();
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Stack(
        children: [
          PageView.builder(
            itemCount: _videoC.videos.length,
            scrollDirection: Axis.vertical,
            onPageChanged: (value) async {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              int? _userId = _prefs.getInt('userId');
            },
            itemBuilder: (context, index) {
              final item = _videoC.videos.elementAt(index);

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

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String name;
  final String caption;
  final String songName;
  final String profileImg;
  final String comments;
  final String shares;
  final String albumImg;
  final bool isLiked;
  final int id;
  VideoPlayerItem({
    required this.id,
    required this.size,
    required this.name,
    required this.isLiked,
    required this.caption,
    required this.songName,
    required this.profileImg,
    required this.comments,
    required this.shares,
    required this.albumImg,
    required this.videoUrl,
  });

  final Size size;

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController? _videoController;
  bool isShowPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        _videoController!.play();
        setState(() {
          isShowPlaying = false;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController!.dispose();
  }

  Widget isPlaying() {
    return _videoController!.value.isPlaying && !isShowPlaying
        ? Container()
        : Icon(
            Icons.play_arrow,
            size: 80,
            color: white.withOpacity(0.5),
          );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _videoController!.value.isPlaying
              ? _videoController!.pause()
              : _videoController!.play();
        });
      },
      child: RotatedBox(
        quarterTurns: 0,
        child: Container(
            height: widget.size.height,
            width: widget.size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  height: widget.size.height,
                  width: widget.size.width,
                  decoration: BoxDecoration(color: black),
                  child: Stack(
                    children: <Widget>[
                      VideoPlayer(_videoController!),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: isPlaying(),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: widget.size.height,
                  width: widget.size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 20, bottom: 10),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          HeaderHomePage(),
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              LeftPanel(
                                size: widget.size,
                                name: "${widget.name}",
                                caption: "${widget.caption}",
                                songName: "${widget.songName}",
                              ),
                              RightPanel(
                                id: widget.id,
                                size: widget.size,
                                comments: "${widget.comments}",
                                shares: "${widget.shares}",
                                profileImg: widget.albumImg,
                                albumImg: "${widget.albumImg}",
                                isLiked: widget.isLiked,
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class RightPanel extends StatelessWidget {
  final int id;
  final String comments;
  final bool isLiked;
  final String shares;
  final String profileImg;
  final String albumImg;
  RightPanel({
    Key? key,
    required this.id,
    required this.size,
    required this.isLiked,
    required this.comments,
    required this.shares,
    required this.profileImg,
    required this.albumImg,
  }) : super(key: key);

  final Size size;
  final _likeC = Get.put(LikeController());
  final _commentC = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    _commentC.getComments();
    return Obx(
      () => Expanded(
        child: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * 0.3,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  getProfile(profileImg),
                  GestureDetector(
                    onTap: () {
                      _likeC.checkLikeExist(context: context, id: id);
                      print(_likeC.likeExist(id: id));
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Icon(TikTokIcons.heart,
                              color: _likeC.likeExist(id: id)
                                  ? Colors.redAccent
                                  : Colors.white,
                              size: 35.0),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _likeC.videoLikesCount(id: id).toString(),
                            style: TextStyle(
                                color: white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences _prefs =
                          await SharedPreferences.getInstance();
                      int? _userId = _prefs.getInt('userId');

                      if (_userId != null && _userId > 0) {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.0)),
                          ),
                          backgroundColor: Colors.white,
                          builder: (builder) {
                            return Column(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(10.0),
                                        topRight: const Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              child: MaterialButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                elevation: 0,
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                  size: 20,
                                                ),
                                                color: Colors.grey[400],
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                shape: CircleBorder(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: TextField(
                                                      onChanged:
                                                          _commentC.comment,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          horizontal: 20.0,
                                                          vertical: 15.0,
                                                        ),
                                                        hintText:
                                                            'Type Comment',
                                                        hintStyle: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .focusColor
                                                              .withOpacity(0.7),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    // color: Colors.amber,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        if (_commentC.comment
                                                            .value.isNotEmpty) {
                                                          _commentC.addComment(
                                                            id: id,
                                                            context: context,
                                                          );
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                        Icons.send,
                                                        color:
                                                            Colors.amber[900],
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            _commentC.videoCommentCount(
                                                        id: id) >
                                                    0
                                                ? Container(
                                                    height: 308,
                                                    child: ListView.builder(
                                                      itemCount: _commentC
                                                          .comments.length,
                                                      shrinkWrap: true,
                                                      primary: false,
                                                      // reverse: true,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              index) {
                                                        final comment =
                                                            _commentC.comments
                                                                .elementAt(
                                                                    index);
                                                        if (comment.videoId ==
                                                            id) {
                                                          return SingleChildScrollView(
                                                            child: ListTile(
                                                              // leading:
                                                              //     CircleAvatar(
                                                              //   backgroundColor:
                                                              //       Colors.grey[
                                                              //           350],
                                                              //   foregroundImage:
                                                              //       AssetImage(
                                                              //           'assets/images/showicon.png'),
                                                              // foregroundImage: comment
                                                              //             .userImage ==
                                                              //         null
                                                              //     ? Image.asset(name)
                                                              //   //     : NetworkImage(
                                                              //   //         '${comment.userImage}'),
                                                              // ),

                                                              leading:
                                                                  ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                child: comment
                                                                            .userImage ==
                                                                        null
                                                                    ? Image.asset(
                                                                        'assets/images/showicon.png')
                                                                    : Image
                                                                        .network(
                                                                        '${comment.userImage}',
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      ),
                                                              ),
                                                              title: Text(
                                                                  '${comment.user}'),
                                                              subtitle: Text(
                                                                  '${comment.comment}'),
                                                            ),
                                                          );
                                                        }
                                                        return SizedBox();
                                                      },
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: 150,
                                                    child: Center(
                                                      child: Text('No comment'),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Icon(TikTokIcons.chat_bubble,
                              color: Colors.white, size: 35.0),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _commentC.videoCommentCount(id: id).toString(),
                            style: TextStyle(
                                color: white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                  // getIcons(TikTokIcons.chat_bubble, comments, 35.0),
                  getIcons(TikTokIcons.reply, shares, 25.0),
                  getAlbum(albumImg)
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          height: 350.0,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: new Center(
              child: new Text("This is a modal sheet"),
            ),
          ),
        );
      },
    );
  }
}
