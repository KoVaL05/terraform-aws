import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  final surnameController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 140,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "John",
                          hintStyle: TextStyle(
                            fontFamily: "Prime",
                            color: Colors.white.withAlpha(100),
                          ),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5fb7cf))),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          )),
                    )),
                SizedBox(
                    width: 140,
                    child: TextField(
                      controller: surnameController,
                      decoration: InputDecoration(
                          hintText: "Doe",
                          hintStyle: TextStyle(
                            fontFamily: "Prime",
                            color: Colors.white.withAlpha(100),
                          ),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5fb7cf))),
                          prefixIcon: Icon(
                            Icons.badge,
                            color: Colors.white,
                          )),
                    ))
              ],
            )),
        SizedBox(
          height: 50,
        ),
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
                  final userAttributes = {
                    AuthUserAttributeKey.email: emailController.text.trim(),
                    AuthUserAttributeKey.name: nameController.text.trim(),
                    AuthUserAttributeKey.familyName: surnameController.text.trim()
                  };

                  var result = await Amplify.Auth.signUp(
                      username: nameController.text.trim(),
                      password: passwordController.text,
                      options: SignUpOptions(userAttributes: userAttributes));
                  print("SIGNUP RESULT $result");

                  if (!result.isSignUpComplete && result.nextStep.signUpStep == AuthSignUpStep.confirmSignUp) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Insert confirmation code'),
                          content: TextField(
                            keyboardType: TextInputType.phone,
                            controller: pinController,
                            decoration: InputDecoration(hintText: "Text Field in Dialog"),
                          ),
                          actions: <Widget>[
                            InkWell(
                              child: Text('CANCEL'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            InkWell(
                              child: Text('OK'),
                              onTap: () async {
                                var result = await Amplify.Auth.confirmSignUp(
                                    username: emailController.text.trim(), confirmationCode: pinController.text);
                                print("CODE RESULT $result");
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF15BE7B)),
                child: Text("Sign Up",
                    style: TextStyle(fontFamily: "Prime", color: Colors.white, fontWeight: FontWeight.bold)))),
      ],
    );
  }
}
