import 'package:flutter/material.dart';
import 'package:tiktokclonepractice/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final int _itemCount = 4;
  final PageController _pageController = PageController();

  Future<void> _onRefresh() async {
    return Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
  }

  void _onPageChanged(int page) {
    print(page);
  }

  void _onVideoFinished() {
    return;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      displacement: 50,
      edgeOffset: 20,
      color: Theme.of(context).primaryColor,
      strokeWidth: 2,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _itemCount,
        itemBuilder: (context, index) => VideoPost(
          index: index,
          onVideoFinished: _onVideoFinished,
        ),
        onPageChanged: _onPageChanged,
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////
// class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return PageView(
//       scrollDirection: Axis.vertical,
//       children: [
//         Container(
//           color: Colors.blue,
//         ),
//         Container(
//           color: Colors.teal,
//         ),
//         Container(
//           color: Colors.yellow,
//         ),
//         Container(
//           color: Colors.pink,
//         ),
//       ],
//     );
//   }
// }
///////////////////////////////////////////////////////////////////////////