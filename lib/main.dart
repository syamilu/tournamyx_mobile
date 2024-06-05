import 'package:flutter/material.dart';
import 'package:tournamyx_mobile/utils/theme/color_schemes.g.dart';
import 'package:tournamyx_mobile/components/shared/loading_screen.dart';
import 'package:tournamyx_mobile/components/shared/myx_bottom_navbar.dart';
import 'package:tournamyx_mobile/features/auth/screen/login.dart';
import 'package:tournamyx_mobile/features/favourite/screen/favourite_page.dart';

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
        //   '/register': (context) => const RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/favourite': (context) => const FavouriteScreen(),
      },
    );
  }
}
