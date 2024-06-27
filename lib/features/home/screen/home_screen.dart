import 'package:flutter/material.dart';
import 'package:tournamyx_mobile/features/home/screen/group_fixture.dart';
import 'package:tournamyx_mobile/features/home/screen/knockout_fixture.dart';
import 'package:tournamyx_mobile/features/profile/screen/profile_card.dart';
import 'package:tournamyx_mobile/features/home/screen/tournament_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tournamyx'),
        ),
        body: const SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProfileCard(),
              SizedBox(height: 16.0),
              TournamentCard(),
              SizedBox(height: 16.0),
              GroupFixture(),
              SizedBox(height: 16.0),
              KnockoutFixture()
            ],
          ),
        )));
  }
}
