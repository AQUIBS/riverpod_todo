import 'package:flutter/material.dart';

ScaffoldFeatureController showSnackbar(
    {required BuildContext context, required SnackBar snackBar}) {
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

final successSb = SnackBar(
    backgroundColor: Colors.blueGrey.shade400,
    content: const Text(
      "Todo added Successfully",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
    ));

final failureSb = SnackBar(
    backgroundColor: Colors.blueGrey.shade400,
    content: const Text(
      "Error in adding Todo",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
    ));
