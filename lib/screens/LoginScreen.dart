import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nazarih_mobile/services/preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNo;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo/logo.png',
            height: 94,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                onChanged: (val) {
                  phoneNo = val;
                },
                textAlign: TextAlign.right,
                style: TextStyle(fontFamily: 'Bahij'),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'أدخل رقم هاتفك' + " : " + "05" + 'xxxxxxxx',
                    fillColor: Colors.blueGrey[50],
                    filled: true,
                    // icon: Icon(Icons.phone_android),
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bahij',
                    ),
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bahij',
                    ),
                    contentPadding: EdgeInsets.only(right: 30, left: 30),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey[50],
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey[50],
                        ),
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue[100],
                        spreadRadius: 10,
                        blurRadius: 20)
                  ]),
              child: ElevatedButton(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                      child: Text(
                    "سجل دخول",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bahij',
                    ),
                  )),
                ),
                onPressed: () async {
                  if (phoneNo == null || phoneNo == '') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      'الرجاء ادخال المعلومات بشكل صحيح',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Bahij',
                      ),
                    )));
                  } else {
                    var test = await _firestore
                        .collection('users')
                        .doc(phoneNo.replaceAll(' ', ''))
                        .get();
                    if (test.exists == true) {
                      String name;
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(phoneNo.replaceAll(' ', ''))
                          .get()
                          .then((DocumentSnapshot documentSnapshot) => {
                                name = documentSnapshot.data()['Name'],
                              });
                      savePhoneNumber(phoneNo.replaceAll(' ', ''));
                      saveName(name);
                      saveLogin(true);
                      Navigator.pushNamed(context, '/Wrapper');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        'رقم الهاتف غير مسجل في قاعدة البيانات برجاء انشاء حساب',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Bahij',
                        ),
                      )));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF2980b9),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  'انشأ حساب جديد الان',
                  style: TextStyle(
                      color: Color(0xFF2980b9),
                      fontFamily: 'Bahij',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 15),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'هل انت مستخدم جديد؟',
                style: TextStyle(
                    fontFamily: 'Bahij', color: Colors.black, fontSize: 15),
              )
            ],
          )
        ],
      ),
    );
  }
}
