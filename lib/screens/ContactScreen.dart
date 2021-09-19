import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String name, phoneNum, message;
  bool done = false;
  bool error = false;
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
      body: LayoutBuilder(
        builder: (context, constraint) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
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
                          padding:
                              EdgeInsets.only(top: 30, left: 20, right: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            launch("mailto:info@nazrahsa.com");
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/gmail.png',
                                            height: 40,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            launch(
                                                "https://wa.me/9660509020021");
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/whatsapp (1).png',
                                            height: 40,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            launch(
                                                "https://www.instagram.com/nazrahsa/");
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/instagram.png',
                                            height: 40,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            launch(
                                                "https://twitter.com/NazrahSA");
                                          },
                                          child: Image.asset(
                                            'assets/images/icons/twitter.png',
                                            height: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text("تواصل معنا الان",
                                        style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          onChanged: (val) {
                                            name = val;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'أدخل اسمك',
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
                                              contentPadding:
                                                  EdgeInsets.only(right: 30),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blueGrey[50],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blueGrey[50],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          onChanged: (val) {
                                            phoneNum = val;
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: 'أدخل رقم هاتفك',
                                              fillColor: Colors.blueGrey[50],
                                              filled: true,
                                              //icon: Icon(Icons.phone_android),
                                              labelStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Bahij',
                                              ),
                                              hintStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Bahij',
                                              ),
                                              contentPadding:
                                                  EdgeInsets.only(right: 30),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blueGrey[50],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blueGrey[50],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          onChanged: (val) {
                                            message = val;
                                          },
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                              hintText: 'أستفسارك',
                                              fillColor: Colors.blueGrey[50],
                                              filled: true,
                                              //icon: Icon(Icons.contact_support),
                                              labelStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Bahij',
                                              ),
                                              hintStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Bahij',
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  right: 30,
                                                  left: 30,
                                                  top: 10,
                                                  bottom: 10),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blueGrey[50],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blueGrey[50],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
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
                                      child: ElevatedButton(
                                        child: Container(
                                          width: double.infinity,
                                          height: 50,
                                          child: Center(
                                              child: Text(
                                            "أرسل",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Bahij',
                                            ),
                                          )),
                                        ),
                                        onPressed: () async {
                                          if (name == null ||
                                              phoneNum == null ||
                                              message == null) {
                                            setState(() {
                                              error = true;
                                            });
                                          } else {
                                            final dateTime = DateTime.now();
                                            // String url =
                                            //     'https://docs.google.com/forms/u/0/d/e/1FAIpQLSeY_tZoeKHNaTr7pcGbD17gkJxxLI7JvK25z2gcaw8gx1B7lw/formResponse';
                                            // Map<String, String> headers = {
                                            //   "Content-Type":
                                            //       "application/x-www-form-urlencoded",
                                            // };
                                            // Map<String, String> requestBody =
                                            //     <String, String>{
                                            //   // After
                                            //   'entry.1196786683': name,
                                            //   'entry.591980753': phoneNum,
                                            //   'entry.846724140': message,
                                            // };
                                            // await http.post(Uri.parse(url),
                                            //     headers: headers, body: requestBody);
                                            _firestore
                                                .collection('inquires')
                                                .doc(dateTime.toString())
                                                .set({
                                              'name': name,
                                              'phone number': phoneNum,
                                              'message': message,
                                              'datetime': dateTime
                                            });
                                            setState(() {
                                              error = false;
                                              done = true;
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
                                    (error)
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                              "!برجاء ادخال جميع المعلومات المطلوبة",
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
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Text(
                                                  "!لقد تلقينا استفسارك",
                                                  style: TextStyle(
                                                      fontFamily: 'Bahij',
                                                      fontSize: 20,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.end,
                                                ),
                                              )
                                            : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
