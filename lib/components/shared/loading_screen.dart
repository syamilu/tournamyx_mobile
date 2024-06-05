import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 50,
            width: 48,
            child: CircularProgressIndicator(),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Loading...'),
        ]),
      ),
    );
  }
}
