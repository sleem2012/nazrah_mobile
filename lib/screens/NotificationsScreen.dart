import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nazarih_mobile/screens/ChatRoomScreen.dart';

class NotificationsScreen extends StatefulWidget {
  final String phoneNo;

  NotificationsScreen({@required this.phoneNo});

  @override
  _NotificationsScreenState createState() =>
      _NotificationsScreenState(phoneNo: phoneNo);
}

class NotificationsInfo {
  String message, type, docId;
  NotificationsInfo({this.message, this.type, this.docId});
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String phoneNo;
  _NotificationsScreenState({@required this.phoneNo});

  Stream<QuerySnapshot> loadMyNotifications() {
    return _firestore
        .collection('users')
        .doc(phoneNo)
        .collection('Notifications')
        .orderBy('date', descending: true)
        .snapshots();
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2980b9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        title: Image.asset(
          "assets/images/logo/logo_text.png",
          height: 50,
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF2980b9),
        actions: [
          IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            // Container(
            //   height: 100,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 15, right: 15),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             SizedBox(
            //               width: 30,
            //             ),
            //             // Text(
            //             //   "نظره",
            //             //   style: TextStyle(
            //             //       fontSize: 50,
            //             //       fontFamily: "Arslan Wessam",
            //             //       color: Colors.white,
            //             //       fontWeight: FontWeight.bold),
            //             // ),
            //             Image.asset(
            //               "assets/images/logo/logo_text.png",
            //               height: 50,
            //             ),
            //             InkWell(
            //               onTap: () {
            //                 Navigator.pop(context);
            //               },
            //               child: Icon(
            //                 Icons.arrow_forward,
            //                 color: Colors.white,
            //                 size: 30,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 20)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _firestore
                                      .collection('users')
                                      .doc(phoneNo)
                                      .collection('Notifications')
                                      .get()
                                      .then((snapshot) => {
                                            for (DocumentSnapshot ds
                                                in snapshot.docs)
                                              {ds.reference.delete()}
                                          });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFFe74c3c),
                                ),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              Text("الاشعارات",
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: loadMyNotifications(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text(
                                  "لاتوجد اشعارات فالوقت الحالي",
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            } else {
                              List<NotificationsInfo> notifications = [];
                              for (var doc in snapshot.data.docs) {
                                notifications.add(NotificationsInfo(
                                    docId: doc.data()['docId'],
                                    message: doc.data()['message'],
                                    type: doc.data()['type']));
                              }
                              return ListView.builder(
                                itemCount: notifications.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (notifications[index].type ==
                                          'message') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChatRoom(
                                                    chatRoomId:
                                                        notifications[index]
                                                            .docId,
                                                    phoneNo: phoneNo,
                                                  )),
                                        );
                                      } else {}
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 25),
                                      child: Container(
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF2980b9),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 40, right: 40),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                notifications[index].message,
                                                style: TextStyle(
                                                    fontFamily: 'Bahij',
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
