import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/routeurls.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/authentication/widgets/form_button.dart';

class EmailScreenArgs {
  final String username;
  EmailScreenArgs({
    required this.username,
  });
}

class EmailScreen extends StatefulWidget {
  final String username;
  const EmailScreen({
    super.key,
    required this.username,
  });

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _email = "";

  @override
  void initState() {
    super.initState();
    _emailController.addListener(
      () {
        setState(
          () {
            _email = _emailController.text;
          },
        );
      },
    );
  }

  void _onSubmit(BuildContext context) {
    if (_email.isEmpty || _isEmailValid() != null) return;
    context.pushNamed(
      RouteNames.passwordScreen,
    );
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9]+[!#$%&'*+-/=?^_`(){|}~]*[a-zA-Z0-9]*@[\w]+\.[a-zA-Z0-9-]+[.]*[a-zA-Z0-9]+$");
    if (!regExp.hasMatch(_email)) return "Not valid";
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
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
              Text(
                "What is your email, ${widget.username}?",
                style: const TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                onEditingComplete: () => _onSubmit(context),
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _isEmailValid(),
                ),
                
              ),
              Gaps.v16,
              FormButton(
                disabled: _email.isEmpty || _isEmailValid() != null,
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
