import 'package:flutter/material.dart';
import 'core/utils/app_string.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text(AppString.homeMessage)));
  }
}
