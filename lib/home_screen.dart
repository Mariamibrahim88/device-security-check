import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO [MEDIUM] (Accessibility): Extract UI strings to App Strings resource.
    return const Scaffold(body: Center(child: Text("Home Screen")));
  }
}
