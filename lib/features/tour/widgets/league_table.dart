import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Team {
  final String id;
  final String name;
  final int wins;
  final int draws;
  final int losses;
  final int goalDifference;
  final int points;
  final int rank;

  Team({
    required this.id,
    required this.name,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.goalDifference,
    required this.points,
    required this.rank
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      wins: json['wins'],
      draws: json['draws'],
      losses: json['losses'],
      goalDifference: json['goalDifference'],
      points: json['points'],
      rank: json['rank']
    );
  }
}

class Group {
  final String groupId;
  final List<Team> teams;

  Group({required this.groupId, required this.teams});

  factory Group.fromJson(Map<String, dynamic> json) {
    var list = json['teams'] as List;
    List<Team> teamsList = list.map((i) => Team.fromJson(i)).toList();
    return Group(
      groupId: json['groupId'],
      teams: teamsList,
    );
  }
}


//* Fetching the Data
Future<List<Group>> fetchGroups() async {
  final response = await http.get(Uri.parse('https://admin.tournamyx.com/api/iiumrc/soccer-primary/tournament/groups'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<Group> groups = jsonResponse.map((groupJson) => Group.fromJson(groupJson)).toList();
    return groups;
  } else {
    throw Exception('Failed to load groups');
  }
}

class GroupsTableWidget extends StatefulWidget {
  const GroupsTableWidget({super.key});

  @override
  _GroupsTableWidgetState createState() => _GroupsTableWidgetState();
}

class _GroupsTableWidgetState extends State<GroupsTableWidget> {
  late Future<List<Group>> futureGroups;

  @override
  void initState() {
    super.initState();
    futureGroups = fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Group>>(
      future: futureGroups,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Group ID')),
                DataColumn(label: Text('Team Name')),
                DataColumn(label: Text('Points')),
              ],
              rows: snapshot.data!
                  .expand((group) => group.teams.map((team) => DataRow(cells: [
                        DataCell(Text(group.groupId.toString())),
                        DataCell(Text(team.name)),
                        DataCell(Text(team.points.toString())),
                      ])))
                  .toList(),
            ),
          );
        } else {
          return const Text('No data');
        }
      },
    );
  }
}
