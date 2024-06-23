import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tournamyx_mobile/utils/theme/tournamyx_theme.dart';
import 'package:tournamyx_mobile/features/favourite/services/fetch_favteam.dart';
import 'package:tournamyx_mobile/features/favourite/model/favourite_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  @override
  void initState() {
    super.initState();
    fetchAndUpdateData();
    fetchAndFilterGroupData();
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
    const String url =
        'https://admin.tournamyx.com/api/iiumrc/soccer-primary/tournament/groups';
    try {
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
          return;
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return RefreshIndicator(
                color: TournamyxTheme.primary,
                onRefresh: () async {
                  fetchAndUpdateData;
                  fetchAndFilterGroupData;
                },
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
                              'Team 1 Name',
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
                              'Team 2 Name',
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
                              'Team 1 Name',
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
                              'Team 2 Name',
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
