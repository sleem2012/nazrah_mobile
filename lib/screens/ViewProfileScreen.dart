import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nazarih_mobile/models/ad.dart';
import 'package:nazarih_mobile/services/firebase_storage.dart';
import 'package:nazarih_mobile/screens/AdDetails.dart';
import 'dart:math' as math;
import 'package:nazarih_mobile/screens/ChatRoomScreen.dart';

class ViewProfileScreen extends StatefulWidget {
  final String phoneNo;
  final String myPhone;

  ViewProfileScreen({@required this.phoneNo, @required this.myPhone});

  @override
  _ViewProfileScreenState createState() =>
      _ViewProfileScreenState(phoneNo: phoneNo, myPhone: myPhone);
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String phoneNo;
  String myPhone;

  _ViewProfileScreenState({@required this.phoneNo, @required this.myPhone});

  Stream<DocumentSnapshot> loadMyInfo() {
    return _firestore.collection('users').doc(phoneNo).snapshots();
  }

  Stream<QuerySnapshot> loadAds(String phoneNumber) {
    return _firestore
        .collection('ads')
        .where('user', isEqualTo: phoneNumber)
        .snapshots();
  }

  createChatroom(String chatRoomId, chatRoomMap) {
    _firestore.collection('ChatRoom').doc(chatRoomId).set(chatRoomMap);
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
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                children: [
                  StreamBuilder<DocumentSnapshot>(
                    stream: loadMyInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String name = snapshot.data.data()['Name'];
                        int rating_count = snapshot.data.data()['rating'];
                        String commission = snapshot.data.data()['Commission'];
                        String membership = snapshot.data.data()['Membership'];
                        String photoUrl = snapshot.data.data()['photo_url'];

                        double rating = (rating_count != 0)
                            ? (rating_count * 5) / rating_count
                            : 0;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Material(
                                color: Color(0xFF2980b9),
                                child: InkWell(
                                  onTap: () {
                                    String chatRoomId =
                                        getChatRoomId(phoneNo, myPhone);
                                    List<String> users = [phoneNo, myPhone];
                                    Map<String, dynamic> chatRoomMap = {
                                      "users": users,
                                      "chatRoomId": chatRoomId
                                    };
                                    createChatroom(chatRoomId, chatRoomMap);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatRoom(
                                                chatRoomId: chatRoomId,
                                                phoneNo: myPhone,
                                              )),
                                    );
                                  },
                                  child: Transform.rotate(
                                      angle: 270 * math.pi / 180,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.send,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.end,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      (membership == 'Premium')
                                          ? Row(
                                              children: [
                                                Text(
                                                  "عضوية نظره المدفوعة",
                                                  style: TextStyle(
                                                      fontFamily: 'Bahij',
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                        height: 10,
                                      ),
                                      (commission == 'Paid')
                                          ? Row(
                                              children: [
                                                Text(
                                                  "دفع العمولة",
                                                  style: TextStyle(
                                                      fontFamily: 'Bahij',
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    StreamBuilder<String>(
                                      stream: downloadUrl(photoUrl).asStream(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting)
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        return Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 4,
                                                  color: Colors.white),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 10))
                                              ],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot
                                                      .data
                                                      .toString()))),
                                        );
                                      },
                                    ),
                                    // Positioned(
                                    //     bottom: 0,
                                    //     right: 0,
                                    //     child: GestureDetector(
                                    //         onTap: () {
                                    //           uploadImage(phoneNo, phoneNo);
                                    //         },
                                    //         child: Container(
                                    //             height: 40,
                                    //             width: 40,
                                    //             decoration: BoxDecoration(
                                    //                 color: Colors.blue,
                                    //                 border: Border.all(
                                    //                     width: 4,
                                    //                     color:
                                    //                         Colors.white),
                                    //                 shape: BoxShape.circle),
                                    //             child: Icon(
                                    //               Icons.edit,
                                    //               color: Colors.white,
                                    //             )))),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                RatingBar.builder(
                                  initialRating: rating,
                                  minRating: 1,
                                  itemSize: 25,
                                  // rating: rating,
                                  allowHalfRating: false,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (ratingVal) async {
                                    if (ratingVal == 1) {
                                      int rating = 0;
                                      await _firestore
                                          .collection('users')
                                          .doc(phoneNo)
                                          .get()
                                          .then((DocumentSnapshot
                                                  documentSnapshot) =>
                                              {
                                                rating = documentSnapshot
                                                    .data()['rating'],
                                              });
                                      _firestore
                                          .collection('users')
                                          .doc(phoneNo)
                                          .update({'rating': rating + 1});
                                    } else if (ratingVal == 2) {
                                      int rating = 0;
                                      await _firestore
                                          .collection('users')
                                          .doc(phoneNo)
                                          .get()
                                          .then((DocumentSnapshot
                                                  documentSnapshot) =>
                                              {
                                                rating = documentSnapshot
                                                    .data()['rating'],
                                              });
                                      _firestore
                                          .collection('users')
                                          .doc(phoneNo)
                                          .update({'rating': rating + 2});
                                    } else if (ratingVal == 3) {
                                      int rating = 0;
                                      await _firestore
                                          .collection('users')
                                          .doc(phoneNo)
                                          .get()
                                          .then((DocumentSnapshot
                                                  documentSnapshot) =>
                                              {
                                                rating = documentSnapshot
                                                    .data()['rating'],
                                              });
                                      _firestore
                                          .collection('users')
                                          .doc(phoneNo)
                                          .update({'rating': rating + 3});
                                    } else if (ratingVal == 4) {
                                      int rating = 0;
                                      await _firestore
                                          .collection('users')
                                          .doc(phoneNo)
                                          .get()
                                          .then((DocumentSnapshot
                                                  documentSnapshot) =>
                                              {
                                                rating = documentSnapshot
                                                    .data()['rating'],
                                              });
                                      _firestore
                                          .collection('users')
                                          .doc(phoneNo)
                                          .update({'rating': rating + 4});
                                    } else if (ratingVal == 5) {
                                      int rating = 0;
                                      await _firestore
                                          .collection('users')
                                          .doc(phoneNo)
                                          .get()
                                          .then((DocumentSnapshot
                                                  documentSnapshot) =>
                                              {
                                                rating = documentSnapshot
                                                    .data()['rating'],
                                              });
                                      _firestore
                                          .collection('users')
                                          .doc(phoneNo)
                                          .update({'rating': rating + 5});
                                    }
                                  },
                                )
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "الاعلانات",
                      style: TextStyle(fontFamily: 'Bahij', fontSize: 35),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: loadAds(phoneNo),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data.docs.length == 0) {
                        return Center(
                          child: Text("لاتوجد اعلانات فالوقت الحالي"),
                        );
                      } else {
                        List<AdDisplayInfo> ads = [];

                        for (var doc in snapshot.data.docs) {
                          final Timestamp timestamp =
                              doc.data()['date'] as Timestamp;
                          final DateTime dateTime = timestamp.toDate();

                          ads.add(AdDisplayInfo(
                              title: doc.data()['Title'],
                              country: doc.data()['Country'],
                              photoBool: doc.data()['photoBool'],
                              subCategory: doc.data()['subCategory'],
                              docId: doc.id,
                              photoPath: (doc.data()['photoBool'] == 'true')
                                  ? doc.data()['photo_url 0']
                                  : '',
                              selectedCategory: doc.data()['selectedCategory'],
                              dateDays:
                                  DateTime.now().difference(dateTime).inDays,
                              dateHours:
                                  DateTime.now().difference(dateTime).inHours,
                              dateMins: DateTime.now()
                                  .difference(dateTime)
                                  .inMinutes));
                        }

                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: ListView.builder(
                                itemCount: ads.length,
                                shrinkWrap: true,

                                //reverse: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 25),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AdDetails(
                                                    ads[index].docId, phoneNo)),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ads[index].title,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontFamily: 'Bahij',
                                                      fontSize: 30,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.pin_drop,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      ads[index].country,
                                                      style: TextStyle(
                                                        fontFamily: 'Bahij',
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.timelapse,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      (ads[index].dateDays != 0)
                                                          ? "قبل ${ads[index].dateDays} ايام"
                                                          : (ads[index]
                                                                      .dateHours !=
                                                                  0)
                                                              ? "قبل ${ads[index].dateHours} ساعات"
                                                              : "قبل ${ads[index].dateMins} دقائق",
                                                      style: TextStyle(
                                                        fontFamily: 'Bahij',
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            (ads[index].photoBool == 'true')
                                                ? FutureBuilder<String>(
                                                    future: downloadUrl(
                                                        ads[index].photoPath),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting)
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      return ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.network(
                                                          snapshot.data
                                                              .toString(),
                                                          width: 150,
                                                          height: 150,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.asset(
                                                      'assets/images/no_image.png',
                                                      width: 150,
                                                      height: 150,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(2, 3).codeUnitAt(0) > b.substring(2, 3).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
