import 'package:flutter/material.dart';

Widget textPhotoCategories(String text, String imagePath, Function ontap) {
  return TextButton(
      onPressed: ontap,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF2980b9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              text,
              style: TextStyle(
                  fontFamily: 'Bahij',
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ));
}

Widget textCategories(String text, Function ontap, Color color) {
  return TextButton(
      onPressed: ontap,
      style: TextButton.styleFrom(
        backgroundColor: color,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Bahij',
              fontSize: 20,
              color: (color == Color(0xFF2980b9)) ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ));
}

Widget textCategories2(String text, Function ontap, Color color) {
  return TextButton(
      onPressed: ontap,
      style: TextButton.styleFrom(
        backgroundColor: color,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Arabic Nunbers',
              fontSize: 15,
              color: (color == Colors.white)
                  ? Color(0xFF2980b9)
                  : (color == Color(0xFFf2f4fa))
                      ? Colors.black
                      : Colors.white,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ));
}

Widget photoCategories(String imagePath, Function ontap) {
  return TextButton(
      onPressed: ontap,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF2980b9),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          width: 100,
          height: 85,
        ),
      ));
}
