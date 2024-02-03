import 'package:flutter/material.dart';

class VideoConfig extends ChangeNotifier {
  bool isMuted = true;
  bool isAutoplay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}

/////////////////////////////////////////////////////////////
///3. ValueNotifier
// final videoConfig = ValueNotifier(false);
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///2. ChangeNotifier
// class VideoConfig extends ChangeNotifier {
//   bool autoMute = false;

//   void toggleAutoMute() {
//     autoMute = !autoMute;
//     notifyListeners();
//   }
// }

// final videoConfig = VideoConfig();
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///1. InheritedWidget과 StatefulWidget 결합
///=> main.dart 맨위에 VideoConfig 입력 필요
// class VideoConfigData extends InheritedWidget {
//   final bool autoMute;
//   final void Function() toggleMuted;

//   const VideoConfigData({
//     super.key,
//     required super.child,
//     required this.autoMute,
//     required this.toggleMuted,
//   });

//   static VideoConfigData of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
//   }

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return true;
//   }
// }
// class VideoConfig extends StatefulWidget {
//   final Widget child;
//   const VideoConfig({
//     super.key,
//     required this.child,
//   });

//   @override
//   State<StatefulWidget> createState() => _VideoConfigState();
// }

// class _VideoConfigState extends State<VideoConfig> {
//   bool autoMute = false;
//   void toggleMuted() {
//     setState(() {
//       autoMute = !autoMute;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VideoConfigData(
//       autoMute: autoMute,
//       toggleMuted: toggleMuted,
//       child: widget.child,
//     );
//   }
// }
/////////////////////////////////////////////////////////////