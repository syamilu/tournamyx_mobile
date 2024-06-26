import 'package:flutter/material.dart';

class AllMatchPage extends StatelessWidget {
  final List<Map<String, dynamic>> favTeamSchedule;

  const AllMatchPage({Key? key, required this.favTeamSchedule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Schedules'),
      ),
      body: ListView.builder(
        itemCount: favTeamSchedule.length,
        itemBuilder: (context, index) {
          var game = favTeamSchedule[index];
          String scoreDisplay;
          if (game['score'] == null) {
            scoreDisplay = 'Not Started';
          } else {
            scoreDisplay =
                '${game['score']['redScore1']}-${game['score']['blueScore1']}, ${game['score']['redScore2']}-${game['score']['blueScore2']}, ${game['score']['redScore3']}-${game['score']['blueScore3']}';
          }
          return ListTile(
            title: Text('Game ${game['gameNo']}'),
            subtitle: Text(
                'Field ${game['fieldNo']} - ${game['redTeam']} vs ${game['blueTeam']}'),
            trailing: Text(scoreDisplay),
          );
        },
      ),
    );
  }
}
