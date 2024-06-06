import 'package:flutter/material.dart';
import 'package:tournamyx_mobile/features/auth/screen/register.dart';
import 'package:tournamyx_mobile/utils/theme/color_schemes.g.dart';
import 'package:tournamyx_mobile/components/shared/loading_screen.dart';
import 'package:tournamyx_mobile/components/shared/myx_bottom_navbar.dart';

void main() async {
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

final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Tournamyx',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: lightColorScheme,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? const MyxBottomNavbar()
                : const LoadingScreen(),
      ),
      routes: {
        '/register': (context) => const RegisterScreen(),
      },
      // routes: {
      //   '/welcome': (context) => const WelcomeScreen(),
      //   '/register': (context) => const RegisterScreen(),
      //   '/login': (context) => const LoginScreen(),
      // },
    );
  }
}
