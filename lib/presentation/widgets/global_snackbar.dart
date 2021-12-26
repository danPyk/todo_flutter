import 'package:flutter/material.dart';

class GlobalSnackBar {
  final String message;

  const GlobalSnackBar({
    required this.message,
  });

   static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
      BuildContext context,
      String message,
      ) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
