import 'package:flutter/material.dart';

void goTo<T extends Widget>(BuildContext context, T route,
    {bool removeAllPreviousRoutes = false}) {
  if (removeAllPreviousRoutes) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => route),
      (route) => false,
    );
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (bulider) => route));
  }
}
