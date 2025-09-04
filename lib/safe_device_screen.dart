import 'package:flutter/material.dart';
import 'package:safe_app/check_device.dart';
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
      final rules = [
        CheckDevice(!await SafeDevice.isRealDevice, "Running on emulator"),
        CheckDevice(
          await SafeDevice.isJailBroken,
          "Device is jailbroken or rooted",
        ),
        CheckDevice(
          await SafeDevice.isMockLocation,
          "Mock location is enabled",
        ),
        CheckDevice(
          await SafeDevice.isOnExternalStorage,
          "App is installed on external storage",
        ),
        CheckDevice(!await SafeDevice.isSafeDevice, "Check device safety"),
        CheckDevice(
          await SafeDevice.isDevelopmentModeEnable,
          "Developer mode is enabled",
        ),
      ];

      for (final rule in rules) {
        if (rule.check) {
          _goToBlockedPage(rule.message);
          return;
        }
      }

      _goToHome();
    } catch (e) {
      _goToBlockedPage("error: $e");
    }
  }

  void _goToBlockedPage(String reason) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => BlockedPage(reason: reason)),
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
