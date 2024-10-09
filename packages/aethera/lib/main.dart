import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'amplify_config.dart';

Future<void> main() async {
  try {
    await dotenv.load();
    WidgetsFlutterBinding.ensureInitialized();
    await _configureAmplify();
    runApp(const MyApp());
  } on AmplifyException catch (e) {
    runApp(Text("Error configuring Amplify: ${e.message}"));
  }
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.configure(amplifyConfig);
    safePrint('Successfully configured');
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    // final userAttributes = {
                    //   AuthUserAttributeKey.email: "fifiw2005@gmail.com",
                    // };
                    try {
                      var result = await Amplify.Auth.signUp(
                        username: "filip",
                        password: "zaq1@WSX",
                      );
                      // options: SignUpOptions(userAttributes: userAttributes));
                      print("RESULT $result");
                    } catch (e) {
                      print("ERROR $e");
                    }
                  },
                  child: Text("ELO")),
              Text('TODO Application'),
            ],
          ),
        ),
      ),
    );
  }
}
