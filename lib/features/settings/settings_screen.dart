import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclonepractice/common/widgets/darkmode_configuration/darkmode_config.dart';
import 'package:tiktokclonepractice/common/widgets/video_configuration/video_config.dart';
import 'package:tiktokclonepractice/features/settings/settings_config.dart';
import 'package:tiktokclonepractice/features/videos/view_models/playback_config_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: Locale("es"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings",
          ),
        ),
        body: ListView(
          children: [
            ////////////////////////////////////////////////////////////////////
            ///1. InheritedWidget과 StatefulWidget 결합
            // SwitchListTile.adaptive(
            //   value: SettingsConfigData.of(context).clicked,
            //   onChanged: SettingsConfigData.of(context).onClicked,
            //   title: const Text(
            //     "auto Mute",
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            //   subtitle: const Text("subtitel"),
            // )
            ////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////
            ///2. ChangeNotifier(AnimatedBuilder)
            // AnimatedBuilder(
            //   animation: settingsConfig,
            //   builder: (context, child) => SwitchListTile.adaptive(
            //     value: settingsConfig.clicked,
            //     onChanged: settingsConfig.onClicked,
            //   ),
            // ),
            ////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////
            ///3.1 ValueNotifier 사용
            // SwitchListTile.adaptive(
            //   value: settingsConfig.value,
            //   onChanged: (value) {
            //     setState(() {
            //       settingsConfig.value = value;
            //     });
            //   },
            // ),
            //////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////
            ///3.2 ValueNotifier 사용(AnimatedBuilder)
            // AnimatedBuilder(
            //   animation: settingsConfig,
            //   builder: (context, child) => SwitchListTile.adaptive(
            //     value: settingsConfig.value,
            //     onChanged: (value) {
            //       settingsConfig.value = value;
            //     },
            //   ),
            // ),
            //////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////
            ///3.3 ValueNotifier 사용(ValueListenableBuilder)
            // ValueListenableBuilder(
            //   valueListenable: settingsConfig,
            //   builder: (context, value, child) => SwitchListTile.adaptive(
            //     value: settingsConfig.value,
            //     onChanged: (value) {
            //       settingsConfig.value = value;
            //     },
            //   ),
            // )
            //////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////
            ///4. ChangeNotifierProvider, MultiProvider 사용
            // SwitchListTile.adaptive(
            //   value: context.watch<SettingsConfig>().clicked,
            //   onChanged: context.read<SettingsConfig>().onClicked
            // ),
            //////////////////////////////////////////////////////////////////////////////////
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).muted,
              onChanged: (value) =>
                  ref.read(playbackConfigProvider.notifier).setMuted(value),
              title: const Text(
                "Auto Mute",
              ),
              subtitle: const Text(
                "Videos will be muted by default.",
              ),
            ),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).autoplay,
              onChanged: (value) =>
                  ref.read(playbackConfigProvider.notifier).setAutoplay(value),
              title: const Text(
                "Auto Play",
              ),
              subtitle: const Text(
                "Videos will be played by default.",
              ),
            ),
            /////////////////////////////////////////////////////
            ValueListenableBuilder(
              valueListenable: darkModeConfig,
              builder: (context, value, child) => SwitchListTile.adaptive(
                value: darkModeConfig.value,
                onChanged: (value) {
                  darkModeConfig.value = value;
                },
                title: const Text("Theme(dark/light)"),
                subtitle: const Text("Set dark/light mode"),
              ),
            ),
            ListTile(
              title: const Text("Log out (iOS)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text(
                      "Are you sure?",
                    ),
                    content: const Text(
                      "Plz dont go",
                    ),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDefaultAction: true,
                        child: const Text(
                          "No",
                        ),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (Android)"),
              textColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const FaIcon(
                      FontAwesomeIcons.skull,
                    ),
                    title: const Text(
                      "Are you sure?",
                    ),
                    content: const Text(
                      "Plz dont go",
                    ),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const FaIcon(
                          FontAwesomeIcons.car,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Yes"),
                      )
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (iOS / Bottom)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text(
                      "Are you sure?",
                    ),
                    content: const Text(
                      "Plz dont go",
                    ),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDefaultAction: true,
                        child: const Text("No"),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      )
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (Android / Bottom)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const FaIcon(
                      FontAwesomeIcons.skull,
                    ),
                    title: const Text(
                      "Are you sure?",
                    ),
                    content: const Text(
                      "Plz dont go",
                    ),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const FaIcon(
                          FontAwesomeIcons.car,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Yes"),
                      )
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                "Log out (Android / Bottom(showCupertinoModalPopup) / CupertinoActionSheet)",
              ),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text(
                      "Are you sure?",
                    ),
                    message: const Text(
                      "Please doooont go",
                    ),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Not log out",
                        ),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Yes plz",
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                  "Log out (Android / Top(showCupertinoDialog) / CupertinoActionSheet)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text(
                      "Are you sure?",
                    ),
                    message: const Text(
                      "Please doooont go",
                    ),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Not log out",
                        ),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Yes plz",
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            ////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////
            ///Date,Time, DateRange Picker
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );
                if (kDebugMode) {
                  print(date);
                }
      
                final time = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                if (kDebugMode) {
                  print(time);
                }
      
                
                final booking = await showDateRangePicker(
                  context: context,
                  builder: (context, child) {
                    return Theme(
                        data: darkModeConfig.value
                            ? ThemeData.dark()
                            : ThemeData.light(),
                        child: child!);
                  },
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );
                if (kDebugMode) {
                  print(booking);
                }
              },
              title: const Text(
                "What is your birthday?",
              ),
            ),
            ////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////
            ///About
            ListTile(
              onTap: () => showAboutDialog(
                context: context,
                applicationVersion: "1.0",
                applicationLegalese: "All rights reserved. Please don't copy me",
              ),
              title: const Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text("About this app...."),
            ),
            const AboutListTile(
              applicationName: "TikTokCloneFlutterStudy",
              applicationVersion: "1.0",
              applicationLegalese: "All rights reserved. Please don't copy me",
              applicationIcon: FaIcon(
                FontAwesomeIcons.tiktok,
              ),
            ),
            /////////////////////////////////////////////////////////////////////
          ],
        ),
      ),
    );
  }
}

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   bool _notifications = false;
//   bool _switch = false;
//   bool _checkBox = false;

//   void _onNotificationsChange(bool? newValue) {
//     if (newValue == null) return;
//     setState(() {
//       _notifications = newValue;
//     });
//   }

//   void _onSwitchChange(bool newValue) {
//     setState(() {
//       _switch = newValue;
//     });
//   }

//   void _onCheckBoxChange(bool? newValue) {
//     if (newValue == null) return;
//     setState(() {
//       _checkBox = newValue;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         ///////////////////////////////////////
//         SwitchListTile.adaptive(
//           value: _switch,
//           onChanged: _onSwitchChange,
//           title: const Text("SwitchListTileAdaptive"),
//           subtitle: const Text("Subtitle"),
//         ),
//         SwitchListTile(
//           value: _switch,
//           onChanged: _onSwitchChange,
//           title: const Text("SwitchListTile"),
//         ),
//         Switch.adaptive(value: _switch, onChanged: _onSwitchChange),
//         Switch(
//           value: _switch,
//           onChanged: _onSwitchChange,
//         ),
//         CupertinoSwitch(
//           value: _switch,
//           onChanged: _onSwitchChange,
//         ),
//         Checkbox(
//           value: _checkBox,
//           onChanged: _onCheckBoxChange,
//         ),
//         CheckboxListTile(
//           value: _notifications,
//           onChanged: _onNotificationsChange,
//           title: const Text(
//             "Enable notifications",
//           ),
//           // checkColor: Colors.red,
//           activeColor: Colors.black,
//         ),
//         ///////////////////////////////////////
//       ],
//     )

//         ///////////////////////////////////////////////////////
//         // body: Column(
//         //   children: [
//         //     CupertinoActivityIndicator(
//         //       radius: 40,
//         //     ),
//         //     CircularProgressIndicator(),
//         //     CircularProgressIndicator.adaptive(), //플랫폼에 따라 다른걸 보여줌
//         //   ],
//         // ),
//         ///////////////////////////////////////////////////////
//         ///////////////////////////////////////////////////////
//         //     body: ListWheelScrollView(
//         //   diameterRatio: 1.5,
//         //   offAxisFraction: 2,
//         //   useMagnifier: true,
//         //   magnification: 1.5,
//         //   itemExtent: 100,
//         //   onSelectedItemChanged: (value) {
//         //     print(value);
//         //   },
//         //   children: [
//         //     for (var x in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
//         //       Container(
//         //         alignment: Alignment.center,
//         //         color: Colors.green,
//         //         child: Text("$x"),
//         //       )
//         //   ],
//         // )
//         ///////////////////////////////////////////////////////
//         ///////////////////////////////////////////////////////////////
//         // Column(
//         //   children: [
//         //     CloseButton(
//         //       color: Colors.red,
//         //       onPressed: () {},
//         //     ),
//         //   ],
//         // ),
//         ///////////////////////////////////////////////////////////////
//         );
//   }
// }
