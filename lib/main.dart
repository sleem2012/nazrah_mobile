import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nazarih_mobile/screens/profileScreen.dart';
import 'package:nazarih_mobile/screens/splashScreen.dart';
import 'wrapper.dart';
import 'screens/LoginScreen.dart';
import 'screens/SignupScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

var routes = <String, WidgetBuilder>{
  '/Login': (BuildContext context) => LoginScreen(),
  '/signup': (BuildContext context) => SignUpScreen(),
  '/Wrapper': (BuildContext context) => Wrapper(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: SplashScreen(),
    );
  }
}
