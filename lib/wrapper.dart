import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih_mobile/services/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/LoginScreen.dart';
import 'screens/HomeScreen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String phoneNo;
  bool login;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (login == false) {
      return LoginScreen();
    } else {
      return HomeScreen();
    }
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      login = prefs.getBool('Login') ?? false;
      phoneNo = prefs.getString('Phone Number') ?? null;
    });

    if (phoneNo != null) {
      var doc = await _firestore.collection('users').doc(phoneNo).get();
      if (!doc.exists) {
        setState(() {
          login = false;
          phoneNo = null;
          saveLogin(false);
          savePhoneNumber(null);
        });
      }
    }
  }
}
