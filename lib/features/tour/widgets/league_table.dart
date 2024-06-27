import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'dart:convert';
import 'package:tournamyx_mobile/features/tour/widgets/categories_dialog.dart';
import 'package:tournamyx_mobile/features/tour/model/team_and_group_model.dart';
import 'package:tournamyx_mobile/features/tour/services/add_favteam.dart';

class GroupsPage extends StatefulWidget {
  final String categoryValue;

  const GroupsPage({Key? key, required this.categoryValue}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
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

  // void updateCategoryAndFetchGroups(String categoryId) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  // }

  @override
  void didUpdateWidget(covariant GroupsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if categoryValue has changed
    if (oldWidget.categoryValue != widget.categoryValue) {
      // If yes, load groups for the new category
      setState(() {
        isLoading = true;
      });
      loadGroups();
    }
  }

  Future<void> loadGroups() async {
    try {
      final fetchedGroups = await fetchGroups(widget.categoryValue);
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

  // Assuming this is inside a StatefulWidget
  Future<void> _tryUpdateFavoriteTeam(
      String? teamId, String category, String? teamName) async {
    bool success = await updateFavoriteTeam(teamId, category, teamName);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Favorite team updated successfully.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update favorite team.')),
      );
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

    if (chosenGroup == null) {
      return Center(child: Text("Group $_chosenGroup not found"));
    }

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
            DataCell(IconButton(
              icon: Icon(Ionicons.ellipsis_vertical),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                            _tryUpdateFavoriteTeam(
                                team.id, widget.categoryValue, team.name);
                            print('Team ID: ${team.id}');
                          },
                          child: const Text('Add to Favorites'),
                        ),
                      ],
                    );
                  },
                );
              },
            )),
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
                  DataColumn(label: Text('Pos')),
                  DataColumn(label: Text('')),
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

Future<List<Group>> fetchGroups(String categoryId) async {
  try {
    print("Fetching groups...");
    final response = await http.get(Uri.parse(
        'https://admin.tournamyx.com/api/iiumrc/$categoryId/tournament/groups'));

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
