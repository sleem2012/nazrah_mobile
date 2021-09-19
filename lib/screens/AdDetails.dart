import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nazarih_mobile/screens/profileScreen.dart';
import 'package:nazarih_mobile/services/firebase_storage.dart';
import 'package:nazarih_mobile/screens/ViewProfileScreen.dart';

class AdDetails extends StatefulWidget {
  final String phoneNo, docId;

  AdDetails(this.docId, this.phoneNo);

  @override
  _AdDetailsState createState() =>
      _AdDetailsState(docId: docId, phoneNo: phoneNo);
}

addConversationMessages(String adId, messageMap) {
  FirebaseFirestore.instance
      .collection('ads')
      .doc(adId)
      .collection('ChatRoom')
      .add(messageMap);
}

getConversationMessages(String adId) {
  return FirebaseFirestore.instance
      .collection('ads')
      .doc(adId)
      .collection('ChatRoom')
      .orderBy('time')
      .snapshots();
}

class _AdDetailsState extends State<AdDetails> {
  String phoneNo, docId;
  _AdDetailsState({@required this.docId, @required this.phoneNo});
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List imgList = [
    'assets/images/no_image.png',
  ];
  Stream<DocumentSnapshot> loadAdDetails(documentId) {
    return _firestore.collection('ads').doc(documentId).snapshots();
  }

  TextEditingController messageController = new TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void scolldown() {
    Timer(
        Duration(seconds: 1),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn));
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    Timer(
        Duration(seconds: 2),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: StreamBuilder(
                stream: loadAdDetails(docId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String selectedCategory =
                        snapshot.data.data()['selectedCategory'];
                    String subCategory = snapshot.data.data()['subCategory'];
                    String country = snapshot.data.data()['Country'];
                    String location = snapshot.data.data()['subCountry'];
                    String title = snapshot.data.data()['Title'];
                    String communication =
                        snapshot.data.data()['Communication'];
                    String description = snapshot.data.data()['Description'];
                    String priceBool = snapshot.data.data()['priceBool'];
                    String price = snapshot.data.data()['price'];
                    String photoBool = snapshot.data.data()['photoBool'];
                    String userName = snapshot.data.data()['userName'];
                    String user = snapshot.data.data()['user'];

                    final Timestamp timestamp =
                        snapshot.data.data()['date'] as Timestamp;
                    final DateTime dateTime = timestamp.toDate();

                    int dateDays = DateTime.now().difference(dateTime).inDays;
                    int dateHours = DateTime.now().difference(dateTime).inHours;
                    int dateMins =
                        DateTime.now().difference(dateTime).inMinutes;
                    List imagePaths = [];

                    if (photoBool == 'true') {
                      int imageCount = snapshot.data.data()['imageCount'];
                      for (var i = 0; i < imageCount; i++) {
                        imagePaths.add(snapshot.data.data()['photo_url $i']);
                      }
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF2980b9),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blue[100],
                                          spreadRadius: 10,
                                          blurRadius: 20)
                                    ]),
                                //width: 50,
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        (priceBool == 'true')
                                            ? "$price ريال"
                                            : 'لم يتم تحديد السعر',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Bahij',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                              Text(
                                title,
                                style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (phoneNo != null) {
                                        String username;
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(phoneNo)
                                            .get()
                                            .then((DocumentSnapshot
                                                    documentSnapshot) =>
                                                {
                                                  username = documentSnapshot
                                                      .data()['Name'],
                                                });
                                        if (username == userName) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileScreen(
                                                      phoneNo: phoneNo,
                                                    )),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewProfileScreen(
                                                        phoneNo: user,
                                                        myPhone: phoneNo)),
                                          );
                                          // locator<NavigationService>().navigateTo(
                                          //     UserDetailsRoute,
                                          //     queryParams: {'id': user});
                                        }
                                      }
                                    },
                                    child: Text(
                                      userName,
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 20,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        (photoBool == 'true')
                            ? FutureBuilder<List<String>>(
                                future: downloadUrls(imagePaths),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    //print(snapshot.data[1]);
                                    // if (snapshot.connectionState ==
                                    //     ConnectionState.waiting)
                                    //   return Center(
                                    //     child: CircularProgressIndicator(),
                                    //   );
                                    List<String> list = snapshot.data;
                                    return CarouselSlider(
                                        items: list.map((imgPath) {
                                          return Builder(
                                              builder: (BuildContext context) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30, bottom: 30),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              Colors.blue[100],
                                                          spreadRadius: 10,
                                                          blurRadius: 20)
                                                    ]),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    imgPath,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        }).toList(),
                                        options: CarouselOptions(
                                          height: 300,
                                          autoPlay: true,
                                          initialPage: 0,
                                          enlargeCenterPage: true,
                                          autoPlayInterval:
                                              Duration(seconds: 2),
                                          autoPlayAnimationDuration:
                                              Duration(milliseconds: 2000),
                                        ));
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              )
                            : CarouselSlider(
                                items: imgList.map((imgPath) {
                                  return Builder(
                                      builder: (BuildContext context) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 30),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.blue[100],
                                                  spreadRadius: 10,
                                                  blurRadius: 20)
                                            ]),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            imgPath,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                }).toList(),
                                options: CarouselOptions(
                                  height: 300,
                                  autoPlay: true,
                                  initialPage: 0,
                                  enlargeCenterPage: true,
                                  autoPlayInterval: Duration(seconds: 2),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 2000),
                                )),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            description,
                            style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 30,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      country,
                                      style: TextStyle(
                                        fontFamily: 'Bahij',
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.pin_drop,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      (location == 'null') ? country : location,
                                      style: TextStyle(
                                        fontFamily: 'Bahij',
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.map,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      (dateDays != 0)
                                          ? "قبل $dateDays ايام"
                                          : (dateHours != 0)
                                              ? "قبل $dateHours ساعات"
                                              : "قبل $dateMins دقائق",
                                      style: TextStyle(
                                        fontFamily: 'Bahij',
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 11,
                                    ),
                                    Icon(
                                      Icons.timelapse,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      communication,
                                      style: TextStyle(
                                        fontFamily: 'Bahij',
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.phone,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: getConversationMessages(docId),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data.docs.length == 0) {
                                  return Center(
                                    child: Text(
                                      "لاتوجد رسائل فالوقت الحالي",
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    controller: _scrollController,
                                    itemCount: snapshot.data.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return MessageTile(
                                          snapshot.data.docs[index]["message"],
                                          snapshot.data.docs[index]["sendBy"] ==
                                              phoneNo,
                                          snapshot.data.docs[index]["name"],
                                          userName,
                                          snapshot.data.docs[index]["sendBy"],
                                          phoneNo);
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                controller: messageController,
                                maxLines: 2,
                                onChanged: (val) {
                                  //description = val;
                                },
                                textAlign: TextAlign.right,
                                style: TextStyle(fontFamily: 'Bahij'),
                                decoration: InputDecoration(
                                    hintText: 'أكتب سؤالك للمعلن هنا',
                                    fillColor: Colors.blueGrey[50],
                                    filled: true,
                                    //icon: Icon(Icons.phone),
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Bahij',
                                    ),
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Bahij',
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        right: 30,
                                        top: 20,
                                        bottom: 20,
                                        left: 30),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blueGrey[50],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blueGrey[50],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 300,
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
                                "ارسال",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Bahij',
                                ),
                              )),
                            ),
                            onPressed: () async {
                              if (messageController.text.isNotEmpty) {
                                String username;
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(phoneNo)
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) =>
                                        {
                                          username =
                                              documentSnapshot.data()['Name'],
                                        });
                                Map<String, dynamic> messageMap = {
                                  "message": messageController.text,
                                  "sendBy": phoneNo,
                                  "time": DateTime.now().microsecondsSinceEpoch,
                                  'name': username
                                };
                                addConversationMessages(docId, messageMap);
                                messageController.text = '';
                                scolldown();
                                if (username != userName) {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user)
                                      .collection('Notifications')
                                      .doc()
                                      .set({
                                    "message":
                                        "لقد تلقيت رسالة جديده علي اعلانك" +
                                            " - " +
                                            title,
                                    'date':
                                        DateTime.now().microsecondsSinceEpoch,
                                    'type': 'ad',
                                    'docId': docId
                                  });
                                } else {
                                  List phoneNumbers = [];
                                  await _firestore
                                      .collection('ads')
                                      .doc(docId)
                                      .collection('ChatRoom')
                                      .where('sendBy', isNotEqualTo: phoneNo)
                                      .get()
                                      .then((snapshot) => {
                                            for (DocumentSnapshot ds
                                                in snapshot.docs)
                                              {
                                                if (!phoneNumbers.contains(
                                                    ds.data()['sendBy']))
                                                  {
                                                    phoneNumbers.add(
                                                        ds.data()['sendBy'])
                                                  }
                                              }
                                          });
                                  for (String phone in phoneNumbers) {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(phone)
                                        .collection('Notifications')
                                        .doc()
                                        .set({
                                      "message": "اضاف المعلن رسالة جديده" +
                                          " - " +
                                          title,
                                      'date':
                                          DateTime.now().microsecondsSinceEpoch,
                                      'type': 'ad',
                                      'docId': docId
                                    });
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
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text("....برجاء الانتظار"),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByME;
  final String sendBy;
  final String userName;
  final String phoneNo;
  final String myPhone;
  MessageTile(this.message, this.isSendByME, this.sendBy, this.userName,
      this.phoneNo, this.myPhone);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      width: MediaQuery.of(context).size.width,
      alignment: (isSendByME) ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: (isSendByME)
                    ? [const Color(0xffe84118), const Color(0xffc23616)]
                    : [const Color(0xff2f3640), const Color(0xff353b48)]),
            borderRadius: (isSendByME)
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23))),
        child: (isSendByME)
            ? Text(
                message,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Bahij',
                    fontWeight: FontWeight.bold),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewProfileScreen(
                            phoneNo: phoneNo, myPhone: myPhone)),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(message,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Bahij',
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    (sendBy == userName)
                        ? Text(
                            "مرسله من المعلن",
                            style: TextStyle(
                                color: Colors.amberAccent,
                                fontSize: 12,
                                fontFamily: 'Bahij',
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          )
                        : Text(
                            "مرسله من" + " " + sendBy,
                            style: TextStyle(
                                color: Colors.amberAccent,
                                fontSize: 12,
                                fontFamily: 'Bahij',
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
