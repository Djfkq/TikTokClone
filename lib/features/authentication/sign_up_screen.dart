import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/routeurls.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/authentication/widgets/auth_button.dart';
import 'package:tiktokclonepractice/generated/l10n.dart';
import 'package:tiktokclonepractice/utils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    context.pushNamed(RouteNames.loginScreen);
  }

  void _onEmailTap(BuildContext context) {
    /////////////////////////////////////////////////////////
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(seconds: 1),
    //     reverseTransitionDuration: (const Duration(seconds: 1)),
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const UsernameScreen(),
    //     // transitionsBuilder: (context, animation, secondaryAnimation, child) =>
    //     //     ScaleTransition(
    //     //   scale: animation,
    //     //   alignment: Alignment.bottomRight,
    //     //   child: FadeTransition(
    //     //     opacity: animation,
    //     //     child: child,
    //     //   ),
    //     // ),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       final offsetAnimation = Tween(
    //         begin: Offset(0, -1),
    //         end: Offset.zero,
    //       ).animate(animation);
    //       final opacityAnimation =
    //           Tween(begin: 0.5, end: 1.0).animate(animation);
    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: FadeTransition(
    //           opacity: opacityAnimation,
    //           child: child,
    //         ),
    //       );
    //     },
    //   ),

    // );
    /////////////////////////////////////////////////////////
    context.pushNamed(RouteNames.usernameScreen);
  }

  @override
  Widget build(BuildContext context) {
    // print(Localizations.localeOf(context));
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
                    S.of(context).signUpTitle("TikTok"),
                    style: GoogleFonts.abrilFatface(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).SignUpSubtitle(0),
                      style: const TextStyle(
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
                      text: S.of(context).emailPasswordButton,
                      onTap: _onEmailTap,
                    ),
                    Gaps.v16,
                    AuthButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.apple,
                      ),
                      text: "Continue with Facebook",
                      onTap: (context) {},
                    ),
                    AuthButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.gamepad,
                      ),
                      text: S.of(context).appleButton,
                      onTap: (context) {},
                    ),
                    AuthButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.gamepad,
                      ),
                      text: "Continue with Google",
                      onTap: (context) {},
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
                            text: S.of(context).emailPasswordButton,
                            onTap: _onEmailTap,
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.apple,
                            ),
                            text: S.of(context).appleButton,
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
            color: isDarkMode(context) ? Colors.black : Colors.white,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).alreadyHaveAnAccount,
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      S.of(context).login("female"),
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
