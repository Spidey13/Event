import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colorcheme.dart';
import 'calander.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  static String id = 'welcome';
  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {

  final _auth = FirebaseAuth.instance;
  String _email;
  String _password ;

  // Future checkLogin()async{
  //   if (emailCon.text == _email && passCon.text == _password) {
  //
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     preferences.setString('email', emailCon.text);
  //
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>calendarPage(),),);
  //     Fluttertoast.showToast(
  //         msg: "Login Successful",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //   }else{
  //     Fluttertoast.showToast(
  //         msg: "Username & Password Invalid!",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //   }
  // }

  final GlobalKey<FormState> _loginkey = GlobalKey<FormState>();
  bool passwordVisible = false;

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextField(
        onChanged: (value) {
          _email = value;
        },
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintText: 'Email address',
          prefixIcon: Icon(
            Icons.email,
            color: mainColor,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextField(
        keyboardType: TextInputType.text,
        obscureText: !passwordVisible,
        onChanged: (value) {
          _password = value;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          hintText: 'Password',
          suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              }
            // Update the state i.e. toogle the state of passwordVisible variable

          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 10, top: 10),
          child: RaisedButton(
            elevation: 4.0,
            color: logincolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () async {
              try {
                final user = await _auth.signInWithEmailAndPassword(
                    email: _email, password: _password);
                if (user != null) {
                  Navigator.pushNamed(context, CalendarPage.id);
                }
              } catch (e) {
                print(e);
              }
            },
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildEmailRow(),
                _buildPasswordRow(),
                //_buildForgetPasswordButton(),
                _buildLoginButton(),

              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Attendance Manager'),
            centerTitle: true,
            backgroundColor: Colors.black87,
          ),
          resizeToAvoidBottomPadding: false,
          backgroundColor: Color(0xfff2f3f7),
          body: Stack(
            key: _loginkey,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: mainColor,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildContainer(),
                  //_buildSignUpBtn(),
                ],
              )
            ],
          ),
        ),
      );

  }



  // Future<String> login() async {
  //   final formstate = _loginkey.currentState;
  //   try {
  //     UserCredential user = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: _email, password: _password);
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => calendarPage()));
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }
}