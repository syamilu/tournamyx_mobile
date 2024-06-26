import 'package:flutter/material.dart';
import 'package:tournamyx_mobile/features/tour/widgets/league_table.dart';

class CategoriesDialog extends StatefulWidget{
  const CategoriesDialog({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _CategoriesDialogState createState() => _CategoriesDialogState();
}

class _CategoriesDialogState extends State<CategoriesDialog>{
  String _chosenValue = 'Soccer Primary';

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        TextButton(
          child: const Text('Categories'),
          onPressed: () {
            showDialog <String> (
              context: context, 
              builder: (BuildContext context) => SimpleDialog(
                title: const Text('Select Category'),
                children: <Widget>[
                  SimpleDialogOption(
                    onPressed: () {
                      setState(() {
                        fetchGroups('soc-prim');
                      });
                      Navigator.pop(context, 'Category 1');
                    },
                    child: const Text('Soccer Primary'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      setState((){
                        _chosenValue = 'Soccer Secondary';
                        fetchGroups('soc-sec');
                      });
                      Navigator.pop(context, 'Category 2');
                    },
                    child: const Text('Soccer Secondary'),
                  )
                ]
              ));
          },
        )
      ]
    );
  }
}
