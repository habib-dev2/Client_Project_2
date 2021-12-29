import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesst/controllers/likeController.dart';
import 'package:tesst/model/user.dart';
import 'package:tesst/pages/root_app.dart';
import 'package:tesst/screens/profilepage.dart';
import 'package:tesst/services/user_services.dart';

import 'loginpage.dart';

class SignUp extends StatefulWidget {
  final int? id;
  SignUp({this.id});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _likeC = Get.put(LikeController(), permanent: true);

  bool isLoading = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final name = TextEditingController();

  final email = TextEditingController();

  final password = TextEditingController();

  _register(BuildContext context, User user) async {
    var _userService = UserService();
    var registeredUser = await _userService.createUser(user);
    var result = json.decode(registeredUser.body);
    print(result);
    if (result['result'] == true) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setInt('userId', result['user']['id']);
      _prefs.setString('userName', result['user']['name']);
      _prefs.setString('userEmail', result['user']['email']);
      _likeC.uId.value = _prefs.getInt('userId')!;
      if (this.widget.id != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RootApp()));
      }
    } else {
      _showSnackMessage(Text(
        'Failed to register the user!',
        style: TextStyle(color: Colors.red),
      ));
    }
  }

  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: MediaQuery.of(context).size.height * .33,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                child: Card(
                  color: Colors.blue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.person),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: name,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                child: Card(
                  color: Colors.blue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.email),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: email,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                child: Card(
                  color: Colors.blue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.star),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: password,
                          obscureText: true,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              !isLoading
                  ? ElevatedButton(
                      onPressed: () {
                        var user = User();
                        user.name = name.text;
                        user.email = email.text;
                        user.password = password.text;
                        _register(context, user);
                        setState(() {
                          isLoading = true;
                        });
                      },
                      child: Text(
                        "SIGNUP",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  : CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(" Login")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
