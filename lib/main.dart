import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tournamyx_mobile/features/auth/screen/register.dart';
import 'package:tournamyx_mobile/features/profile/screen/change_password.dart';
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

  // runApp(
  //   const ProviderScope(
  //     child: MyApp(),
  //   ),
  // );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> _sub;
  final navigatorKey = GlobalKey<NavigatorState>();

  //for checking whether user already sign in or not
  @override
  void initState() {
    super.initState();
    _sub = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print("User already signed in : ${user.displayName}");
        navigatorKey.currentState?.pushReplacementNamed('/home');
      } else {
        print("User not signed in");
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

      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyxBottomNavbar()),
                    );
                  },
                  child: const Text('User Page'),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TourScreen()),
                      );
                    },
                    child: const Text('Tour Page'))
              ],
            ),
          ),
        ),
      ),
      // FutureBuilder(
      //   future: Future.delayed(const Duration(seconds: 0)),
      //   builder: (context, snapshot) =>
      //       snapshot.connectionState == ConnectionState.done
      //           ? const MyxBottomNavbar()
      //           : const LoadingScreen(),
      // ),
      routes: {
        //   '/welcome': (context) => const WelcomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MyxBottomNavbar(),
        '/login': (context) => LoginScreen(),
        '/favourite': (context) => const FavouriteScreen(),
        '/change-password': (context) => const ChangePasswordScreen(),
      },
    );
  }
}
