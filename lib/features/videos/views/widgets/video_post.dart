import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktokclonepractice/features/videos/views/widgets/video_button.dart';
import 'package:tiktokclonepractice/features/videos/views/widgets/video_comments.dart';
import 'package:tiktokclonepractice/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  final Duration _animationDuration = const Duration(milliseconds: 200);
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    lowerBound: 1.0,
    upperBound: 1.5,
    value: 1.5,
    duration: _animationDuration,
  );
  late final VideoPlayerController _videoPlayerController;

  bool _isPaused = true;
  bool _seeMore = false;
  bool _volumeOff = false;

  /////////////////////////////////////////////////
  /// ChangeNotifier 사용시
  // bool _autoMute = videoConfig.autoMute;
  /////////////////////////////////////////////////
  /// ValueNotifier 사용시
  // bool _autoMute = videoConfig.value;
  /////////////////////////////////////////////////

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/test_1.mp4");
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);
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

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction != 1 && _videoPlayerController.value.isPlaying) {
      _onTogglePause();
    } else if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !_isPaused) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
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

  void _onSeeMoreTap() {
    setState(() {
      _seeMore = !_seeMore;
    });
  }

  void _onCommentsTap() async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const VideoComments(),
    );
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
  void initState() {
    super.initState();
    _initVideoPlayer();

    /////////////////////////////////////////
    ///ChangeNotifier ->addListner 적용
    // videoConfig.addListener(
    //   () {
    //     setState(
    //       () {
    //         _autoMute = videoConfig.autoMute;
    //       },
    //     );
    //   },
    // );
    ////////////////////////////////////////////
    ///
    ////////////////////////////////////////////
    ///ValueNotifier 적용
    // videoConfig.addListener(
    //   () {
    //     setState(
    //       () {
    //         _autoMute = videoConfig.value;
    //       },
    //     );
    //   },
    // );
    ////////////////////////////////////////////
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    ////////////////////////////////////////////////////
    ///Riverpod
    final muted = ref.read(playbackConfigProvider).muted;
    ref.read(playbackConfigProvider.notifier).setMuted(!muted);
    if (muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
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

          ///6. RiverPod
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
              icon: FaIcon(
                ref.watch(playbackConfigProvider).muted
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
              ),
              onPressed: _onPlaybackConfigChanged,
              color: Colors.white,
            ),
          ),
          ////////////////////////////////////////
          ///5. MVVM
          ////////////////////////////////////////
          // Positioned(
          //   left: 20,
          //   top: 40,
          //   child: IconButton(
          //     icon: FaIcon(
          //       context.watch<PlaybackConfigViewModel>().muted
          //           ? FontAwesomeIcons.volumeOff
          //           : FontAwesomeIcons.volumeHigh,
          //     ),
          //     onPressed: () => context.read<PlaybackConfigViewModel>().setMuted(
          //           !context.read<PlaybackConfigViewModel>().muted,
          //         ),
          //     color: Colors.white,
          //   ),
          // ),
          ////////////////////////////////////////
          ////////////////////////////////////////
          ///4. ChangeNotifierProvider, MultiProvider 사용
          // Positioned(
          //   left: 20,
          //   top: 40,
          //   child: IconButton(
          //     icon: FaIcon(
          //       context.watch<VideoConfig>().isMuted
          //           ? FontAwesomeIcons.volumeOff
          //           : FontAwesomeIcons.volumeHigh,
          //     ),
          //     onPressed: context.read<VideoConfig>().toggleIsMuted,
          //     color: Colors.white,
          //   ),
          // ),
          ////////////////////////////////////////
          ////////////////////////////////////////
          ///3. ValueNotifier 사용
          // Positioned(
          //   left: 20,
          //   top: 40,
          //   child: IconButton(
          //     icon: FaIcon(
          //       _autoMute
          //           ? FontAwesomeIcons.volumeOff
          //           : FontAwesomeIcons.volumeHigh,
          //     ),
          //     onPressed: () => videoConfig.value = !videoConfig.value,
          //     color: Colors.white,
          //   ),
          // ),
          ////////////////////////////////////////
          ////////////////////////////////////////
          ///2. ChangeNotifier 사용(addListener)
          // Positioned(
          //   left: 20,
          //   top: 40,
          //   child: IconButton(
          //     icon: FaIcon(
          //       _autoMute
          //           ? FontAwesomeIcons.volumeOff
          //           : FontAwesomeIcons.volumeHigh,
          //     ),
          //     onPressed: videoConfig.toggleAutoMute,
          //     color: Colors.white,
          //   ),
          // ),
          ////////////////////////////////////////
          ///1. InheritedWidget과 StatefulWidget 결합
          // Positioned(
          //   left: 20,
          //   top: 40,
          //   child: IconButton(
          //     icon: FaIcon(
          //       VideoConfigData.of(context).autoMute
          //           ? FontAwesomeIcons.volumeOff
          //           : FontAwesomeIcons.volumeHigh,
          //     ),
          //     onPressed: () {
          //       VideoConfigData.of(context).toggleMuted();
          //     },
          //     color: Colors.white,
          //   ),
          // ),
          ////////////////////////////////////////
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
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                const CircleAvatar(
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
                  text: S.of(context).likeCount(987898797),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onCommentsTap,
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(4564564564132132),
                  ),
                ),
                Gaps.v24,
                const VideoButton(
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
      ),
    );
  }
}
