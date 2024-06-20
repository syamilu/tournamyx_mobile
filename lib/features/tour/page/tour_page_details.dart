import 'package:flutter/material.dart';


class TourPageDetails extends StatelessWidget {
  const TourPageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Primary'),
              Text('Secondary'),
            ],),
        ),
      ),
    );
  }
}


