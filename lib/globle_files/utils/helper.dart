import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


BoxDecoration roundAllCorners(double radius, {Color? bgColor}) {
  return BoxDecoration(
      color: bgColor, borderRadius: BorderRadius.all(Radius.circular(radius)));
}

void pushTo(BuildContext context, Widget destinationClass) {
  Navigator.of(context, rootNavigator: true).push(PageTransition(
    duration: const Duration(milliseconds: 120),
    reverseDuration: const Duration(milliseconds: 100),
    type: PageTransitionType.rightToLeft,
    child: destinationClass,
  ));
}



void errorLog(String tag, {int? statusCode = 0, String? message = ""}) {
  print('Error: $tag $statusCode $message');
}
