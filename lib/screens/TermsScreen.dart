import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nazarih_mobile/widgets/unorderedList.dart';

class TermsScreen extends StatefulWidget {
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
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
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "مقدمة",
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
                                "تم إنشاء الاتفاقية بناء على نظام التعاملات الإلكترونية تخضع البنود والشروط والأحكام والمنازعات القانونية للقوانين والتشريعات والأنظمة المعمول بها في المملكة العربية السعودية",
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
                                "هام! هذه اتفاقية قانونية ملزمة يُرجى قراءة شروط وأحكام الاستخدام بعناية قبل استخدام هذا الموقع والموافقة عليها",
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
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 15),
                              //   child: UnorderedList([
                              //     "مؤسسة موقع نظره للخدمات التسويقية منصة الكترونية سعودية 100% تمكن البائع من فتح حساب وعرض خدماته للمستهلك تحت مسؤوليته مقابل عمولة وقدرها: 0,5% من قيمة الإعلان ما بعد البيع تحول الى حسابات المؤسسة الموجودة في صفحة حساب العمولة او صفحة العضوية",
                              //     "الاشتراك في العضوية السنوية وقدرها: 850 ريال سعودي تحول الى حساب المؤسسة في صفحة حساب العمولة او صفحة العضوية وبموجب هذه العضوية يمكن للمعلن استخدام الموقع لمدة سنه ويمكنه الإعلان من غير دفع أي عمولة خلال مدة الاشتراك"
                              //   ]),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: UnorderedList([
                                  "مؤسسة موقع نظره للخدمات التسويقية منصة الكترونية سعودية 100% تمكن البائع من فتح حساب وعرض خدماته للمستهلك تحت مسؤوليته",
                                  // "الاشتراك في العضوية السنوية وقدرها: 850 ريال سعودي تحول الى حساب المؤسسة في صفحة حساب العمولة او صفحة العضوية وبموجب هذه العضوية يمكن للمعلن استخدام الموقع لمدة سنه ويمكنه الإعلان من غير دفع أي عمولة خلال مدة الاشتراك"
                                ]),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "شروط الاستخدام",
                                style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 30,
                                    color: Color(0xFF2980b9),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: UnorderedList([
                                  "عدم الإعلان لجميع السلع والخدمات الممنوعة بحسب قوانين المملكة العربية السعودية",
                                  "عدم الإعلان عن منتجات التبغ والدخان ومشتقاتها",
                                  "عدم التعرض لاي معلن بالإساءة في التعليقات او التعليق في غير موضوع الإعلان او الازعاج او السب والشتم او العنصرية",
                                  "عدم الإعلان عن الفوركس والأسهم والتسويق الشبكي والتقسيط والمنتجات البنكية وإدارة المحافظ",
                                  "عدم الإعلان عن المنتجات الطبية والصحية والأدوية والاعشاب الغير مرخصة ويجب ان تكون مرخصة من الجهات المختصة",
                                  "عدم الإعلان عن المنتجات الجنسية بكافة أنواعها",
                                  "عدم الإعلان عن الأسلحة بجميع أنواعها وأجهزة الليزر والتنصت والتجسس",
                                  "المصداقية في الإعلان وصحة جميع المعلومات المذكورة للسلعة وشرحها بالكامل في الإعلان",
                                  "الإعلان يجب ان يكون في القسم الصحيح",
                                  "عدم الإعلان عن بيع الاقامات والاتجار بالبشر",
                                  "يجب عند التسجيل ان يكون الاسم لائق وعدم استخدام الأسماء الغير لائقة",
                                  "يحق لنظره حذف الإعلانات المسيئة والغير لائقة او غير مكتملة المعلومات",
                                  "الإعلانات والتعليقات تخص من كتبها ونشرها في نظره ويكون مسؤول عنها المسؤولية الكاملة",
                                  "العمليات التجارية والتعاملات المالية تخص الطرفين البائع والمشتري وهم المسؤولين عنها",
                                  "يجب من التأكد بين البائع والمشتري ان يكون التعامل وجها لوجه وان لا يتم تحويل أي مبلغ مالي الا بعد التأكد",
                                  "يحق لنظره تغيير اتفاقية الاستخدام متى رأت ذلك",
                                  "يجب على العضو الحفاظ على حسابه وعضويته وعدم افشاء اي معلومات شخصية",
                                  "أي إساءة ستتعرض للمساءلة القانونية امام الجهات المختصة في المملكة العربية السعودية"
                                ]),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
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
