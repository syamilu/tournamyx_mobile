// import 'package:flutter/material.dart';
// import 'package:tournamyx_mobile/features/tour/widgets/league_table.dart';

// class CategoriesDialog extends StatefulWidget{
//   const CategoriesDialog({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _CategoriesDialogState createState() => _CategoriesDialogState();
// }

// class _CategoriesDialogState extends State<CategoriesDialog>{
//   String _chosenValue = 'Soccer Primary';

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children:[
//         TextButton(
//           child: const Text('Categories'),
//           onPressed: () {
//             showDialog <String> (
//               context: context,
//               builder: (BuildContext context) => SimpleDialog(
//                 title: const Text('Select Category'),
//                 children: <Widget>[
//                   SimpleDialogOption(
//                     onPressed: () {
//                       setState(() {
//                         fetchGroups('soc-prim');
//                       });
//                       Navigator.pop(context, 'Category 1');
//                     },
//                     child: const Text('Soccer Primary'),
//                   ),
//                   SimpleDialogOption(
//                     onPressed: () {
//                       setState((){
//                         _chosenValue = 'Soccer Secondary';
//                         fetchGroups('soc-sec');
//                       });
//                       Navigator.pop(context, 'Category 2');
//                     },
//                     child: const Text('Soccer Secondary'),
//                   )
//                 ]
//               ));
//           },
//         )
//       ]
//     );
//   }
// }

import 'package:flutter/material.dart';

class CategoriesDialog extends StatelessWidget {
  const CategoriesDialog({Key? key}) : super(key: key);

  void _showCategoriesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Category'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Soccer Primary');
                // Handle 'Soccer Primary' selection
              },
              child: const Text('Soccer Primary'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Soccer Secondary');
                // Handle 'Soccer Secondary' selection
              },
              child: const Text('Soccer Secondary'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showCategoriesDialog(context),
      child: const Text('Choose Category'),
    );
  }
}
