import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 300,
            child: TextField(
              controller: emailController,
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
              controller: passwordController,
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
                onPressed: () async {
                  final username = emailController.text.trim().replaceAll(RegExp(r'[@.]'), '_');
                  print("USERNAME $username");
                  var result = await Amplify.Auth.signIn(
                      username: emailController.text.trim(), password: passwordController.text);
                  print("SIGN IN RESULT $result");
                },
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF15BE7B)),
                child: Text("Log in",
                    style: TextStyle(fontFamily: "Prime", color: Colors.white, fontWeight: FontWeight.bold)))),
        SizedBox(
            width: 300,
            child: ElevatedButton(
                onPressed: () async {
                  try {
                    var result = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
                    print("SIGN IN WITH GOOGLE RESULT $result");
                  } catch (e) {
                    print("ERROR $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)), side: BorderSide(color: Colors.white))),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        height: 35,
                        width: 35,
                      )),
                  Text("Log in with Google",
                      style: TextStyle(fontFamily: "Prime", color: Colors.white, fontWeight: FontWeight.bold))
                ])))
      ],
    );
  }
}
