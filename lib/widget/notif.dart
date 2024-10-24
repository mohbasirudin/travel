import 'package:flutter/material.dart';

class Notif {
  static void snackbar(BuildContext context, {String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? "Failed!"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
