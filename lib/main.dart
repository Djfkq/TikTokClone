import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktokclonepractice/common/widgets/darkmode_configuration/darkmode_config.dart';
import 'package:tiktokclonepractice/features/settings/settings_config.dart';
import 'package:tiktokclonepractice/features/videos/repos/playback_config_rep.dart';
import 'package:tiktokclonepractice/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktokclonepractice/generated/l10n.dart';
import 'package:tiktokclonepractice/router.dart';
import 'package:tiktokclonepractice/utils.dart';
import 'package:provider/provider.dart';

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

class TikTokApp extends StatefulWidget {
  const TikTokApp({super.key});

  @override
  State<TikTokApp> createState() => _TikTokAppState();
}

class _TikTokAppState extends State<TikTokApp> {
  @override
  Widget build(BuildContext context) {
    darkModeConfig.addListener(() {
      setState(() {});
    });

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
    S.load(const Locale("en"));
    return MaterialApp.router(
      routerConfig: router,
      title: 'TikTokClonePractice',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: const [Locale("en"), Locale("ko")],
      themeMode: isDarkMode(context) ? ThemeMode.dark : ThemeMode.light,
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
        listTileTheme: ListTileThemeData(
          leadingAndTrailingTextStyle: const TextStyle(
            color: Colors.black,
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black,
          ),
          subtitleTextStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
          iconColor: Colors.black,
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
          color: Colors.grey.shade800,
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
        listTileTheme: const ListTileThemeData(
          leadingAndTrailingTextStyle: TextStyle(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
          subtitleTextStyle: TextStyle(
            color: Colors.white60,
          ),
          iconColor: Colors.white,
        ),
      ),
    );
  }
}
