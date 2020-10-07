import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:red_button/screens/bottom_tabs.dart';
import 'package:red_button/providers/authorization.dart';
import 'package:red_button/widgets/fade_animation.dart';

enum LoginMode { Email, Phone }

enum AuthMode { Login, SignUP }

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  LoginMode _loginMode = LoginMode.Email;
  AuthMode _authMode = AuthMode.Login;
  bool _isLoading = false;

//logging in with phone which is UpCOMING
  // void _switchLoginMode(LoginMode mode) {
  //   setState(() {
  //     _loginMode = mode;
  //   });
  // }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUP;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.red[900], Colors.red[800], Colors.red[400]])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //HEADING
                  FadeAnimation(
                      1,
                      Text(
                        _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  //SUBHEADING
                  FadeAnimation(
                      1.3,
                      Text(
                        _authMode == AuthMode.Login
                            ? 'Welcome Back'
                            : 'Hi There',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  if (_loginMode == LoginMode.Email)
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextField(
                                        controller: passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        if (_isLoading)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            child: CircularProgressIndicator(),
                          )
                        else
                          //LOGIN METHOD
                          GestureDetector(
                            onTap: () async {
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                              setState(() {
                                print('TAPPED');
                                _isLoading = true;
                              });
                              if (_authMode == AuthMode.Login) {
                                final result = await context
                                    .read<AuthenticationService>()
                                    .signIn(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim());
                                if (result == 'Signed in')
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (_) {
                                    return BottomTabs();
                                  }));
                              } else {
                                final result = await context
                                    .read<AuthenticationService>()
                                    .signUp(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim());
                                if (result == 'Signed in')
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (_) {
                                    return BottomTabs();
                                  }));
                              }
                              // setState(() {
                              //   print('unTapped');
                              //   _isLoading = false;
                              // });
                            },
                            //LOGIN OR SIGNUP BUTTON
                            child: FadeAnimation(
                                1.6,
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.orange[900]),
                                  child: Center(
                                    child: Text(
                                      _authMode == AuthMode.Login
                                          ? 'LOGIN'
                                          : 'SIGN UP',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          ),
                        SizedBox(
                          height: 5,
                        ),
                        FadeAnimation(
                            1.5,
                            FlatButton(
                              onPressed: () {
                                _switchAuthMode();
                              },
                              child: Text(
                                "${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )),

                        ///Upcoming feature of ligging in with phone and google

                        // SizedBox(
                        //   height: 40,
                        // ),
                        // FadeAnimation(
                        //     1.7,
                        //     Text(
                        //       _authMode == AuthMode.Login
                        //           ? 'Sign Up WIth'
                        //           : 'Login With',
                        //       style: TextStyle(color: Colors.grey),
                        //     )),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        // Row(
                        //   children: <Widget>[
                        //     Expanded(
                        //       child: FadeAnimation(
                        //           1.8,_loginMode == LoginMode.Emaio
                        //           GestureDetector(
                        //             onTap: () {
                        //               _switchAuthMode();
                        //               _switchLoginMode(LoginMode.Email);
                        //             },
                        //             child: Container(
                        //               height: 50,
                        //               decoration: BoxDecoration(
                        //                   borderRadius:
                        //                       BorderRadius.circular(50),
                        //                   color: Colors.redAccent[700]),
                        //               child: Center(
                        //                 child: Text(
                        //                   "EMAIL",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //             ),
                        //           )),
                        //     ),
                        //     SizedBox(
                        //       width: 30,
                        //     ),
                        //     Expanded(
                        //       child: FadeAnimation(
                        //           1.9,
                        //           GestureDetector(
                        //             onTap: () {
                        //               _switchAuthMode();
                        //               _switchLoginMode(LoginMode.Phone);
                        //             },
                        //             child: Container(
                        //               height: 50,
                        //               decoration: BoxDecoration(
                        //                   borderRadius:
                        //                       BorderRadius.circular(50),
                        //                   color: Colors.black),
                        //               child: Center(
                        //                 child: Text(
                        //                   "PHONE",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //             ),
                        //           )),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
