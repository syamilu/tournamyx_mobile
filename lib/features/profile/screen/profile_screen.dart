//code for me setting screen that have sign out button that will sign out the user using firebase cloud functions. It will also change the page to login

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tournamyx_mobile/features/auth/screen/login.dart';
import 'package:tournamyx_mobile/features/profile/screen/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const ProfileCard(),
              const SizedBox(height: 16.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/change-password');
                  },
                  child: const Text('Change Password')),
              ElevatedButton(
                onPressed: _signOut,
                child: const Text('Sign Out'),
              ),
            ],
          ),
        )));
  }
}
