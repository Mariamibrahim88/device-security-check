import 'package:flutter/material.dart';
import 'package:safe_app/core/utils/app_string.dart';
import 'check_device.dart';
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
      final checkList = await Future.wait([
        SafeDevice.isRealDevice,
        SafeDevice.isJailBroken,
        SafeDevice.isMockLocation,
        SafeDevice.isOnExternalStorage,
        SafeDevice.isSafeDevice,
        SafeDevice.isDevelopmentModeEnable,
      ]);
      final rules = [
        CheckDevice(!checkList[0], AppString.emulatorMessage),
        CheckDevice(checkList[1], AppString.jailbrokenMessage),
        CheckDevice(checkList[2], AppString.mockLocationMessage),
        CheckDevice(checkList[3], AppString.externalStorageMessage),
        CheckDevice(!checkList[4], AppString.safetyCheckMessage),
        CheckDevice(checkList[5], AppString.devModeMessage),
      ];

      for (final rule in rules) {
        if (rule.check) {
          _goToBlockedPage(rule.message);
          return;
        }
      }
      _goToHome();
    } catch (e) {
      _goToBlockedPage(AppString.unknownErrorMessage);
    }
  }

  void _goToBlockedPage(String reason) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BlockedPage(reason: reason)),
      );
    });
  }

  void _goToHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
