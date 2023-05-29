import 'package:flutter/material.dart';

const appColor = Color(0xFF20a0d8);
const appColor2 = Color(0xFF1fa6d3);
const linkedinColor = Color(0xFF0077B5);

const backgroundColor = Color.fromARGB(255, 243, 243, 243);

centerHeading(val) {
  return Text(
    val,
    textAlign: TextAlign.center,
    style: const TextStyle(
        height: 1.4,
        fontSize: 24,
        fontFamily: 'medium',
        color: Colors.black,
        letterSpacing: 1),
  );
}

centerText(val) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Text(
      val,
      textAlign: TextAlign.center,
      style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.black),
    ),
  );
}

btnText(val) {
  return Text(
    val.toUpperCase(),
    style: const TextStyle(
        fontSize: 12, fontFamily: 'medium', color: Colors.white),
  );
}

smallText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 12, color: Colors.black),
  );
}

blackHeading(val) {
  return Text(
    val,
    style: const TextStyle(
        fontSize: 18, fontFamily: 'medium', color: Colors.black),
  );
}

blackHeadingSmall(val) {
  return Container(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      val,
      style: const TextStyle(
          fontSize: 16, fontFamily: 'medium', color: Colors.black),
    ),
  );
}

boldText(val) {
  return Text(
    val,
    style: const TextStyle(
        fontSize: 14, fontFamily: 'medium', color: Colors.black),
  );
}

reviewText(val) {
  return Container(
    padding: const EdgeInsets.all(8),
    child: Text(
      val,
      style: const TextStyle(
          fontSize: 14, fontFamily: 'medium', color: Colors.black),
    ),
  );
}

blackText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 14, color: Colors.black),
  );
}

greyText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 14, color: Colors.black54),
  );
}

greyTextSmall(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.bold),
  );
}

appcolorText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 14, color: appColor, fontFamily: 'medium'),
  );
}

textField(hint, icn) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextField(
      decoration: InputDecoration(
        labelText: hint,
        suffixIcon: Icon(
          icn,
          size: 18,
          color: Colors.black12,
        ),
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 12),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appColor),
        ),
      ),
    ),
  );
}

textFieldNo(hint) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextField(
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 13),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appColor),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
      ),
    ),
  );
}
