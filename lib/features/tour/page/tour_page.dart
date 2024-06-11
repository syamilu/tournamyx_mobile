import 'package:flutter/material.dart';
import 'package:tournamyx_mobile/components/shared/myx_topbar.dart';
import 'package:tournamyx_mobile/features/tour/widgets/tour_card.dart';

class TourScreen extends StatelessWidget {
  const TourScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Tournamyx'),
      body: ListView(
        children: const <Widget>[
          TourCard(
            title: "IIUM ROBOTIC COMPETITION 2024",
            subtitle: 'International Islamic University Malaysia',
            color: Colors.blue,
          ),
          TourCard(
            title: 'GENIUS ROBOTICS CHAMPIONSHIP', 
            subtitle: 'Universiti Teknologi Petronas',
            color: Colors.green,
          ),
          TourCard(
            title: 'ROBOTICS COMPETITION 2024', 
            subtitle: 'Universiti Malaya',
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}