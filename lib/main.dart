import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktokclonepractice/features/videos/repos/playback_config_rep.dart';
import 'package:tiktokclonepractice/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktokclonepractice/router.dart';
import 'package:tiktokclonepractice/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepository(preferences);
  ///////////////////////////////////////////////////////
  ///MVVM 사용시
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(
  //         create: (context) => PlaybackConfigViewModel(repository),
  //       )
  //     ],
  //     child: const TikTokApp(),
  //   ),
  // );
  ///////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////
  ///Riverpod 사용시
  runApp(
    ProviderScope(
      overrides: [
        playbackConfigProvider.overrideWith(
          () => PlaybackConfigViewModel(repository),
        )
      ],
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});
  @override
  Widget build(BuildContext context) {
    ///단일이면 ChangeNotifierProvider 바로 사용하면 됨
    ////////////////////////////////////////////////////
    ///여러개이면 MultiProvider
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (context) => VideoConfig(),
    //     )
    //   ],
    //   child: MaterialApp.router(),
    //   )
    ////////////////////////////////////////////////////
    return MaterialApp.router(
      routerConfig: router,
      title: 'TikTokClonePractice',
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode(context) ? ThemeMode.dark : ThemeMode.light,
      // themeMode: darkModeConfig.value ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
        textTheme: Typography.blackMountainView,
        scaffoldBackgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade200,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          prefixIconColor: Colors.grey.shade400,
          suffixIconColor: Colors.grey.shade900,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.black,
          indicatorColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
        textTheme: Typography.whiteMountainView,
        scaffoldBackgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          prefixIconColor: Colors.white,
          suffixIconColor: Colors.grey.shade400,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
        ),
      ),
    );
  }
}
