import 'package:aethera/presentation/views/auth/widgets/login.dart';
import 'package:aethera/presentation/views/auth/widgets/signup.dart';
import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  Page page = Page.Login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
          Color(0xFF2C5364),
          Color(0xFF203A43),
          Color(0xFF0F2027),
        ], begin: const FractionalOffset(0.0, 0.0), end: const FractionalOffset(0.0, 1.0)))),
        Padding(
          padding: EdgeInsets.all(8.0), //TODO %
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Center(
                      child: Text(
                    "AETHERA",
                    style: TextStyle(color: Colors.white, fontFamily: "Anurati", fontSize: 40, shadows: [
                      Shadow(color: Color(0xFF5fb7cf), offset: Offset(-2.0, 2.0), blurRadius: 1.0),
                      Shadow(color: Color(0xFFaee4ed), offset: Offset(2.0, -2.0), blurRadius: 1.0)
                    ]),
                  ))),
              Expanded(
                  flex: 1,
                  child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Center(
                          key: Key(page.toString()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () => setState(() {
                                        page = Page.Login;
                                      }),
                                  child: Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                      fontFamily: "Prime",
                                      color: page == Page.Login ? Color(0xFF5fb7cf) : Colors.white,
                                    ),
                                  )),
                              SizedBox(
                                width: 100,
                              ),
                              InkWell(
                                  onTap: () => setState(() {
                                        page = Page.SignUp;
                                      }),
                                  child: Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                      fontFamily: "Prime",
                                      color: page == Page.SignUp ? Color(0xFF5fb7cf) : Colors.white,
                                    ),
                                  ))
                            ],
                          )))),
              Expanded(flex: 5, child: page == Page.Login ? LoginForm() : SignupForm()),
            ],
          ),
        )
      ],
    ));
  }
}

enum Page { Login, SignUp }
