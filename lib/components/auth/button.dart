import 'package:flutter/material.dart';
import 'package:tournamyx_mobile/utils/theme/tournamyx_theme.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 71, 233, 133),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Continue",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
    );
  }
}

class MyButtonLogin extends StatefulWidget {
  final Function()? onTap;
  final String text;

  const MyButtonLogin({super.key, required this.onTap, required this.text});

  @override
  _MyButtonLoginState createState() => _MyButtonLoginState();
}

class _MyButtonLoginState extends State<MyButtonLogin> {
  double scale = 1;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      scale = 0.9;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      scale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTap: widget.onTap,
      child: Transform.scale(
        scale: scale,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: TournamyxTheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
