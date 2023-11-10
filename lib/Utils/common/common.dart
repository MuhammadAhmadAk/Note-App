import 'package:flutter/material.dart';

void showMyshowSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 5), // Adjust the duration as needed
    ),
  );
}
