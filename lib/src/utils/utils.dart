import 'package:flutter/material.dart';

double screenWidth(context, {double dividedBy = 1}) {
  return MediaQuery.of(context).size.width / dividedBy;
}

double screenHeight(context, {double dividedBy = 1}) {
  return MediaQuery.of(context).size.height / dividedBy;
}

push(context, {required Widget route}) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => route));
}

pop(context) {
   return Navigator.pop(context);
}
