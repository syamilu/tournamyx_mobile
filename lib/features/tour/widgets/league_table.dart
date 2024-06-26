import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Group {
  List<Groups>? groups;

  Group({this.groups});

  Group.fromJson(Map<String, dynamic> json) {
    if (json['groups'] != null) {
      groups = <Groups>[];
      json['groups'].forEach((v) {
        groups!.add(Groups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (groups != null) {
      data['groups'] = groups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Groups {
  String? groupId;
  List<Teams>? teams;

  Groups({this.groupId, this.teams});

  Groups.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = groupId;
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  String? id;
  String? name;
  int? wins;
  int? draws;
  int? losses;
  int? points;
  int? goalsScored;
  int? goalsConceded;
  int? rank;

  Teams(
      {this.id,
      this.name,
      this.wins,
      this.draws,
      this.losses,
      this.points,
      this.goalsScored,
      this.goalsConceded,
      this.rank});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    wins = json['wins'];
    draws = json['draws'];
    losses = json['losses'];
    points = json['points'];
    goalsScored = json['goalsScored'];
    goalsConceded = json['goalsConceded'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['wins'] = wins;
    data['draws'] = draws;
    data['losses'] = losses;
    data['points'] = points;
    data['goalsScored'] = goalsScored;
    data['goalsConceded'] = goalsConceded;
    data['rank'] = rank;
    return data;
  }
}

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _GroupsPageState createState() => _GroupsPageState();
// }

class _GroupsPageState extends State<GroupsPage> {
  Future<List<Group>> fetchGroups() async {
    final response = await http.get(Uri.parse('https://admin.tournamyx.com/api/iiumrc/soccer-primary/tournament/groups'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((group) => Group.fromJson(group)).toList();
    } else {
      throw Exception('Failed to load groups');
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Groups'),
    ),
    body: FutureBuilder<List<Group>>(
      future: fetchGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Group group = snapshot.data![index];
              return ExpansionTile(
                title: Text('Group ${group.groups}'),
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Team ID')),
                        DataColumn(label: Text('Team Name')),
                        DataColumn(label: Text('Wins')),
                        DataColumn(label: Text('Draws')),
                        DataColumn(label: Text('Losses')),
                        DataColumn(label: Text('Goal Differences')),
                        DataColumn(label: Text('Points')),
                      ],
                      rows: group.Teams!.map<DataRow>((team) { //! I want to refer to the teams but it did not work.
                        int goalDifference = team.goalsScored! - team.goalsConceded!;
                        return DataRow(cells: [
                          DataCell(Text(team.id!)),
                          DataCell(Text(team.name!)),
                          DataCell(Text(team.wins.toString())),
                          DataCell(Text(team.draws.toString())),
                          DataCell(Text(team.losses.toString())),
                          DataCell(Text(goalDifference.toString())),
                          DataCell(Text(team.points.toString())),
                        ]);
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return const Text('No data');
        }
      },
    ),
  );
}
}


