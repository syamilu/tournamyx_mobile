import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tournamyx_mobile/utils/theme/tournamyx_theme.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: TournamyxTheme.background,
        appBar: AppBar(
          backgroundColor: TournamyxTheme.background,
          actionsIconTheme: const IconThemeData(color: TournamyxTheme.primary),
          iconTheme: const IconThemeData(color: TournamyxTheme.primary),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Team Name',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: TournamyxTheme.primary)),
              SizedBox(width: 10),
              Column(
                children: [
                  Text('Category',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: TournamyxTheme.primary)),
                  Text('Level',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: TournamyxTheme.primary)),
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
                  await Future.delayed(const Duration(seconds: 1));
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
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: TournamyxTheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
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
                                fontWeight: FontWeight.bold,
                                color: TournamyxTheme.primary,
                              ),
                            ),
                            Text(
                              'VS',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: TournamyxTheme.primary,
                              ),
                            ),
                            Text(
                              'Team 2 Name',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: TournamyxTheme.primary,
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
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: TournamyxTheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
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
                                fontWeight: FontWeight.bold,
                                color: TournamyxTheme.primary,
                              ),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: TournamyxTheme.primary,
                              ),
                            ),
                            Text(
                              'VS',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: TournamyxTheme.primary,
                              ),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: TournamyxTheme.primary,
                              ),
                            ),
                            Text(
                              'Team 2 Name',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: TournamyxTheme.primary,
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
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Ionicons.arrow_forward,
                              color: Colors.white,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      //leaderboard placeholder
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: TournamyxTheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.7,
                              spreadRadius: 0.1,
                              offset: Offset(0.0, 0.0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Leaderboard',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: TournamyxTheme.primary,
                                  ),
                                ),
                                Text(
                                  'View All',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '1. Team 1 Name',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: TournamyxTheme.primary,
                                  ),
                                ),
                                Text(
                                  '100',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: TournamyxTheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '2. Team 2 Name',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: TournamyxTheme.primary,
                                  ),
                                ),
                                Text(
                                  '90',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: TournamyxTheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '3. Team 3 Name',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: TournamyxTheme.primary,
                                  ),
                                ),
                                Text(
                                  '80',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: TournamyxTheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        ));
  }
}
