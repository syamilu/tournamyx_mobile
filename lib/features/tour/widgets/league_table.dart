import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class GroupDetails {
  List<Groups>? groups;

  GroupDetails({this.groups});

  GroupDetails.fromJson(Map<String, dynamic> json) {
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

  Teams({
      this.id,
      this.name,
      this.wins,
      this.draws,
      this.losses,
      this.points,
      this.goalsScored,
      this.goalsConceded,
      this.rank
      });

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

//* Step 3: Fetch and parse JSON data
Future<GroupDetails> fetchGroupDetails() async {
  final response = await http.get(Uri.parse('https://admin.tournamyx.com/api/iiumrc/soccer-primary/tournament/groups'));

  if (response.statusCode == 200) {
    return GroupDetails.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load group details');
  }
}

class LeagueTableWidget extends StatelessWidget {
  final List<Teams> teams = [];

  LeagueTableWidget({super.key});

  @override
    Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Group ID')),
          DataColumn(label: Text('Team ID')),
          DataColumn(label: Text('Team Name')),
          DataColumn(label: Text('Wins')),
          DataColumn(label: Text('Draws')),
          DataColumn(label: Text('Losses')),
          DataColumn(label: Text('Points')),
          DataColumn(label: Text('Rank')),
        ],
        rows: teams.map((team) => DataRow(cells: [
          DataCell(Text(team.id ?? '')),
          DataCell(Text(team.name ?? '')),
          DataCell(Text(team.wins.toString())),
          DataCell(Text(team.draws.toString())),
          DataCell(Text(team.losses.toString())),
          DataCell(Text(team.points.toString())),
          DataCell(Text(team.rank.toString())),
        ])).toList(),
      )
    );
  }
}


