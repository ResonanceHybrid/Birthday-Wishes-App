import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() async {
  // Ensure Flutter binding and async initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Lock app orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set transparent status bar and light system UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // ✅ Initialize OneSignal before running the app
  OneSignal.initialize("fc494faa-5d66-41c1-84fb-08a223c2a066");

  // Request permission for push notifications
  await OneSignal.Notifications.requestPermission(true);

  // ✅ Ensure Google Fonts are bundled (no runtime fetching)
  GoogleFonts.config.allowRuntimeFetching = false;

  // Run the main app
  runApp(const BirthdayWishesApp());
}

class BirthdayWishesApp extends StatelessWidget {
  const BirthdayWishesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday Wishes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
