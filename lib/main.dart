import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tournamyx_mobile/features/auth/screen/register.dart';
import 'package:tournamyx_mobile/features/profile/screen/change_password.dart';
import 'package:tournamyx_mobile/features/home/screen/home_screen.dart';
import 'package:tournamyx_mobile/features/tour/page/tour_page_details.dart';
import 'package:tournamyx_mobile/utils/theme/color_schemes.g.dart';

import 'package:tournamyx_mobile/components/shared/loading_screen.dart';
import 'package:tournamyx_mobile/components/shared/myx_bottom_navbar.dart';
import 'package:tournamyx_mobile/features/auth/screen/login.dart';
import 'package:tournamyx_mobile/features/favourite/screen/favourite_page.dart';
import 'package:tournamyx_mobile/features/tour/page/tour_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> _sub;
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _sub = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        navigatorKey.currentState?.pushReplacementNamed('/login');
      } else {
        navigatorKey.currentState?.pushReplacementNamed('/home');
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Tournamyx',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: darkColorScheme,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Scaffold(
        body: Center(
          child: LoadingScreen(),

        ),
      ),
      routes: {
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MyxBottomNavbar(),
        '/login': (context) => LoginScreen(),
        '/favourite': (context) => const FavouriteScreen(),
        '/change-password': (context) => const ChangePasswordScreen(),
        '/tour': (context) => const TourScreen(),
      },
    );
  }
}
