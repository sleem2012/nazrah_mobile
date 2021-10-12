import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nazarih_mobile/widgets/unorderedList.dart';

class MembershipScreen extends StatefulWidget {
  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  bool tap1 = false;
  bool tap2 = false;

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
                        Text(
                          "عضوية موقع نظره",
                          style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFF2980b9),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 4, color: Colors.white),
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
                                              image: AssetImage(
                                                  'assets/images/icons/feature.png'))),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "مزايا العضوية",
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        "العمولة مجانية على الاعلانات المعلن عنها خلال فترة الإشتراك بالاضافة لامكانية تكرار الاعلان اكثر من مره في نفس اليوم",
                                        style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFF2980b9),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 4, color: Colors.white),
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
                                              image: AssetImage(
                                                  'assets/images/icons/member.png'))),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "عن العضوية",
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        "هذة العضوية هي عضوية مدفوعة تناسب احتياج كل معلن يقوم بتسويق سلع كثيرة و مرتفعة الثمن مثل السيارات و العقارات",
                                        style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF2980b9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/icons/money.png'))),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "سعر العضوية",
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "اشتراك لمدة سنة بسعر 850 ريال",
                                  style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            width: double.infinity,
                            height: 650,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF2980b9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/icons/qualification.png'))),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "شروط العضوية",
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: UnorderedListMobile(
                                    [
                                    "عدم الاعلان للغير",
                                    "عدم تكرار الإعلان عن نفس السلعة أكثر من مره خلال يومين",
                                    "عدم التنازل عن العضوية لعضو آخر او بيع العضوية",
                                    "ذكر سعر السلعة",
                                    'الرد على رسائل اعضاء الموقع عبر الرسائل الخاصة',
                                    'الرد على استفسارات اعضاء الموقع عبر الردود'
                                  ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            width: double.infinity,
                            height: 1000,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF2980b9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/icons/debit-card.png'))),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "طرق الدفع",
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tap1 = !tap1;
                                        });
                                        FlutterClipboard.copy(
                                            'Al-Rajhi Bank\nAccount Number: 471000010006086055873\nIBAN Number: SA4980000471608016055873');
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          height: 350,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: (tap1)
                                                ? Colors.green
                                                : Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 2,
                                                  blurRadius: 10,
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  offset: Offset(0, 10))
                                            ],
                                          ),
                                          child: (tap1)
                                              ? Center(
                                                  child: Text(
                                                    "تم النسخ",
                                                    style: TextStyle(
                                                        fontFamily: 'Bahij',
                                                        fontSize: 50,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/payment_methods/1.png",
                                                          height: 100,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "مؤسسة موقع نظره للخدمات التسويقية",
                                                      style: TextStyle(
                                                          fontFamily: 'Bahij',
                                                          fontSize: 24,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Text(
                                                        "رقم الحساب",
                                                        style: TextStyle(
                                                            fontFamily: 'Bahij',
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Text(
                                                        "471000010006086055873",
                                                        style: TextStyle(
                                                            fontFamily: 'Bahij',
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xFF2980b9),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Text(
                                                        "رقم الايبان",
                                                        style: TextStyle(
                                                            fontFamily: 'Bahij',
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Text(
                                                        "SA4980000471608016055873",
                                                        style: TextStyle(
                                                            fontFamily: 'Bahij',
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xFF2980b9),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tap2 = !tap2;
                                        });
                                        FlutterClipboard.copy(
                                            'National Commercial Bank\nAccount Number: 18700000322007\nIBAN Number: SA10000018700000322007');
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          height: 350,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: (tap2)
                                                ? Colors.green
                                                : Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 2,
                                                  blurRadius: 10,
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  offset: Offset(0, 10))
                                            ],
                                          ),
                                          child: (tap2)
                                              ? Center(
                                                  child: Text(
                                                    "تم النسخ",
                                                    style: TextStyle(
                                                        fontFamily: 'Bahij',
                                                        fontSize: 50,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/payment_methods/ncb.png",
                                                          height: 100,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "مؤسسة موقع نظره للخدمات التسويقية",
                                                      style: TextStyle(
                                                          fontFamily: 'Bahij',
                                                          fontSize: 24,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Text(
                                                        "رقم الحساب",
                                                        style: TextStyle(
                                                            fontFamily: 'Bahij',
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Text(
                                                        "18700000322007",
                                                        style: TextStyle(
                                                            fontFamily: 'Bahij',
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xFF2980b9),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Text(
                                                        "رقم الايبان",
                                                        style: TextStyle(
                                                            fontFamily: 'Bahij',
                                                            fontSize: 30,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      child: Text(
                                                        "SA10000018700000322007",
                                                        style: TextStyle(
                                                            fontFamily: 'Bahij',
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xFF2980b9),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
