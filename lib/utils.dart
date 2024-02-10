import 'package:flutter/material.dart';
import 'package:tiktokclonepractice/common/widgets/darkmode_configuration/darkmode_config.dart';

// bool isDarkMode(BuildContext context) =>
//     MediaQuery.of(context).platformBrightness == Brightness.dark;

bool isDarkMode(BuildContext context) => darkModeConfig.value;
