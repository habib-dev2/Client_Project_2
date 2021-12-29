import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesst/controllers/likeController.dart';
import 'package:tesst/model/user.dart';
import 'package:tesst/pages/root_app.dart';
import 'package:tesst/screens/Auth/registerpage.dart';
import 'package:tesst/screens/profilepage.dart';
import 'package:tesst/services/user_services.dart';

class LoginPage extends StatefulWidget {
  final int? id;
  final int? userid;
  LoginPage({this.id, this.userid});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _likeC = Get.put(LikeController(), permanent: true);
  bool isLoading = false;
  final email = TextEditingController();
  final password = TextEditingController();

  _setSharedPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('userId', 0);
    _prefs.setString('userName', '');
    _prefs.setString('userEmail', '');
  }

  _login(BuildContext context, User user) async {
    var _userService = UserService();
    var registeredUser = await _userService.login(user);
    var result = json.decode(registeredUser.body);
    print(result);
    if (result['result'] == true) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setInt('userId', result['user']['id']);
      _prefs.setString('userName', result['user']['name']);
      _prefs.setString('userEmail', result['user']['email']);
      _likeC.uId.value = _prefs.getInt('userId')!;
      if (this.widget.id != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RootApp()));
      }
    } else if (result['result'] == false) {
      return {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage())),
        _showDialog()
      };
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.pink,
          child: AlertDialog(
            title: new Text("Login Failed"),
            content: new Text('Credential do not match with our database'),
            actions: <Widget>[
              Row(
                children: [
                  TextButton(
                    child: new Text("Retry"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                  TextButton(
                    child: new Text("Register"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _setSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: MediaQuery.of(context).size.height * .33,
                      ),
                      Text('sign in to unlock many features')
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.blue.withOpacity(0.4),
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
                            hintText: 'Enter your email',
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
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.blue.withOpacity(0.4),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.remove_red_eye),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: password,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Enter your password',
                              border: InputBorder.none,
                              fillColor: Colors.white
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15.0),
                              // ),
                              ),
                          obscureText: true,
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
                        user.email = email.text;
                        user.password = password.text;
                        _login(context, user);
                        setState(() {
                          isLoading = true;
                        });
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  : CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text("SignUp"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
