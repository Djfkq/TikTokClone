import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokclonepractice/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktokclonepractice/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/routeurls.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/discover/discover_screen.dart';
import 'package:tiktokclonepractice/features/inbox/inbox_screen.dart';
import 'package:tiktokclonepractice/features/users/user_profile_screen.dart';
import 'package:tiktokclonepractice/features/videos/views/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  // final List<String> tabs = [
  //   "home",
  //   "discover",
  //   "xxx",
  //   "inbox",
  //   "profile",
  // ];
  int _selectedIndex = 0;

  // final screens = [
  //   StfScreen(
  //     key: GlobalKey(),
  //   ),
  //   StfScreen(
  //     key: GlobalKey(),
  //   ),
  //   StfScreen(
  //     key: GlobalKey(),
  //   ),
  //   StfScreen(
  //     key: GlobalKey(),
  //   ),
  //   StfScreen(
  //     key: GlobalKey(),
  //   ),
  // ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    ///////////////////////////////////////////
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => Scaffold(
    //       appBar: AppBar(
    //         title: const Text("Record Video"),
    //       ),
    //     ),
    //     // fullscreenDialog: true,
    //   ),
    // );
    ////////////////////////////////////////////
    context.pushNamed(RouteNames.videorecordingScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : null,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InBoxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: "니꼬",
              tab: "",
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavTab(
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                isSelected: _selectedIndex == 0,
                text: "Home",
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(0),
              ),
              NavTab(
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                isSelected: _selectedIndex == 1,
                text: "Discover",
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(1),
              ),
              Gaps.h24,
              GestureDetector(
                  onTap: _onPostVideoButtonTap,
                  child: PostVideoButton(inverted: _selectedIndex != 0)),
              Gaps.h24,
              NavTab(
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                isSelected: _selectedIndex == 3,
                text: "Inbox",
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(3),
              ),
              NavTab(
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                isSelected: _selectedIndex == 4,
                text: "Profile",
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTabScaffold(
//       tabBar: CupertinoTabBar(
//         activeColor: Theme.of(context).primaryColor,
//         items: const [
//           BottomNavigationBarItem(
//             icon: FaIcon(FontAwesomeIcons.house),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
//             label: "Search",
//           ),
//         ],
//       ),
//       tabBuilder: (context, index) => screens[index],
//     );
//   }
// }
////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: screens[_selectedIndex],
//         bottomNavigationBar: NavigationBar(
//           selectedIndex: _selectedIndex,
//           onDestinationSelected: _onTap,
//           labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
//           destinations: const [
//             NavigationDestination(
//               icon: FaIcon(
//                 FontAwesomeIcons.house,
//               ),
//               label: "Home",
//             ),
//             NavigationDestination(
//               icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
//               label: "Search",
//             )
//           ],
//         ));
//   }
// }
////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         // selectedItemColor: Colors.red,
//         // unselectedItemColor: Colors.green,
//         // backgroundColor: Colors.yellow,
//         type: BottomNavigationBarType.shifting,
//         items: const [
//           BottomNavigationBarItem(
//             icon: FaIcon(
//               FontAwesomeIcons.house,
//             ),
//             label: "Home",
//             tooltip: "What are you?!",
//             backgroundColor: Colors.amber,
//           ),
//           BottomNavigationBarItem(
//             icon: FaIcon(
//               FontAwesomeIcons.magnifyingGlass,
//             ),
//             label: "Search",
//             tooltip: "Search tip",
//             backgroundColor: Colors.blue,
//           ),
//           // BottomNavigationBarItem(
//           //   icon: FaIcon(
//           //     FontAwesomeIcons.house,
//           //   ),
//           //   label: "Home",
//           //   tooltip: "What are you?!",
//           //   backgroundColor: Colors.pink,
//           // ),
//           // BottomNavigationBarItem(
//           //   icon: FaIcon(
//           //     FontAwesomeIcons.magnifyingGlass,
//           //   ),
//           //   label: "Search",
//           //   tooltip: "Search tip",
//           //   backgroundColor: Colors.yellow,
//           // ),
//           // BottomNavigationBarItem(
//           //   icon: FaIcon(
//           //     FontAwesomeIcons.house,
//           //   ),
//           //   label: "Home",
//           //   tooltip: "What are you?!",
//           //   backgroundColor: Colors.teal,
//           // ),
//         ],
//         onTap: _onTap,
//       ),
//     );
//   }
// }
/////////////////////////////////////////////////////////////////