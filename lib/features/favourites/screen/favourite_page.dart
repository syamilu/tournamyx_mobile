import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Center(
        child: Text(
          'Your favorite items will be displayed here.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
