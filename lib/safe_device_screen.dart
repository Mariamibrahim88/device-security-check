import 'package:flutter/material.dart';
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
    // TODO [HIGH] (Widget Optimization, Responsive & Adaptive UI): Navigation during initState — Avoid initiating navigation directly in initState; schedule navigation after the first frame or check `mounted` before navigating.
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      // TODO [MEDIUM] (Performance Bottlenecks): Sequential awaits in list literal — Multiple awaited checks here run sequentially and may add latency; consider running checks in parallel (e.g., with Future.wait) or adding timeouts.
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
      // TODO [HIGH] (Error Handling): Exposing raw exception message — Avoid showing raw exception strings to users as they may leak sensitive implementation details; log the exception and show a generic user-facing message.
      _goToBlockedPage("error: $e");
    }
  }

  void _goToBlockedPage(String reason) {
    // TODO [HIGH] (Widget Optimization, Responsive & Adaptive UI): Navigator calls without mounted check — Ensure `mounted` is true or perform navigation in a post-frame callback to avoid using a stale `context` from initState/async work.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => BlockedPage(reason: reason)),
    );
  }

  void _goToHome() {
    // TODO [HIGH] (Widget Optimization, Responsive & Adaptive UI): Navigator calls without mounted check — Ensure `mounted` is true or perform navigation in a post-frame callback to avoid using a stale `context` from initState/async work.
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
