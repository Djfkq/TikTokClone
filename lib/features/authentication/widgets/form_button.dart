import 'package:flutter/material.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/utils.dart';

class FormButton extends StatelessWidget {
  final bool disabled;
  final String text;
  final void Function(BuildContext) onTap;

  const FormButton({
    super.key,
    required this.text,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 500,
          ),
          decoration: BoxDecoration(
            color: disabled
                ? isDarkMode(context)
                    ? Colors.grey.shade800
                    : Colors.grey.shade300
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(
              Sizes.size5,
            ),
          ),
          // alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 500),
            style: TextStyle(
              color: disabled ? Colors.grey.shade400 : Colors.white,
              fontWeight: FontWeight.w600,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
