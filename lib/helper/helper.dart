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

String getDataFromDynamic(dynamic value, {bool isDate = false}) {
  try {
    if (value == null) return '';

    if (isDate) {
      return (value as String).split('T')[0];
    }

    if (value is int) return value.toString();

    if (value is double) return value.toStringAsFixed(2);

    return value;
  } catch (e) {
    return '';
  }
}
