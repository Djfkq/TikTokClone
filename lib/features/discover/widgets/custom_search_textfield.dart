import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';

class CustomSearchTextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final bool indexIsChanging;

  const CustomSearchTextField({
    super.key,
    required this.focusNode,
    required this.textEditingController,
    required this.indexIsChanging,
  });

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  late bool _isWriting;
  late num _editNum;

  void _onTextFieldChange(String value) {
    _editNum += 1;
    if (value != "") {
      _isWriting = true;
    } else {
      _isWriting = false;
    }
    setState(() {});
  }

  void _onDeleteTextTap() {
    setState(() {
      widget.textEditingController.text = "";
      _isWriting = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _isWriting = false;
    _editNum = 0;
  }

  @override
  void didUpdateWidget(covariant CustomSearchTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _editNum = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size4,
        vertical: Sizes.size10,
      ),
      child: TextField(
        controller: widget.textEditingController,
        onChanged: _onTextFieldChange,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          prefixIcon: const FaIcon(
            FontAwesomeIcons.magnifyingGlass,
          ),
          suffixIcon: GestureDetector(
            onTap: _onDeleteTextTap,
            child: AnimatedOpacity(
              opacity: widget.indexIsChanging && _editNum == 0
                  ? 0
                  : _isWriting
                      ? 1
                      : 0,
              duration: const Duration(
                milliseconds: 300,
              ),
              child: const FaIcon(
                FontAwesomeIcons.solidCircleXmark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
