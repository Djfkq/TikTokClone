import 'package:flutter/material.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/utils.dart';

class InterestButton extends StatefulWidget {
  final String interest;
  const InterestButton({
    super.key,
    required this.interest,
  });

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(
          microseconds: 300,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size12,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          color: _isSelected
              ? Theme.of(context).primaryColor
              : isDarkMode(context)
                  ? Colors.grey.shade700
                  : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode(context)
                  ? Colors.white.withOpacity(0.5)
                  : Colors.black.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
          border: Border.all(
            color: isDarkMode(context)
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
          ),
        ),
        child: Text(
          widget.interest,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
