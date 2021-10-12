import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nazarih_mobile/models/ad.dart';
import 'package:nazarih_mobile/services/firebase_storage.dart';
import 'package:nazarih_mobile/screens/AdDetails.dart';
import 'package:nazarih_mobile/screens/EditAdScreen.dart';

class ProfileScreen extends StatefulWidget {
  final String phoneNo;

  ProfileScreen({@required this.phoneNo});

  @override
  _ProfileScreenState createState() => _ProfileScreenState(phoneNo: phoneNo);
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String phoneNo;

  _ProfileScreenState({@required this.phoneNo});

  Stream<DocumentSnapshot> loadMyInfo() {
    return _firestore.collection('users').doc(phoneNo).snapshots();
  }

  Stream<QuerySnapshot> loadAds(String phoneNumber) {
    return _firestore
        .collection('ads')
        .where('user', isEqualTo: phoneNumber)
        .snapshots();
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;


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
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Row(
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 25,
                                          color: Colors.black,

                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.right,
                                    ),
                                    (membership == 'Premium')
                                        ? Row(
                                      children: [
                                        Text(
                                          "",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'assets/images/icons/star.png',
                                          height: 12,
                                        ),
                                      ],
                                    )
                                        : Container(),
                                  ],
                                ),
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
                                          fontSize: 18,
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
                                          width: 150,
                                          height: 150,
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
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                            onTap: () {
                                              uploadImage(phoneNo, phoneNo);
                                            },
                                            child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF2980b9),
                                                    border: Border.all(
                                                        width: 4,
                                                        color: Colors.white),
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                )))),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                RatingBarIndicator(
                                  itemSize: 25,
                                  rating: rating,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
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
                                physics: NeverScrollableScrollPhysics(),
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
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(left: 10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              ads[index].title,
                                                              textAlign:
                                                              TextAlign.right,
                                                              style: TextStyle(
                                                                  fontFamily: 'Bahij',
                                                                  fontSize: 20,
                                                                  color: Colors.black,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                            ),

                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.pin_drop,
                                                                  color: Colors.black,
                                                                  size: 18,

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

                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.timelapse,
                                                                  color: Colors.black,
                                                                  size: 18,

                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  (ads[index].dateDays !=
                                                                      0)
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
                                                      ),
                                                    ),
                                                    (ads[index].photoBool == 'true')
                                                        ? FutureBuilder<String>(
                                                      future: downloadUrl(
                                                          ads[index]
                                                              .photoPath),
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
                                                        return ClipRRect(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                          child:
                                                          Image.network(
                                                            snapshot.data
                                                                .toString(),
                                                            width: width*0.2,
                                                            height: width*0.2,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        );
                                                      },
                                                    )
                                                        : ClipRRect(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(8.0),
                                                      child: Image.asset(
                                                        'assets/images/no_image.png',
                                                        width: width*0.2,
                                                        height: width*0.2,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    EditAdScreen(
                                                                      docId: ads[
                                                                      index]
                                                                          .docId,
                                                                      phoneNo:
                                                                      phoneNo,
                                                                    )),
                                                          );
                                                        },
                                                        child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                color: Colors.red,
                                                                border: Border.all(
                                                                    width: 2,
                                                                    color: Colors
                                                                        .white),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Icon(
                                                              Icons.edit,
                                                              color: Colors.white,
                                                              size: 18,
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            _firestore
                                                                .collection('ads')
                                                                .doc(ads[index]
                                                                .docId)
                                                                .delete();
                                                          },
                                                          child: Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  border: Border.all(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .white),
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: Icon(
                                                                Icons.delete,
                                                                color: Colors.white,
                                                                size: 18,
                                                              ))),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 20,
                                            ),
                                            Container(
                                              height: 1,
                                              color: Colors.grey.withOpacity(0.1),
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
