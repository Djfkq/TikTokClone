import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/routeurls.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';

enum Direction { left, right }

enum Screen { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.left;
  Screen _showingScreen = Screen.first;

  void _onPanUpdate(DragUpdateDetails detail) {
    if (detail.delta.dx > 0) {
      _direction = Direction.right;
    } else {
      _direction = Direction.left;
    }
  }

  void _onPanEnd(DragEndDetails detail) {
    if (_direction == Direction.left) {
      _showingScreen = Screen.second;
    } else {
      _showingScreen = Screen.first;
    }
    setState(() {});
  }

  void _onEnterAppTap() {
    context.go(RouteUrls.mainnavigationScreen);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size24,
            ),
            child: AnimatedCrossFade(
              crossFadeState: _showingScreen == Screen.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(
                milliseconds: 300,
              ),
              firstChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v36,
                  Text(
                    "Watch cool videos!",
                    style: TextStyle(
                      fontSize: Sizes.size32,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              secondChild: const Column(
                children: [
                  Gaps.v36,
                  Text(
                    "Follow the Rules",
                    style: TextStyle(
                      fontSize: Sizes.size32,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: AnimatedOpacity(
            opacity: _showingScreen == Screen.second ? 1 : 0,
            duration: const Duration(
              microseconds: 300,
            ),
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
              ),
              onPressed: _onEnterAppTap,
              color: Theme.of(context).primaryColor,
              child: const Text(
                "Enter the App",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///TabBarView 사용
// class _TutorialScreenState extends State<TutorialScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         body: SafeArea(
//           child: TabBarView(
//             children: [
//               Center(child: Text("1")),
//               Center(child: Text("2")),
//               Center(child: Text("3")),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TabPageSelector(
//                 color: Colors.white,
//                 selectedColor: Colors.black38,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
///TabBarView 사용