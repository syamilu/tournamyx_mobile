import 'package:flutter/material.dart';

class CategoriesDialog extends StatefulWidget{
  const CategoriesDialog({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _CategoriesDialogState createState() => _CategoriesDialogState();
}

class _CategoriesDialogState extends State<CategoriesDialog>{
  String? _chosenValue;

  @override
  Widget build(BuildContext context) {
      return TextButton(
      child: Text('Categories'),
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => SimpleDialog(
          title: const Text('Choose a category'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                setState((){
                  _chosenValue = 'Soccer Primary';
                });
                Navigator.pop(context, 'Category 2');
              },
              child: const Text('Soccer Primary'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState((){
                  _chosenValue = 'Soccer Secondary';
                  });
                  Navigator.pop(context, 'Category 2');
                  },
                  child: const Text('Soccer Secondary'),
            ),
          ], 
          ),
        );
      },
    );
  }
}