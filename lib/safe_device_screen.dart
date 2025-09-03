import 'package:flutter/material.dart';
import 'package:safe_device/safe_device.dart';

import 'blocked_page.dart';
import 'home_screen.dart';

class SafeDeviceScreen extends StatefulWidget {
  const SafeDeviceScreen({super.key});

  @override
  State<SafeDeviceScreen> createState() => _SafeDeviceScreenState();
}

class _SafeDeviceScreenState extends State<SafeDeviceScreen> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      bool isJailBroken = await SafeDevice.isJailBroken;
      bool isRealDevice = await SafeDevice.isRealDevice;
      bool isMockLocation = await SafeDevice.isMockLocation;
      bool isOnExternalStorage = await SafeDevice.isOnExternalStorage;
      bool isSafeDevice = await SafeDevice.isSafeDevice;
      bool isDevelopmentModeEnable = await SafeDevice.isDevelopmentModeEnable;

      if (isJailBroken ||
          isRealDevice ||
          isOnExternalStorage ||
          !isSafeDevice ||
          isMockLocation ||
          isDevelopmentModeEnable) {
        _goToBlockedPage();
      } else {
        _goToHome();
      }
    // TODO [HIGH] (Error Handling): Avoid broad exception catches — Catch specific issues and show the error details instead of using `catch (e)` which can hide root causes.
    } catch (e) {
      _goToBlockedPage();
    }
  }

  void _goToBlockedPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const BlockedPage()),
    );
  }

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
