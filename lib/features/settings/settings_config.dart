import 'package:flutter/material.dart';

class SettingsConfig extends ChangeNotifier {
  bool clicked = false;

  void onClicked(bool value) {
    clicked = !clicked;
    notifyListeners();
  }
}
///////////////////////////////////////////////////////////////////////////////
///3. ValueNotifier
// final settingsConfig = ValueNotifier(false);
///////////////////////////////////////////////////////////////////////////////
///
///////////////////////////////////////////////////////////////////////////////
///2. ChangeNotifier(AnimatedBuilder)
// class SettingsConfig extends ChangeNotifier {
//   bool clicked = false;

//   void onClicked(bool value) {
//     clicked = !clicked;
//     notifyListeners();
//   }
// }

// final settingsConfig = SettingsConfig();
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
///1. InheritedWidget과 StatefulWidget 결합
// class SettingsConfigData extends InheritedWidget {
//   final bool clicked;
//   final void Function(bool) onClicked;
//   const SettingsConfigData({
//     super.key,
//     required this.clicked,
//     required this.onClicked,
//     required super.child,
//   });

//   static SettingsConfigData of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<SettingsConfigData>()!;
//   }

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return true;
//   }
// }

// class SettingsConfig extends StatefulWidget {
//   final Widget child;
//   const SettingsConfig({
//     super.key,
//     required this.child,
//   });

//   @override
//   State<SettingsConfig> createState() => _SettingsConfigState();
// }

// class _SettingsConfigState extends State<SettingsConfig> {
//   bool _clicked = false;
//   void _onClicked(bool value) {
//     setState(() {
//       _clicked = !_clicked;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SettingsConfigData(
//       clicked: _clicked,
//       onClicked: _onClicked,
//       child: widget.child,
//     );
//   }
// }
///////////////////////////////////////////////////////////////////////////////