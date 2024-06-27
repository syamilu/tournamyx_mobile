import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:tournamyx_mobile/features/tour/widgets/categories_dialog.dart';


class Group {
  String? groupId;
  List<Teams>? teams;

  Group({this.groupId, this.teams});

  Group.fromJson(Map<String, dynamic> json) {
    try {
      print("Parsing Group: ${json['groupId']}");
      groupId = json['groupId'];
      if (json['teams'] != null) {
        teams = <Teams>[];
        json['teams'].forEach((v) {
          print("Parsing team in group $groupId");
          teams!.add(Teams.fromJson(v));
        });
      }
      print("Group $groupId parsed successfully");
    } catch (e) {
      print("Error parsing Group: $e");
      print("JSON: $json");
      rethrow;
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
    try {
      id = json['id'];
      name = json['name'];
      wins = json['wins'];
      draws = json['draws'];
      losses = json['losses'];
      points = json['points'];
      goalsScored = json['goalsScored'];
      goalsConceded = json['goalsConceded'];
      rank = json['rank'];
      print("Team $name parsed successfully");
    } catch (e) {
      print("Error parsing Team: $e");
      print("JSON: $json");
      rethrow;
    }
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

class GroupsPageSecondary extends StatefulWidget {
  const GroupsPageSecondary({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPageSecondary> {
  List<Group>? groups;
  bool isLoading = true;
  String? error;
  //variable for current group selection such as A, B or C in character
  String _chosenGroup = 'A';

  @override
  void initState() {
    super.initState();
    loadGroups();
  }

  Future<void> loadGroups() async {
    try {
      final fetchedGroups = await fetchGroups();
      setState(() {
        groups = fetchedGroups;
        isLoading = false;
      });
      print("Groups loaded into state: ${groups?.length}");
      groups?.forEach((group) {
        print('Group ID: ${group.groupId}');
        group.teams!.forEach((team) {
          print(
              'Team ID: ${team.id}, Name: ${team.name}, Wins: ${team.wins}, Draws: ${team.draws}, Losses: ${team.losses}, Points: ${team.points}, Goals Scored: ${team.goalsScored}, Goals Conceded: ${team.goalsConceded}, Rank: ${team.rank}');
        });
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
      print("Error loading groups: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
  if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text("Error: $error"));
    }

    if (groups == null || groups!.isEmpty) {
      return const Center(child: Text("No groups available"));
    }

    Group? chosenGroup = groups!.firstWhere(
      (group) => group.groupId == _chosenGroup,
      orElse: () => Group(groupId: _chosenGroup, teams: []),
    );

    // Create rows for each team in the chosen group
    final rows = chosenGroup.teams?.map<DataRow>((team) {
          return DataRow(cells: [
            DataCell(Text(team.name ?? '')),
            DataCell(Text(team.wins?.toString() ?? '0')),
            DataCell(Text(team.draws?.toString() ?? '0')),
            DataCell(Text(team.losses?.toString() ?? '0')),
            DataCell(Text(team.points?.toString() ?? '0')),
            DataCell(Text(team.goalsScored?.toString() ?? '0')),
            DataCell(Text(team.goalsConceded?.toString() ?? '0')),
            DataCell(Text(team.rank?.toString() ?? '0')),
          ]);
        }).toList() ??
        [];

    // Return a DataTable widget
    return Column(
      children: [
        DropdownButton<String>(
          value: _chosenGroup,
          items: groups!.map((Group group) {
            return DropdownMenuItem<String>(
              value: group.groupId,
              child: Text('Group ${group.groupId}'),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _chosenGroup = newValue!;
            });
          },
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Text('Group ${chosenGroup.groupId}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              DataTable(
                columnSpacing: 20.0,
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('W')),
                  DataColumn(label: Text('D')),
                  DataColumn(label: Text('L')),
                  DataColumn(label: Text('P')),
                  DataColumn(label: Text('GS')),
                  DataColumn(label: Text('GC')),
                  DataColumn(label: Text('Rank')),
                ],
              rows: rows,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


Future<List<Group>> fetchGroups() async {
  try {
    print("Fetching groups...");
    final response = await http.get(Uri.parse(
        'https://admin.tournamyx.com/api/iiumrc/soccer-secondary/tournament/groups'));
    
    print("Response received. Status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Parsing JSON...");
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(
          "JSON decoded. Contains 'groups' key: ${jsonResponse.containsKey('groups')}");

      if (jsonResponse.containsKey('groups')) {
        List<dynamic> groupsList = jsonResponse['groups'];
        print("Number of groups: ${groupsList.length}");
        List<Group> groups = [];
        for (var i = 0; i < groupsList.length; i++) {
          print("Parsing group $i");
          groups.add(Group.fromJson(groupsList[i]));
          // Add a small delay between parsing each group
          await Future.delayed(Duration(milliseconds: 100));
        }
        print("All groups parsed successfully");
        return groups;
      } else {
        throw Exception('Unexpected JSON structure: ${jsonResponse.keys}');
      }
    } else {
      throw Exception(
          'Failed to load groups. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print("Error in fetchGroups: $e");
    rethrow;
  }
}

