import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/authentication/login_form_screen.dart';
import 'package:tiktokclonepractice/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktokclonepractice/features/authentication/widgets/auth_button.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void _onSignupTap(BuildContext context) {
    // Navigator.of(context).pop("hello");
    context.pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginFormScreen(),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    "Log in to TikTok",
                    style: GoogleFonts.abrilFatface(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Opacity(
                    opacity: 0.7,
                    child: Text(
                      "Manage your account, check notifications, comment on videos, and more.",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.solidUser,
                      ),
                      text: "Use email & password",
                      onTap: _onEmailLoginTap,
                    ),
                    Gaps.v16,
                    AuthButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.github,
                      ),
                      text: "Continue with Github",
                      onTap: (context) {
                        ref.read(socialAuthProvider.notifier).githubSignIn(context);
                      },
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.solidUser,
                            ),
                            text: "Use email & password",
                            onTap: _onEmailLoginTap,
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.apple,
                            ),
                            text: "Continue with Facebook",
                            onTap: (context) {},
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(),
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onSignupTap(context),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
