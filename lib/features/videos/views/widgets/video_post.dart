import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/videos/views/widgets/video_button.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;
  bool _isPaused = true;
  bool _seeMore = false;
  bool _volumeOff = false;

  final Duration _animationDuration = const Duration(milliseconds: 300);
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    lowerBound: 1.0,
    upperBound: 1.5,
    value: 1.5,
    duration: _animationDuration,
  );

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/test_1.mp4");
    await _videoPlayerController.initialize();
    // await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);
    // await _videoPlayerController.play();
    setState(() {});
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        widget.onVideoFinished();
      }
    }
  }

  void _onSeeMoreTap() {
    setState(() {
      _seeMore = !_seeMore;
    });
  }

  void _onTogglePause() async {
    if (_videoPlayerController.value.isPlaying) {
      await _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      await _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onVolumeTap() async {
    _volumeOff = !_volumeOff;
    if (_volumeOff) {
      await _videoPlayerController.setVolume(0);
    } else {
      await _videoPlayerController.setVolume(1);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(
                  color: Colors.black,
                ),
        ),
        Positioned.fill(
          child: GestureDetector(
            onTap: _onTogglePause,
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    child: child,
                  );
                },
                child: AnimatedOpacity(
                  opacity: _isPaused ? 1 : 0,
                  duration: _animationDuration,
                  child: const FaIcon(
                    FontAwesomeIcons.play,
                    size: Sizes.size32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "@니꼬",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v7,
              const Text(
                "This is my house in Thailand!!!",
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.v7,
              Row(
                children: [
                  _seeMore
                      ? const Text(
                          "#TikTokClone, #Flutter, #Study, #Fighting, #Fun")
                      : const Text("#TikTokClone, #Flutter, #Study"),
                  Gaps.h5,
                  GestureDetector(
                    onTap: _onSeeMoreTap,
                    child: _seeMore
                        ? const Text("... Close")
                        : const Text("...See more"),
                  )
                ],
              )
            ],
          ),
        ),
        const Positioned(
          bottom: 20,
          right: 10,
          child: Column(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/87645151?v=4"),
                child: Text("니꼬"),
              ),
              Gaps.v24,
              VideoButton(
                icon: FontAwesomeIcons.solidHeart,
                text: "2.9M",
              ),
              Gaps.v24,
              VideoButton(
                icon: FontAwesomeIcons.solidComment,
                text: "33K",
              ),
              Gaps.v24,
              VideoButton(
                icon: FontAwesomeIcons.share,
                text: "Share",
              ),
            ],
          ),
        ),
        Positioned(
          top: 150,
          right: 10,
          child: GestureDetector(
            onTap: _onVolumeTap,
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: AnimatedCrossFade(
                duration: const Duration(
                  milliseconds: 200,
                ),
                firstChild: const FaIcon(
                  FontAwesomeIcons.volumeOff,
                  color: Colors.white,
                  size: Sizes.size20,
                ),
                secondChild: const FaIcon(
                  FontAwesomeIcons.volumeHigh,
                  color: Colors.white,
                  size: Sizes.size20,
                ),
                crossFadeState: _volumeOff
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ),
          ),
        )
      ],
    );
  }
}
