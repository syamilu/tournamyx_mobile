import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tournamyx_mobile/components/shared/myx_bottom_navbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _changePassword() async {
    // Check password at least 8 characters
    if (_passwordController.text.length < 8) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Password must be at least 8 characters'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Check if the password and confirm password match
    if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updatePassword(_passwordController.text);
          Navigator.pop(context);
        }
      } catch (e) {
        print('Error: $e');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('An error occurred. Please try again later'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      print('User not registered');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                controller: _passwordController,
              ),
              const SizedBox(height: 16.0),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _changePassword,
                child: const Text('Change Password'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back')),
            ],
          ),
        ),
      ),
    );
  }
}
