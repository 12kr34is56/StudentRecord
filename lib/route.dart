import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_record/presentation/presentation.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => SplashScreen());
      case '/login-screen':
        return CupertinoPageRoute(builder: (_) => LoginScreen());
      case '/sign-up-screen':
        return CupertinoPageRoute(builder: (_) =>  SignUpScreen());
      case '/home-screen':
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      case '/verification-screen':
        return CupertinoPageRoute(builder: (_) => const VerificationScreen());

      default:
        return CupertinoPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text("No route"),
                  ),
                ));
    }
  }
}
