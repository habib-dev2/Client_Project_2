import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesst/pages/home_page.dart';
import 'package:tesst/screens/Auth/loginpage.dart';
import 'package:tesst/screens/audio_post.dart';
import 'package:tesst/screens/categorypage.dart';
import 'package:tesst/screens/profilepage.dart';
import 'package:tesst/screens/story_post.dart';
import 'package:tesst/screens/video_post.dart';
import 'package:tesst/theme/colors.dart';
import 'package:tesst/widgets/tik_tok_icons.dart';
import 'package:tesst/widgets/upload_icon.dart';
import 'package:video_player/video_player.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  VideoPlayerController? _videoController;
  SharedPreferences? _prefs;

  int? _userId;

  _isLoggedIn() async {
    _prefs = await SharedPreferences.getInstance();
    int? userId = _prefs?.getInt('userId');
    setState(() {
      _userId = userId;
    });
  }

  @override
  void initState() {
    _isLoggedIn();
    super.initState();
  }

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    return Container(
      child: IndexedStack(
        index: pageIndex,
        children: <Widget>[
          HomePage(),
          CategoryList(),
          const Center(
            child: Text(
              "Upload",
              style: TextStyle(
                  color: black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "There is no notification available.",
                style: TextStyle(
                    color: black, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          HomePage()
        ],
      ),
    );
  }

  Widget getFooter() {
    List bottomItems = [
      {"icon": TikTokIcons.home, "label": "Home", "isIcon": true},
      {"icon": TikTokIcons.search, "label": "Discover", "isIcon": true},
      {"icon": "", "label": "", "isIcon": false},
      {"icon": Icons.notifications, "label": "Notification", "isIcon": true},
      {"icon": TikTokIcons.profile, "label": "Me", "isIcon": true}
    ];
    return Container(
      height: 70,
      width: double.infinity,
      decoration: const BoxDecoration(color: appBgColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return bottomItems[index]['isIcon']
                ? InkWell(
                    onTap: () {
                      print(_videoController);
                      selectedTab(index);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          bottomItems[index]['icon'],
                          color: white,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            bottomItems[index]['label'],
                            style: const TextStyle(color: white, fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  )
                : InkWell(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: UploadIcon());
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
      if (index == 4) {
        setState(() {
          _postComment(context);
        });
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.video_collection_rounded),
                    title: const Text('Video'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => VideoPost()));
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Audio'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AudioPost()));
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Story'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StoryPost()));
                  },
                ),
              ],
            ),
          );
        });
  }
}

void _postComment(context) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  int? _userId = _prefs.getInt('userId');
  String? _userName = _prefs.getString('userName');
  String? _userEmail = _prefs.getString('userEmail');
  //String? _userPic = _prefs.getString('userPic');

  if (_userId != null && _userId > 0) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(
          userId: _userId,
          userName: _userName,
          userEmail: _userEmail,
        ),
      ),
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
