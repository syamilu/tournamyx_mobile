import 'package:flutter/material.dart';
import 'package:tournamyx_mobile/components/shared/myx_topbar.dart';
import 'package:tournamyx_mobile/features/tour/page/tour_page_details.dart';
import 'package:tournamyx_mobile/features/tour/widgets/tour_card.dart';
import 'package:tournamyx_mobile/utils/theme/tournamyx_theme.dart';


class TourScreen extends StatelessWidget {
  const TourScreen({Key? key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Tournamyx'),
      body: ListView(
        children: [
          TourCard(
            title: "IIUM ROBOTIC COMPETITION 2024",
            subtitle: 'International Islamic University Malaysia',
            color: TournamyxTheme.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TourPageDetails()),
                );
            },
          ),
          const TourCard(
            title: 'GENIUS ROBOTICS CHAMPIONSHIP', 
            subtitle: 'Universiti Teknologi Petronas',
            color: TournamyxTheme.background
          ),
          const TourCard(
            title: 'ROBOTICS COMPETITION 2024', 
            subtitle: 'Universiti Malaya',
            color: TournamyxTheme.grey
          ),
        ],
      ),
    );
  }
}