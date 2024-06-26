//package imports
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

//local imports
import 'package:tournamyx_mobile/components/auth/button.dart';
import 'package:tournamyx_mobile/components/auth/text_field.dart';
import 'package:tournamyx_mobile/components/shared/myx_bottom_navbar.dart';
import 'package:tournamyx_mobile/utils/theme/tournamyx_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void checkCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('User already signed in: ${user.email}');
      // Handle this case - maybe navigate to home or sign out the user
    } else {
      print('No user currently signed in');
    }
  }

  Future<void> signUserIn() async {
    print('Signing user in');
    if (_formKey.currentState!.validate()) {
      print('Form validated');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          print('Showing loading indicator');
          return const Center(child: CircularProgressIndicator());
        },
      );

      try {
        print('Preparing to sign in with Firebase');
        print('Email: ${emailController.text}');
        print('Password length: ${passwordController.text.length}');

        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
            .timeout(Duration(seconds: 30), onTimeout: () {
          throw TimeoutException('Sign in timed out');
        });

        print('Firebase sign in completed');

        Navigator.of(context).pop(); // Close loading indicator

        if (credential.user != null) {
          print('User signed in successfully, navigating to home');
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          print('Credential user is null');
        }
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuthException: ${e.message}');
        Navigator.of(context).pop(); // Close loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred')),
        );
      } on TimeoutException catch (e) {
        print('Timeout: $e');
        Navigator.of(context).pop(); // Close loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in timed out. Please try again.')),
        );
      } catch (e) {
        print('Unexpected error: $e');
        Navigator.of(context).pop(); // Close loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred')),
        );
      }
    } else {
      print('Form is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TournamyxTheme.background,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7), // Adjust the opacity as needed
                  BlendMode.darken,
                ),
                child: Image.network(
                  'https://images.unsplash.com/photo-1593376853899-fbb47a057fa0?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fHJvYm90aWNzfGVufDB8fDB8fHww',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: IconButton(
                  //     padding: const EdgeInsets.only(left: 25.0),
                  //     icon: const Icon(Icons.arrow_back_ios),
                  //     color: TournamyxTheme.primary,
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //   ),
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  const Text(
                    "Welcome back to Tournamyx!",
                    style: TextStyle(
                      color: TournamyxTheme.primary,
                      fontSize: 30, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20, // Adjust the font size as needed
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          MyTextField(
                            controller: emailController,
                            hintText: 'Email',
                            obscureText: false,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          MyTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          ElevatedButton(
                            onPressed: signUserIn,
                            child: const Text('Login',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TournamyxTheme.primary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 130, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text('Forgot Password?',
                              //TODO: implement forgot password
                              style: TextStyle(
                                  color: TournamyxTheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Column(
                    children: [
                      const Text('Or login with',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        // Login using other provider
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Icon(Ionicons.logo_google,
                                color: Colors.yellow[700]),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: const Icon(Ionicons.logo_facebook,
                                color: Colors.blue),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: const Icon(Ionicons.logo_apple,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14, // Adjust the font size as needed
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: TournamyxTheme.primary,
                              fontSize: 14, // Adjust the font size as needed
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
