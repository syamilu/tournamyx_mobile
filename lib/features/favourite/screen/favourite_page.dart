import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tournamyx_mobile/features/favourite/services/delete_favteam.dart';
import 'package:tournamyx_mobile/utils/theme/tournamyx_theme.dart';
import 'package:tournamyx_mobile/features/favourite/model/favourite_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tournamyx_mobile/features/favourite/screen/all_match_pages.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  Map<String, dynamic> favoriteTeamData = {};
  LeagueData? leagueData;
  Group? selectedGroup;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> favTeamSchedule = [];
  bool favoriteTeamAvailable = false;

  @override
  void initState() {
    super.initState();
    fetchAndUpdateData();
  }

  Future<void> fetchAndUpdateData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      try {
        QuerySnapshot querySnapshot = await db
            .collection('users')
            .doc(user.uid)
            .collection('favoriteTeam')
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var docSnapshot = querySnapshot.docs.first;
          setState(() {
            favoriteTeamData = docSnapshot.data() as Map<String, dynamic>;
          });
          fetchAndFilterGroupData();
        } else {
          print('No favorite team data found');
          @override
          Widget build(BuildContext context) {
            return const Center(
              child: Text('No favorite team data found'),
            );
          }
        }
      } catch (e) {
        print('Error fetching data: $e');
      }
    }
  }

  Future<void> fetchAndFilterGroupData() async {
    if (favoriteTeamData.isEmpty || favoriteTeamData['teamCategory'] == null) {
      print('Favorite team data not available yet');
      setState(() {
        favoriteTeamAvailable = false;
      });
      return;
    }
    try {
      final String category = favoriteTeamData['teamCategory'];
      final String url =
          'https://admin.tournamyx.com/api/iiumrc/$category/tournament/groups';

      print('Requesting URL: $url'); //
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // final List<dynamic> groups = data['groups'];
        final String favoriteTeamId = favoriteTeamData['teamID'];
        setState(() {
          leagueData = LeagueData.fromJson(data);
          selectedGroup = leagueData?.groups.firstWhere(
            (group) => group.teams.any((team) => team.id == favoriteTeamId),
            orElse: () =>
                throw Exception('Group containing favorite team not found'),
          );
          print('Favorite team found in group ${selectedGroup?.groupId}');

          fetchAndFilterFavTeamSchedule();
          favoriteTeamAvailable = true;
          return;
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchAndFilterFavTeamSchedule() async {
    if (favoriteTeamData.isEmpty ||
        favoriteTeamData['teamCategory'] == null ||
        selectedGroup?.groupId == null) {
      print('Required data not available');
      return;
    }

    try {
      final String category = favoriteTeamData['teamCategory'];
      final String favoriteTeamId = favoriteTeamData['teamID'];
      final String? groupId = selectedGroup?.groupId;
      final String url =
          'https://admin.tournamyx.com/api/iiumrc/$category/tournament/schedules';

      print('Requesting URL for schedules: $url');
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['groupSchedules'] is! List) {
          print('groupSchedules is not a List');
          return;
        }

        final List<dynamic> groupSchedules = data['groupSchedules'];

        for (var group in groupSchedules) {
          if (group.isNotEmpty && group is List && group[0] is Map) {
            for (var game in group) {
              // Add a null check for game
              if (game == null) {
                print('Game is null, skipping...');
                continue; // Skip to the next iteration if game is null
              }

              if (game['redTeam'] == favoriteTeamId ||
                  game['blueTeam'] == favoriteTeamId) {
                // Found a game involving the favorite team
                print(
                    'Found favorite team in game: ${game['gameId']} within group');
                setState(() {
                  var existingGameIndex = favTeamSchedule.indexWhere(
                      (element) => element['gameId'] == game['gameId']);

                  if (existingGameIndex == -1) {
                    favTeamSchedule.add(game);
                  } else {
                    favTeamSchedule[existingGameIndex] = game;
                  }
                });
              }
            }
          }
        }

        // Process or store the favTeamSchedule list as needed
        print('Favorite team schedule: $favTeamSchedule');
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _tryDeleteFavoriteTeam() async {
    bool success = await deleteFavoriteTeam();
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Favorite team deleted successfully.')),
      );

      setState(() {
        favoriteTeamData = {}; // Resetting to an empty map
        leagueData = null; // Resetting nullable type to null
        selectedGroup = null; // Resetting nullable type to null
        favTeamSchedule = []; // Resetting to an empty list
        favoriteTeamAvailable = false; // Resetting boolean to its initial value
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to deleted favorite team.')),
      );
    }
    fetchAndUpdateData();
  }

  @override
  Widget build(BuildContext context) {
    if (!favoriteTeamAvailable) {
      return RefreshIndicator(
        onRefresh: fetchAndUpdateData,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Uh-oh no team added to favourite yet, please proceed to tournament page to add.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          actionsIconTheme: const IconThemeData(color: TournamyxTheme.primary),
          iconTheme: const IconThemeData(color: TournamyxTheme.primary),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Favourite Team',
                  style:
                      TextStyle(fontSize: 20, color: TournamyxTheme.primary)),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                      favoriteTeamData.isNotEmpty
                          ? favoriteTeamData['teamName']
                          : 'Team Name',
                      style: TextStyle(
                          fontSize: 12, color: TournamyxTheme.primary)),
                  Text(
                      favoriteTeamData.isNotEmpty
                          ? favoriteTeamData['teamCategory']
                          : 'Category',
                      style: TextStyle(
                          fontSize: 12, color: TournamyxTheme.primary)),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 14.0, right: 8.0),
              child: IconButton(
                icon: Icon(Ionicons.heart_dislike_outline),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context);
                              _tryDeleteFavoriteTeam();
                            },
                            child: const Text('Add to Favorites'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return RefreshIndicator(
                color: TournamyxTheme.primary,
                onRefresh: fetchAndUpdateData,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20.0), // Add your desired margin here
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Upcoming Match',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.7,
                              spreadRadius: 0.1,
                              offset: Offset(0.0, 0.0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              favTeamSchedule.isNotEmpty
                                  ? favTeamSchedule[0]['redTeam']
                                  : 'Loading...',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'VS',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              favTeamSchedule.isNotEmpty
                                  ? favTeamSchedule[0]['blueTeam']
                                  : 'Loading...',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20.0), // Add your desired margin here
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Past Match [Draw]',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.7,
                              spreadRadius: 0.1,
                              offset: Offset(0.0, 0.0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              favTeamSchedule.isNotEmpty
                                  ? favTeamSchedule[1]['redTeam']
                                  : 'Loading...',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'VS',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              favTeamSchedule.isNotEmpty
                                  ? favTeamSchedule[1]['blueTeam']
                                  : 'Loading...',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(
                            right: 10.0), // Add your desired margin here
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllMatchPage(
                                    favTeamSchedule: favTeamSchedule),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'View All Match',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Ionicons.arrow_forward,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      //leaderboard placeholder
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.7,
                              spreadRadius: 0.1,
                              offset: Offset(0.0, 0.0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: selectedGroup != null
                            ? LeaderboardTable(
                                group: selectedGroup!,
                                favTeam: favoriteTeamData['teamID'].toString())
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      )
                    ],
                  ),
                ));
          },
        ));
  }
}

class LeaderboardTable extends StatelessWidget {
  final Group group;
  final String favTeam;

  LeaderboardTable({required this.group, required this.favTeam});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 20,
      columns: [
        DataColumn(label: Text('R')),
        DataColumn(label: Text('Team Name')),
        DataColumn(label: Text('P')),
        DataColumn(label: Text('W-D-L')),
        DataColumn(label: Text('GS-GC')),
      ],
      rows: group.teams
          .map((team) => DataRow(
                color: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return team.id == favTeam
                      ? Colors.yellow.withOpacity(0.2)
                      : null;
                }),
                cells: [
                  DataCell(Text(team.rank.toString())),
                  DataCell(Text(team.name)),
                  DataCell(Text(team.points.toString())),
                  DataCell(Text('${team.wins}-${team.draws}-${team.losses}')),
                  DataCell(Text('${team.goalsScored}-${team.goalsConceded}')),
                ],
              ))
          .toList(),
    );
  }
}
