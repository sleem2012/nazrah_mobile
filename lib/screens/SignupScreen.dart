import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nazarih_mobile/services/preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String phoneNo, name;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool terms = false;

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
              textDirection: TextDirection.ltr,
              child: TextField(
                onChanged: (val) {
                  name = val;
                },
                textAlign: TextAlign.right,
                //textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Arabic Nunbers',
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'أدخل الاسم ثنائي',
                    fillColor: Colors.blueGrey[50],
                    filled: true,
                    //icon: Icon(Icons.person),
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bahij',
                    ),
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bahij',
                    ),
                    contentPadding: EdgeInsets.only(right: 30),
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
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: CheckboxListTile(
                title: Text(
                  "موافق علي الشروط والاحكام",
                  style: TextStyle(
                    fontFamily: 'Bahij',
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.right,
                ),
                value: terms,
                onChanged: (newValue) {
                  setState(() {
                    terms = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
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
                    "أنشئ حساب",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bahij',
                    ),
                  )),
                ),
                onPressed: () async {
                  if (name == null ||
                      phoneNo == null ||
                      name == '' ||
                      phoneNo == '' ||
                      terms == false) {
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
                    if (phoneNo.length != 10) {
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          'هذا الرقم مسجل في قاعدة البيانات الرجاء تسجيل الدخول',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Bahij',
                          ),
                        )));
                      } else {
                        savePhoneNumber(phoneNo);
                        saveName(name);
                        saveLogin(true);
                        await _firestore
                            .collection('users')
                            .doc(phoneNo.replaceAll(' ', ''))
                            .set({
                          'Phone Number': phoneNo.replaceAll(' ', ''),
                          'Name': name,
                          'Commission': 'unpaid',
                          'Membership': 'free',
                          'rating': 0,
                          'date': DateTime.now(),
                          'last_seen': DateTime.now(),
                          'photo_url': '/default/profile_default.png',
                        });
                        Navigator.pushNamed(context, '/Wrapper');
                      }
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
                  Navigator.pushNamed(context, '/Login');
                },
                child: Text(
                  'سجل دخول الان',
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
                'هل تمتلك حساب سابق؟',
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
