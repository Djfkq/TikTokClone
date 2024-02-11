import 'package:go_router/go_router.dart';
import 'package:tiktokclonepractice/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktokclonepractice/constants/routeurls.dart';
import 'package:tiktokclonepractice/features/authentication/birthday_screen.dart';
import 'package:tiktokclonepractice/features/authentication/email_screen.dart';
import 'package:tiktokclonepractice/features/authentication/login_screen.dart';
import 'package:tiktokclonepractice/features/authentication/password_screen.dart';
import 'package:tiktokclonepractice/features/authentication/sign_up_screen.dart';
import 'package:tiktokclonepractice/features/authentication/username_screen.dart';
import 'package:tiktokclonepractice/features/onboarding/interests_screen.dart';
import 'package:tiktokclonepractice/features/settings/settings_screen.dart';
import 'package:tiktokclonepractice/features/videos/views/video_recording_screen.dart';
import 'package:tiktokclonepractice/features/videos/views/widgets/video_button.dart';

final router = GoRouter(
  initialLocation: RouteUrls.signupScreen,
  routes: [
    GoRoute(
      path: RouteUrls.signupScreen,
      name: RouteNames.signupScreen,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: RouteUrls.loginScreen,
      name: RouteNames.loginScreen,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteUrls.usernameScreen,
      name: RouteNames.usernameScreen,
      builder: (context, state) => const UsernameScreen(),
    ),
    GoRoute(
      path: RouteUrls.emailScreen,
      name: RouteNames.emailScreen,
      builder: (context, state) {
        final args = state.extra as EmailScreenArgs;
        return EmailScreen(username: args.username);
      },
    ),
    GoRoute(
      path: RouteUrls.passwordScreen,
      name: RouteNames.passwordScreen,
      builder: (context, state) => const PasswordScreen(),
    ),
    GoRoute(
      path: RouteUrls.birthdayScreen,
      name: RouteNames.birthdayScreen,
      builder: (context, state) => const BirthdayScreen(),
    ),
    GoRoute(
      path: RouteUrls.interestsScreen,
      name: RouteNames.interestsScreen,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      path: RouteUrls.mainnavigationScreen,
      name: RouteNames.mainnavigationScreen,
      builder: (context, state) => const MainNavigationScreen(),
    ),
    GoRoute(
      path: RouteUrls.settingScreen,
      name: RouteNames.settingScreen,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: RouteUrls.videorecordingScreen,
      name: RouteNames.videorecordingScreen,
      builder: (context, state) => const VideoRecordingScreen(),
    ),
  ],
);
