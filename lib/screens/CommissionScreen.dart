import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nazarih_mobile/widgets/unorderedList.dart';

class CommissionScreen extends StatefulWidget {
  @override
  _CommissionScreenState createState() => _CommissionScreenState();
}

class _CommissionScreenState extends State<CommissionScreen> {
  double commission = 0;
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
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              Text(
                                "بيع منتجك بعمولة 0.5% فقط في نظره",
                                style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "العمولة أمانة في ذمة المعلن سواء تمت المبايعة عن طريق الموقع أو بسببه، وموضحة قيمتها بما يلي حساب العمولة",
                                style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 500,
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
                                      height: 120,
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
                                                  'assets/images/icons/box.png'))),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "عمولة السلع و الخدمات الأخرى",
                                      textAlign: TextAlign.center,
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
                                      child: UnorderedListMobile([
                                        "بيع سلعة:0.5% من قيمة السلعة المباعة",
                                        "تأجير سلع(معدات وغيرها):0.5% من قيمة مبلغ الإيجار",
                                        "تقديم خدمات: 0.5% من قيمة الخدمة المقدمة",
                                        "طلب سلعة أو خدمة: 0.5% من قيمة المبايعة"
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 450,
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
                                                  'assets/images/icons/apartment_.png'))),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "عمولة العقارات",
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
                                      child: UnorderedListMobile([
                                        "بيع عقار عن طريق المالك: 0.5% من قيمة العقار",
                                        "بيع عقار عن طريق وسيط: يعتبر الموقع شريك في الوساطة",
                                        "تأجير عقارات: 0.5% من قيمة عقد الإيجار الجديد فقط",
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 450,
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
                                                  'assets/images/icons/car_.png'))),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "عمولة السيارات",
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
                                      child: UnorderedListMobile([
                                        "بيع السيارات:0.5% من قيمة السيارة",
                                        "سيارات للتنازل:0.5% من قيمة التنازل إذا كان التنازل بمقابل",
                                        "تبادل السيارات:0.5% من قيمة المبادلة إذا كان هناك مقابل للمبادلة",
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                height: 400,
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
                                                  'assets/images/icons/calculator.png'))),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "حساب العمولة",
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          onChanged: (val) {
                                            setState(() {
                                              commission =
                                                  double.parse(val) * 0.005;
                                            });
                                          },
                                          textAlign: TextAlign.right,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              fontFamily: "Arabic Nunbers"),
                                          decoration: InputDecoration(
                                              hintText: 'ادخل سعر البيع',
                                              fillColor: Colors.blueGrey[50],
                                              filled: true,
                                              labelStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Bahij',
                                              ),
                                              hintStyle: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Bahij',
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  right: 30, left: 30),
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
                                      height: 20,
                                    ),
                                    Text(
                                      "العمولة المستحقة : $commission ريال",
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
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
