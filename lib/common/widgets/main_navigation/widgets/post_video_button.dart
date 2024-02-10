import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/utils.dart';

class PostVideoButton extends StatefulWidget {
  final bool inverted;
  const PostVideoButton({
    super.key,
    required this.inverted,
  });

  @override
  State<PostVideoButton> createState() => _PostVideoButtonState();
}

class _PostVideoButtonState extends State<PostVideoButton> {
  bool _hovering = false;

  void _onHover(PointerHoverEvent event) {
    setState(() {
      _hovering = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _hovering = false;
    });
  }

  Color _getContainerColor() {
    if (_hovering) {
      if (widget.inverted) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    } else {
      if (widget.inverted) {
        return Colors.black;
      } else {
        return Colors.white;
      }
    }
  }

  Color _getIconColor() {
    if (_hovering) {
      if (widget.inverted) {
        return Colors.black;
      } else {
        return Colors.white;
      }
    } else {
      if (widget.inverted) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 20,
            child: Container(
              height: 30,
              width: 25,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size8,
              ),
              decoration: BoxDecoration(
                color: _hovering ? Theme.of(context).primaryColor : Colors.blue,
                borderRadius: BorderRadius.circular(
                  Sizes.size11,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            child: Container(
              height: 30,
              width: 25,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size8,
              ),
              decoration: BoxDecoration(
                color: _hovering ? Colors.blue : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                  Sizes.size11,
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 300,
            ),
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size12,
            ),
            decoration: BoxDecoration(
              color: _getContainerColor(),
              borderRadius: BorderRadius.circular(
                Sizes.size11,
              ),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                size: Sizes.size16,
                color: _getIconColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
