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
              Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      SizedBox(
                          width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "email@aethera.com",
                                hintStyle: TextStyle(
                                  fontFamily: "Prime",
                                  color: Colors.white.withAlpha(100),
                                ),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5fb7cf))),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                )),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                          width: 300,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "###-###-###",
                                hintStyle: TextStyle(
                                  fontFamily: "Prime",
                                  color: Colors.white.withAlpha(100),
                                ),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5fb7cf))),
                                prefixIcon: Icon(
                                  Icons.key,
                                  color: Colors.white,
                                )),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                          width: 300,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF15BE7B)),
                              child: Text("Log in",
                                  style: TextStyle(
                                      fontFamily: "Prime", color: Colors.white, fontWeight: FontWeight.bold)))),
                      SizedBox(
                          width: 300,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(25)),
                                      side: BorderSide(color: Colors.white))),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Image.network(
                                      'http://pngimg.com/uploads/google/google_PNG19635.png',
                                      height: 35,
                                      width: 35,
                                    )),
                                Text("Log in with Google",
                                    style: TextStyle(
                                        fontFamily: "Prime", color: Colors.white, fontWeight: FontWeight.bold))
                              ])))
                    ],
                  )),
            ],
          ),
        )
      ],
    ));
  }
}

enum Page { Login, SignUp }
