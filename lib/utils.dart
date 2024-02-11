import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclonepractice/common/widgets/darkmode_configuration/darkmode_config.dart';

// bool isDarkMode(BuildContext context) =>
//     MediaQuery.of(context).platformBrightness == Brightness.dark;

bool isDarkMode(BuildContext context) => darkModeConfig.value;

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        (error as FirebaseException).message ?? "Something went wrong",
      ),
      showCloseIcon: true,
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
      ),
    ),
  );
}
