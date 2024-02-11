import 'dart:ffi';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/videos/views/video_preview_screen.dart';
import 'package:tiktokclonepractice/features/videos/views/widgets/video_flashmode_button.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  late double _minZoomLevel;
  late double _maxZoomLevel;
  final double _currentZoomLevel = 1.0;

  late CameraController _cameraController;
  late FlashMode _falshMode;

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );
  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
  );
  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(
    _buttonAnimationController,
  );

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    } else {}
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
      // enableAudio: false,
    );

    await _cameraController.initialize();

    // await _cameraController.prepareForVideoRecording();   //iOS

    _falshMode = _cameraController.value.flashMode;

    _minZoomLevel = await _cameraController.getMinZoomLevel();
    _maxZoomLevel = await _cameraController.getMaxZoomLevel();
  }

  Future<void> toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _falshMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    // final video = await _cameraController.takePicture();   //위와 동일

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    // final video = await ImagePicker().pickVideo(source: ImageSource.camera);   //카메라로 직접 촬영
    if (video == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // print(state);
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.paused) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _zoomRecording(LongPressMoveUpdateDetails details) async {
    print("zoom");

    // final dy = details.localPosition.dy;
    // if (dy >= 0) {
    //   if (_minZoomLevel > _currentZoomLevel + (-dy * 0.05)) return;
    //   _cameraController.setZoomLevel(_currentZoomLevel + (-dy * 0.05));
    // } else {
    //   if (_maxZoomLevel < _currentZoomLevel + (-dy * 0.005)) return;
    //   _cameraController.setZoomLevel(_currentZoomLevel + (-dy * 0.005));
    // }

    await _cameraController.setZoomLevel(5.0);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
    WidgetsBinding.instance.addObserver(this);

    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _stopRecording();
        }
      },
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    _cameraController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Initializing...,",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive(),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (_cameraController.value.isInitialized)
                    CameraPreview(_cameraController),
                  const Positioned(
                    top: Sizes.size40,
                    left: Sizes.size20,
                    child: CloseButton(
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: Sizes.size20,
                    right: Sizes.size20,
                    child: Column(
                      children: [
                        IconButton(
                          color: Colors.white,
                          onPressed: toggleSelfieMode,
                          icon: const Icon(
                            Icons.cameraswitch,
                          ),
                        ),
                        Gaps.v10,
                        VideoFlashModeButton(
                          flashMode: FlashMode.off,
                          selected: _falshMode == FlashMode.off,
                          icon: Icons.flash_off_rounded,
                          setFlashMode: _setFlashMode,
                        ),
                        Gaps.v10,
                        VideoFlashModeButton(
                          flashMode: FlashMode.always,
                          selected: _falshMode == FlashMode.always,
                          icon: Icons.flash_on_rounded,
                          setFlashMode: _setFlashMode,
                        ),
                        Gaps.v10,
                        VideoFlashModeButton(
                          flashMode: FlashMode.auto,
                          selected: _falshMode == FlashMode.auto,
                          icon: Icons.flash_auto_rounded,
                          setFlashMode: _setFlashMode,
                        ),
                        Gaps.v10,
                        VideoFlashModeButton(
                          flashMode: FlashMode.torch,
                          selected: _falshMode == FlashMode.torch,
                          icon: Icons.flashlight_on_rounded,
                          setFlashMode: _setFlashMode,
                        ),
                        ////////////////////////////////////////////////////////
                        // IconButton(
                        //   color: _falshMode == FlashMode.off
                        //       ? Colors.amber.shade200
                        //       : Colors.white,
                        //   onPressed: () => _setFlashMode(FlashMode.off),
                        //   icon: const Icon(
                        //     Icons.flash_off_rounded,
                        //   ),
                        // ),
                        // Gaps.v10,
                        // IconButton(
                        //   color: _falshMode == FlashMode.always
                        //       ? Colors.amber.shade200
                        //       : Colors.white,
                        //   onPressed: () => _setFlashMode(FlashMode.always),
                        //   icon: const Icon(
                        //     Icons.flash_on_rounded,
                        //   ),
                        // ),
                        // Gaps.v10,
                        // IconButton(
                        //   color: _falshMode == FlashMode.auto
                        //       ? Colors.amber.shade200
                        //       : Colors.white,
                        //   onPressed: () => _setFlashMode(FlashMode.auto),
                        //   icon: const Icon(
                        //     Icons.flash_auto_rounded,
                        //   ),
                        // ),
                        // Gaps.v10,
                        // IconButton(
                        //   color: _falshMode == FlashMode.torch
                        //       ? Colors.amber.shade200
                        //       : Colors.white,
                        //   onPressed: () => _setFlashMode(FlashMode.torch),
                        //   icon: const Icon(
                        //     Icons.flashlight_on_rounded,
                        //   ),
                        // ),
                        ////////////////////////////////////////////////////////
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: Sizes.size40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTapDown: _startRecording,
                          onTapUp: (details) => _stopRecording(),
                           onLongPressMoveUpdate: _zoomRecording,
                          // onVerticalDragUpdate: _zoomRecording,
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size80 + Sizes.size14,
                                  height: Sizes.size80 + Sizes.size14,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade400,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size80,
                                  height: Sizes.size80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
