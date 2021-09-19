import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nazarih_mobile/services/firebase_storage.dart';
import 'package:nazarih_mobile/screens/ChatRoomScreen.dart';

class ChatsScreen extends StatefulWidget {
  final String phoneNo;

  ChatsScreen({@required this.phoneNo});

  @override
  _ChatsScreenState createState() => _ChatsScreenState(phoneNo: phoneNo);
}

class ChatRoomsInfo {
  String chatRoomId, phoneNumber;
  ChatRoomsInfo({this.chatRoomId, this.phoneNumber});
}

class _ChatsScreenState extends State<ChatsScreen> {
  String phoneNo;
  _ChatsScreenState({@required this.phoneNo});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> loadMyInfo(String phoneNumber) {
    return _firestore.collection('users').doc(phoneNumber).snapshots();
  }

  getChatRooms(String userName) {
    return _firestore
        .collection('ChatRoom')
        .where("users", arrayContains: userName)
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 50),
                                child: Text("المحادثات",
                                    style: TextStyle(
                                        fontFamily: 'Bahij',
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: getChatRooms(phoneNo),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData ||
                                  snapshot.data.docs.length == 0) {
                                return Center(
                                  child: Text(
                                    "لاتوجد محادثات فالوقت الحالي",
                                    style: TextStyle(
                                        fontFamily: 'Bahij',
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              } else {
                                List<ChatRoomsInfo> chats = [];

                                for (var doc in snapshot.data.docs) {
                                  chats.add(ChatRoomsInfo(
                                      phoneNumber: doc
                                          .data()['chatRoomId']
                                          .toString()
                                          .replaceAll("_", "")
                                          .replaceAll(phoneNo, ""),
                                      chatRoomId: doc.data()['chatRoomId']));
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 25),
                                  child: ListView.builder(
                                    itemCount: chats.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // locator<NavigationService>().navigateTo(
                                          //     ChatRoomRoute,
                                          //     queryParams: {
                                          //       'id': chats[index].chatRoomId
                                          //     });
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ChatRoom(
                                                      chatRoomId: chats[index]
                                                          .chatRoomId,
                                                      phoneNo: phoneNo,
                                                    )),
                                          );
                                        },
                                        child: StreamBuilder<DocumentSnapshot>(
                                          stream: loadMyInfo(
                                              chats[index].phoneNumber),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              String name =
                                                  snapshot.data.data()['Name'];
                                              int rating_count = snapshot.data
                                                  .data()['rating'];
                                              String commission = snapshot.data
                                                  .data()['Commission'];
                                              String membership = snapshot.data
                                                  .data()['Membership'];
                                              String photoUrl = snapshot.data
                                                  .data()['photo_url'];

                                              double rating =
                                                  (rating_count != 0)
                                                      ? (rating_count * 5) /
                                                          rating_count
                                                      : 0;
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 50),
                                                child: Container(
                                                  //width: MediaQuery.of(context).size.width / 1.5,
                                                  height: 300,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors
                                                                .blue[100],
                                                            spreadRadius: 10,
                                                            blurRadius: 20)
                                                      ]),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          StreamBuilder<String>(
                                                            stream: downloadUrl(
                                                                    photoUrl)
                                                                .asStream(),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting)
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                );
                                                              return Container(
                                                                width: 100,
                                                                height: 100,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border: Border.all(
                                                                            width:
                                                                                4,
                                                                            color: Colors
                                                                                .white),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              spreadRadius: 2,
                                                                              blurRadius: 10,
                                                                              color: Colors.black.withOpacity(0.1),
                                                                              offset: Offset(0, 10))
                                                                        ],
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image: NetworkImage(snapshot.data.toString()))),
                                                              );
                                                            },
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          RatingBarIndicator(
                                                            rating: rating,
                                                            direction:
                                                                Axis.horizontal,
                                                            itemCount: 5,
                                                            itemSize: 25,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        name,
                                                        style: TextStyle(
                                                            fontFamily: 'Bahij',
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      (membership == 'Premium')
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "عضوية نظره المدفوعة",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Bahij',
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/icons/star.png',
                                                                  height: 25,
                                                                ),
                                                              ],
                                                            )
                                                          : Container(),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      (commission == 'Paid')
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "دفع العمولة",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Bahij',
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/icons/invoice.png',
                                                                  height: 25,
                                                                ),
                                                              ],
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
