import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesst/pages/home_page.dart';
import 'package:tesst/screens/Auth/loginpage.dart';
import 'package:tesst/screens/audio_post.dart';
import 'package:tesst/screens/categorypage.dart';
import 'package:tesst/screens/profile_edit.dart';
import 'package:tesst/screens/story_post.dart';
import 'package:tesst/screens/video_post.dart';
import 'package:tesst/theme/colors.dart';
import 'package:tesst/widgets/tik_tok_icons.dart';
import 'package:tesst/widgets/upload_icon.dart';

class ProfilePage extends StatefulWidget {
  final int? userId;
  final String? userName;
  final String? userEmail;
  ProfilePage({this.userId, this.userName, this.userEmail});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int pageIndex = 0;
  Widget getBody() {
    return IndexedStack(
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
          child: Text(
            "All Activity",
            style: TextStyle(
                color: black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        HomePage()
      ],
    );
  }

  Widget getFooter() {
    List bottomItems = [
      {"icon": TikTokIcons.home, "label": "Home", "isIcon": true},
      {"icon": TikTokIcons.search, "label": "Discover", "isIcon": true},
      {"icon": "", "label": "", "isIcon": false},
      {"icon": TikTokIcons.messages, "label": "Inbox", "isIcon": true},
      {"icon": TikTokIcons.profile, "label": "Me", "isIcon": true}
    ];
    return Container(
      height: 80,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
              onPressed: _navigateToLogout, icon: Icon(Icons.exit_to_app))
        ],
      ),
      //bottomNavigationBar: getFooter(),
      body: Container(
        color: Colors.black,
        child: ListView(
          physics: ScrollPhysics(),
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                         child: Image.asset('assets/images/showicon.png', width: 90,height: 90,)),
                    SizedBox(width: 20,),
                    Column(
                      children: [
                        Text(
                          widget.userName!,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.userEmail!,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileEditPage()));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Posts",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("21",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Likes",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("100K",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Posts",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("21",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.grid_3x3,
                        color: Colors.white,
                        size: 30,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.list,
                        color: Colors.white,
                        size: 30,
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height *
                  (MediaQuery.of(context).size.height / 4400 * 3),
              child: GridView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    width: 80,
                    height: 80,
                  );
                },
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
              ),
            ),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }

  _navigateToLogout() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
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
