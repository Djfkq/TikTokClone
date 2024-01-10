import 'package:flutter/material.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/routeurls.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/authentication/email_screen.dart';
import 'package:tiktokclonepractice/features/authentication/widgets/form_button.dart';
import 'package:go_router/go_router.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();
  String _username = "";

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(
      () {
        setState(
          () {
            _username = _usernameController.text;
          },
        );
      },
    );
  }

  void onNextTap(BuildContext context) {
    if (_username.isNotEmpty) {
      context.pushNamed(RouteNames.emailScreen,
          extra: EmailScreenArgs(username: _username));
    }

    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => EmailScreen(username: _username),
    //   ),
    // );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Opacity(
              opacity: 0.7,
              child: Text(
                "You can always change this later.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  // color: Colors.black38,
                ),
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: "Username",
              ),
            ),
            Gaps.v16,
            FormButton(
              disabled: _username.isEmpty,
              text: "Next",
              onTap: onNextTap,
            )
          ],
        ),
      ),
    );
  }
}
