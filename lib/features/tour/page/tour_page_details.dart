import 'package:flutter/material.dart';
// import 'package:tournamyx_mobile/features/tour/widgets/categories_dialog.dart';
import 'package:tournamyx_mobile/features/tour/widgets/league_table.dart';

class TourPageDetails extends StatefulWidget {
  const TourPageDetails({super.key});

  @override
  State<TourPageDetails> createState() => _TourPageDetailsState();
}

class _TourPageDetailsState extends State<TourPageDetails> {
  String selectedCategory = 'Soccer Primary';
  String categoryValue = 'soccer-primary';

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
                setState(() {
                  selectedCategory = 'Soccer Primary';
                  categoryValue = 'soccer-primary';
                });
              },
              child: const Text('Soccer Primary'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Soccer Secondary');
                setState(() {
                  selectedCategory = 'Soccer Secondary';
                  categoryValue = 'soccer-secondary';
                });
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tournament Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showCategoriesDialog(context),
              child: Text('Category : $selectedCategory'),
            ),
            GroupsPage(categoryValue: categoryValue),
          ],
        ),
      ),
    );
  }
}
