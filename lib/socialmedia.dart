import 'package:flutter/material.dart';

import 'auth/login.dart';
import 'views/profileview.dart';

class TikTokTokApp extends StatelessWidget {
  const TikTokTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF5967D8);
    return MaterialApp(
      title: 'TikTokTok',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9F7FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          primary: accent,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF9F7FC),
          foregroundColor: Color(0xFF242334),
          centerTitle: false,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE9E5F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: accent, width: 1.5),
          ),
        ),
      ),
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        ProfileView.routeName: (_) => const ProfileView(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
