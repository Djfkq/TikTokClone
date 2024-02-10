import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoFlashModeButton extends StatelessWidget {
  final FlashMode flashMode;
  final Future<void> Function(FlashMode) setFlashMode;
  final bool selected;
  final IconData icon;
  const VideoFlashModeButton({
    super.key,
    required this.flashMode,
    required this.setFlashMode,
    required this.selected,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: selected ? Colors.amber.shade200 : Colors.white,
      onPressed: () => setFlashMode(flashMode),
      icon: Icon(
        icon,
      ),
    );
  }
}
