import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesst/controllers/commentController.dart';
import 'package:tesst/controllers/likeController.dart';
import 'package:tesst/screens/Auth/loginpage.dart';
import 'package:tesst/services/baseController.dart';
import 'package:tesst/widgets/column_social_icon.dart';
import 'package:tesst/widgets/tik_tok_icons.dart';
import 'package:tesst/theme/colors.dart';

class RightPanel extends StatelessWidget with BaseController {
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
  @override
  Widget build(BuildContext context) {
    commentC.getComments();
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
                      likeC.checkLikeExist(context: context, id: id);
                      print(likeC.likeExist(id: id));
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Icon(TikTokIcons.heart,
                              color: likeC.likeExist(id: id)
                                  ? Colors.redAccent
                                  : Colors.white,
                              size: 35.0),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            likeC.videoLikesCount(id: id).toString(),
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
                                                          commentC.comment,
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
                                                        if (commentC.comment
                                                            .value.isNotEmpty) {
                                                          commentC.addComment(
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
                                            commentC.videoCommentCount(id: id) >
                                                    0
                                                ? Container(
                                                    height: 308,
                                                    child: ListView.builder(
                                                      itemCount: commentC
                                                          .comments.length,
                                                      shrinkWrap: true,
                                                      primary: false,
                                                      // reverse: true,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              index) {
                                                        final comment = commentC
                                                            .comments
                                                            .elementAt(index);
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
                            commentC.videoCommentCount(id: id).toString(),
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
