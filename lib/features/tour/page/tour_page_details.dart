import 'package:flutter/material.dart';
import 'package:tournamyx_mobile/features/tour/widgets/categories_dialog.dart';
import 'package:tournamyx_mobile/features/tour/widgets/league_table.dart';

class TourPageDetails extends StatelessWidget {
  const TourPageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tournamyx"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tournament Name'),
            CategoriesDialog(),
            GroupsPage(),
            // LeagueTableWidget(),
          ],
        ),
      ),
    );
  }
}
