import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = [
      "home",
      "discover",
      "xxx",
      "inbox",
      "profile",
    ];
    
    return const Scaffold();
  }
}
