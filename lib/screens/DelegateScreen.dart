import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nazarih_mobile/widgets/unorderedList.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

import '../services/firebase_storage.dart';

class DelegateScreen extends StatefulWidget {
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<DelegateScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final dateTime = DateTime.now();
  bool wait = false;
  String photoBool = 'false';
  bool writing = false;
  bool writing2 = false;
  bool error1 = false;
  bool done = false;
  Stream<DocumentSnapshot> loadImages(DateTime dateTime) {
    return _firestore
        .collection('delegate_temp')
        .doc(dateTime.toString())
        .snapshots();
  }

  String name, id, country, phoneNo, email;

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
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "???????? ?????????? ?????????? ???????? ??????????????",
                          style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 30,
                              color: Color(0xFF2980b9),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "?????????? ???????? ???? ???????? ???????????? ???????? ???????????????????? ???????????? ???????????????? ?????????? ???? ?????????? ???????????? ?????????? ?????? ???????????? ?????????????????? ???? ???????????? ???????????????? ?????? ?????????????? ?????????????? ???????????????? ?????? ???????????????? ?????? ???? ???????????? ???????????????? ?????????????? ?????????? ???? ?????????? ???????????? ???????? ???????????? ?????????????? ?????? ???? ?????????? ???????????????? ?????????????????? ???????????? ?????????????? ???????????? ?????????? ?????????????? ???????????????? ????????????????????  ???????????? ?????????????? ?????????????????? ???????????? ?????????????? ???????????? ?????????? ???? ?????????????? ?????????? ???????? ?????????? ?????????????????? ??????????",
                          style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "???????? ???????? ???????????? ???????????? ???????? ?????????????? ???? ???????????? ???????????? ???????? ?????????????? ???? ?????????????? ???????????????? ???? ???????????????? ???? ?????????? ???????? ???????? ?????????? ?????????????? ?????????? ?????????????? ???????????????? ???? ?????????????? ???????? ???????????? ???? ?????????? ?????? ?????????? ???????? ???????????? ???? ?????????? ?????? ???????? ?????? ??????????:(50 ????????)",
                                style: TextStyle(
                                  fontFamily: 'Bahij',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Text(
                              "????????",
                              style: TextStyle(
                                fontFamily: 'Bahij',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "????????:???????????? ?????? ?????? ???????? ???????????? ???? ???????? ???? ?????????? ???????? ?????????????? ?????????????? ???????? ?????? ???? ?????????????? ?????????????? ???????????? ???????? ???????????? ???? ???????????? ???? ???????? ?????????? ???????????????? ????????????",
                          style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: UnorderedList([
                            "<????????:(850????????) ???????? ???????????????? ?????????????? ???? ?????????????? <???? ???????? ?????? ?????????? ?????????????? ?????????? ????????????????",
                            "?????? ?????????? ?????????? ???????????? ?????????????? ???????? 24 ?????? 48 ???????? ???? ?????? ????????",
                            "???????? ???????? ???????? ?????????????? ???????? ???????? ???????????????? ???? ???????????? ???? ?????????????? ?????? ?????? ?????????? ?????????? ???? ???????????? ????????????????",
                            "???????????? ?????? ?????????? ???? ???????????? ???? ?????????????? ???? ???????? ???????????????? (?????????? ?????? ??????????:50 ???????? ???????? ????????????)",
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "????????????) ?????????????? ???? ?????????? ???? ???????? ?????? ?????? ?????????????? ?????? ???????????????? ???????????????? ???? ?????????????? ??????????????)",
                          style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "???????? ???? ?????? ?????????? ?????????? ???? ???????? ???????????? (5 ??????????:250 ???????? ??????????)???? (10 ??????????:500 ???????? ??????????)???? (20 ???????? 1000 ???????? ??????????) ???? ???? ?????? ???????? ?????? ???? ????????????:50 ???????? ?????????? ???? ???????? ?????????????? ???? ?????????????? ???????????? ?????????? ??????????????????",
                                style: TextStyle(
                                  fontFamily: 'Bahij',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Text(
                              "????????",
                              style: TextStyle(
                                fontFamily: 'Bahij',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "?????? ?????????????? ???????????? ???????????????? ???? ???????? ???????????? ????",
                          style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "???????????????? ???? ( ?????????? ???? ?????????????? ???? ???????????? ) ???????????? ?????????? ???????????????????? ???????? ?????? ?????? ???????????? ?????????????? ???? ???????????? ???????? ?????????? ???? ?????? ?????????? ?? ?????????? ???????? ???????????? ???? ?????????? ????????????, ???????????? ???? ?????????????? ???? ?????????? ?????????????? ?????????????? ?????????? ???????????? ???????????? ?????????? ?????????????? ?????????????? ???? ?????? ???????????? ???????????? ?????????? ???????????? ?????????? ??????????????",
                          style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "???????? ???????? ???????????? ?????? ",
                          style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "?????????? ??????????",
                              style: TextStyle(
                                fontFamily: 'Bahij',
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: double.infinity,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  onChanged: (val) {
                                    name = val;
                                  },
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: '??????????',
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
                                      contentPadding:
                                          EdgeInsets.only(right: 30, left: 30),
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
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: double.infinity,
                              child: Directionality(
                                textDirection: (writing == false)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: TextField(
                                  onChanged: (val) {
                                    if (val != '') {
                                      setState(() {
                                        writing = true;
                                      });
                                    } else {
                                      setState(() {
                                        writing = false;
                                      });
                                    }
                                    id = val;
                                  },
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                  ),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: '?????? ???????????? - ??????????????',
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
                                      contentPadding:
                                          EdgeInsets.only(right: 30, left: 30),
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
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: double.infinity,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  onChanged: (val) {
                                    country = val;
                                  },
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: '??????????????',
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
                                      contentPadding:
                                          EdgeInsets.only(right: 30, left: 30),
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
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: double.infinity,
                              child: Directionality(
                                textDirection: (writing2 == false)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: TextField(
                                  onChanged: (val) {
                                    if (val != '') {
                                      setState(() {
                                        writing2 = true;
                                      });
                                    } else {
                                      setState(() {
                                        writing2 = false;
                                      });
                                    }
                                    phoneNo = val;
                                  },
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                  ),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: '?????? ????????????',
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
                                      contentPadding:
                                          EdgeInsets.only(right: 30, left: 30),
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
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: double.infinity,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  onChanged: (val) {
                                    email = val;
                                  },
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: '???????????? ???????????????????? (??????????????)',
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
                                      contentPadding:
                                          EdgeInsets.only(right: 30, left: 30),
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
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4, color: Color(0xFF2980b9)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: (wait)
                                  ? StreamBuilder<DocumentSnapshot>(
                                      stream: loadImages(dateTime),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data.data() != null) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }

                                          int photoLimit = snapshot.data
                                              .data()['photo_limit'];

                                          photoBool = "true";

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: GestureDetector(
                                              onTap: () async {
                                                await _firestore
                                                    .collection('delegate_temp')
                                                    .doc(dateTime.toString())
                                                    .delete();
                                                uploadDelegateImages(dateTime);
                                              },
                                              child: GridView.builder(
                                                itemCount: photoLimit,
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 200,
                                                        mainAxisExtent: 290,
                                                        childAspectRatio: 3 / 2,
                                                        crossAxisSpacing: 20,
                                                        mainAxisSpacing: 20),
                                                itemBuilder: (context, index) {
                                                  return StreamBuilder<String>(
                                                    stream: downloadUrl(snapshot
                                                                .data
                                                                .data()[
                                                            'photo_url $index'])
                                                        .asStream(),
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
                                                      return Image.network(
                                                        snapshot.data
                                                            .toString(),
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          wait = true;
                                        });
                                        uploadDelegateImages(dateTime);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera_alt,
                                            color: Colors.black,
                                            size: 50,
                                          ),
                                          Text(
                                            '???????? ?????????? ???????? ?????????????????? ?????????????? ?????????????? ?????????????????? ?????? ??????',
                                            style: TextStyle(
                                                fontFamily: 'Bahij',
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '?????????? ???????? ???????????? - ??????????????',
                                            style: TextStyle(
                                                fontFamily: 'Bahij',
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '?????????? ???????? ???????????? ???????????? ??????????????',
                                            style: TextStyle(
                                                fontFamily: 'Bahij',
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                            (wait)
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                        '???? ?????? ???????? ?????????????? ?????????? ???????????????? ???????? ?????????? ?????? ????????',
                                        style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize: 20,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  )
                                : Container(),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
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
                                    "??????????",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Bahij',
                                    ),
                                  )),
                                ),
                                onPressed: () async {
                                  if (photoBool == 'true' &&
                                      phoneNo != null &&
                                      id != null &&
                                      name != null) {
                                    List imagePaths = [];
                                    int imageCount;
                                    await _firestore
                                        .collection('delegate_temp')
                                        .doc(dateTime.toString())
                                        .get()
                                        .then((DocumentSnapshot
                                                documentSnapshot) =>
                                            {
                                              imageCount = documentSnapshot
                                                  .data()['photo_limit'],
                                              for (var i = 0;
                                                  i < imageCount;
                                                  i++)
                                                {
                                                  imagePaths.add(
                                                      documentSnapshot.data()[
                                                          'photo_url $i'])
                                                }
                                            });
                                    _firestore
                                        .collection('delegate')
                                        .doc(dateTime.toString())
                                        .set({
                                      'name': name,
                                      'phone number': phoneNo,
                                      'id': id,
                                      'imageCount': imageCount,
                                      'email': email,
                                      'country': country,
                                      'datetime': dateTime
                                    });
                                    for (var i = 0;
                                        i < imagePaths.length;
                                        i++) {
                                      await _firestore
                                          .collection('delegate')
                                          .doc(dateTime.toString())
                                          .update(
                                              {'photo_url $i': imagePaths[i]});
                                    }
                                    await _firestore
                                        .collection('delegate_temp')
                                        .doc(dateTime.toString())
                                        .delete();
                                    setState(() {
                                      error1 = false;
                                      done = true;
                                    });
                                  } else {
                                    setState(() {
                                      error1 = true;
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF2980b9),
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                            (error1)
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      "!?????????? ?????????? ???????? ?????????????????? ????????????????",
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 20,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                    ),
                                  )
                                : (done)
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          "!?????? ???????????? ????????",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 20,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    : Container(),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
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
