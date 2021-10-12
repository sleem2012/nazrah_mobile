import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih_mobile/screens/ContactScreen.dart';
import 'package:nazarih_mobile/screens/NotificationsScreen.dart';
import 'package:nazarih_mobile/screens/profileScreen.dart';
import 'package:nazarih_mobile/services/firebase_storage.dart';
import 'package:nazarih_mobile/services/preferences.dart';
import 'package:nazarih_mobile/screens/LegacyScreen.dart';
import 'package:nazarih_mobile/screens/TermsScreen.dart';
import 'package:nazarih_mobile/screens/CommissionScreen.dart';
import 'package:nazarih_mobile/screens/MembershipScreen.dart';
import 'package:nazarih_mobile/screens/ChatsScreen.dart';
import 'package:nazarih_mobile/screens/DelegateScreen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final String phoneNo;

  NavigationDrawerWidget(this.phoneNo);
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> loadMyPages() {
    return _firestore.collection('info').doc('Pages').snapshots();
  }

  Stream<DocumentSnapshot> loadMyInfo() {
    return _firestore.collection('users').doc(phoneNo).snapshots();
  }

  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color(0xFF2980b9),
        child: ListView(
          padding: padding,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: loadMyInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String name = snapshot.data.data()['Name'];
                  String photoUrl = snapshot.data.data()['photo_url'];
                  return StreamBuilder<String>(
                    stream: downloadUrl(photoUrl).asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return buildHeader(
                          urlImage: snapshot.data.toString(),
                          name: name,
                          ontap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                        phoneNo: phoneNo,
                                      )),
                            );
                          });
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            buildMenuItem(
                text: 'الاشعارات',
                icon: Icons.notifications,
                ontap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsScreen(
                              phoneNo: phoneNo,
                            )),
                  );
                }),
            buildMenuItem(
                text: 'الرسائل',
                icon: Icons.chat,
                ontap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatsScreen(
                              phoneNo: phoneNo,
                            )),
                  );
                }),
            SizedBox(
              height: 24,
            ),
            Divider(
              color: Colors.white70,
            ),
            SizedBox(
              height: 24,
            ),
            buildMenuItem(
                text: 'العضويات',
                icon: Icons.card_membership,
                ontap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MembershipScreen()),
                  );
                }),
            buildMenuItem(
                text: 'العمولة',
                icon: Icons.calculate,
                ontap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CommissionScreen()),
                  );
                }),
            SizedBox(
              height: 24,
            ),
            Divider(
              color: Colors.white70,
            ),
            SizedBox(
              height: 24,
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: loadMyPages(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    bool delegate = snapshot.data.data()['Delegate'];
                    if (delegate) {
                      return Column(
                        children: [
                          buildMenuItem(
                              text: 'تسجيل مندوب',
                              icon: Icons.app_registration,
                              ontap: () {
                                Navigator.pop(context);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DelegateScreen()),
                                );
                              }),
                          SizedBox(
                            height: 24,
                          ),
                          Divider(
                            color: Colors.white70,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Column(
                      children: [
                        buildMenuItem(
                            text: 'تسجيل مندوب',
                            icon: Icons.app_registration,
                            ontap: () {
                              Navigator.pop(context);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DelegateScreen()),
                              );
                            }),
                        SizedBox(
                          height: 24,
                        ),
                        Divider(
                          color: Colors.white70,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    );
                  }
                }),
            buildMenuItem(
                text: 'اتفاقية استخدام الموقع والمعلومات',
                icon: Icons.rule,
                ontap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermsScreen()),
                  );
                }),
            StreamBuilder<DocumentSnapshot>(
              stream: loadMyPages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool legacy = snapshot.data.data()['Legacy'];
                  if (legacy) {
                    return buildMenuItem(
                        text: 'السلع والإعلانات الممنوعة',
                        icon: Icons.cancel,
                        ontap: () {
                          Navigator.pop(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LegacyScreen()),
                          );
                        });
                  } else {
                    return Container();
                  }
                } else {
                  return buildMenuItem(
                      text: 'السلع والإعلانات الممنوعة',
                      icon: Icons.cancel,
                      ontap: () {
                        Navigator.pop(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LegacyScreen()),
                        );
                      });
                }
              },
            ),
            SizedBox(
              height: 24,
            ),
            Divider(
              color: Colors.white70,
            ),
            SizedBox(
              height: 24,
            ),
            buildMenuItem(
                text: 'أتصل بنا',
                icon: Icons.contact_support,
                ontap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactScreen()),
                  );
                }),
            SizedBox(
              height: 24,
            ),
            Divider(
              color: Colors.white70,
            ),
            SizedBox(
              height: 24,
            ),
            buildMenuItem(
                text: 'تسجيل خروج',
                icon: Icons.logout,
                ontap: () {
                  saveLogin(false);
                  saveName('');
                  savePhoneNumber('');
                  Navigator.pushNamed(context, '/Wrapper');
                }),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(
      {@required String urlImage,
      @required String name,
      @required Function ontap}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(urlImage),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Bahij',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {@required String text,
      @required IconData icon,
      @required Function ontap}) {
    final color = Colors.white;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          text,
          style: TextStyle(
              color: color,
              fontFamily: 'Bahij',
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        onTap: ontap,
      ),
    );
  }
}
