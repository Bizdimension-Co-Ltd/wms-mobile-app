import 'package:flutter/material.dart';
import 'package:wms_mobile/core/enum/global.dart';

void goTo<T extends Widget>(BuildContext context, T route,
    {bool removeAllPreviousRoutes = false}) async {
  if (removeAllPreviousRoutes) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => route),
      (route) => false,
    );
  } else {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (bulider) => route));
    print(result);
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

String getItemTypeQueryString(ItemType type) {
  switch (type) {
    case ItemType.sale:
      return "SalesItem eq 'tYES'";
    case ItemType.purchase:
      return "PurchaseItem eq 'tYES'";
    case ItemType.inventory:
      return "InventoryItem eq 'tYES'";
    default:
      throw Exception('Invalid item type');
  }
}
