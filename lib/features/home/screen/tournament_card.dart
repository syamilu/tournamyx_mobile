import 'package:flutter/material.dart';

class TournamentCard extends StatelessWidget {
  const TournamentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card.outlined(
        child: ListTile(
      title: Text('Tournament Name'),
      subtitle: Text('Tournament Description'),
      trailing: Icon(Icons.arrow_forward_ios),
    ));
  }
}
