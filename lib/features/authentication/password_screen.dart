import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/routeurls.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/authentication/birthday_screen.dart';
import 'package:tiktokclonepractice/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktokclonepractice/features/authentication/widgets/form_button.dart';
import 'package:tiktokclonepractice/utils.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({
    super.key,
  });

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _password = "";
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(
      () {
        setState(
          () {
            _password = _passwordController.text;
          },
        );
      },
    );
  }

  void _onSubmit(BuildContext context) {
    if (_password.isEmpty || !_isPasswordValid()) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "password": _password,
    };
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
    // context.pushNamed(
    //   RouteNames.birthdayScreen,
    // );
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  bool _isPasswordValid() {
    return _password.length > 8 &&
        _password.length < 20 &&
        _password.isNotEmpty;
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _passwordController,
                autocorrect: false,
                obscureText: _obscureText,
                onEditingComplete: () => _onSubmit(context),
                decoration: InputDecoration(
                    hintText: "Make it strong",
                    hintStyle: TextStyle(
                      color: isDarkMode(context) ? Colors.grey.shade700 : null,
                    ),
                    errorText: _password.isEmpty || _isPasswordValid()
                        ? null
                        : "Invalid Password",
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _onClearTap,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey.shade400,
                            size: Sizes.size20,
                          ),
                        ),
                        Gaps.h16,
                        GestureDetector(
                          onTap: _toggleObscureText,
                          child: FaIcon(
                            _obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.grey.shade400,
                            size: Sizes.size20,
                          ),
                        )
                      ],
                    )),
              ),
              Gaps.v10,
              Text(
                "Your password must have:",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h5,
                  const Text(
                    "8 to 20 characters",
                    style: TextStyle(
                      fontSize: Sizes.size14,
                    ),
                  )
                ],
              ),
              Gaps.v16,
              FormButton(
                disabled: _password.isEmpty || !_isPasswordValid(),
                text: "Next",
                onTap: _onSubmit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
