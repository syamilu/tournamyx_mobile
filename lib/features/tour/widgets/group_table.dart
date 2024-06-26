import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tournamyx_mobile/features/tour/model/team.dart';
import 'dart:convert';


class GroupTable extends StatefulWidget {
  const GroupTable({super.key});

  @override
  State<GroupTable> createState() => _GroupTableState();
}

class _GroupTableState extends State<GroupTable>{
  LeagueData? leagueData;
  Group? selectedGroup;


  @override
  void initState(){
    super.initState();
    fetchandfiltergroup();
  }

  Future<void> fetchandfiltergroup() async {
    const String url = 
    'https://admin.tournamyx.com/api/iiumrc/soccer-primary/tournament/groups';

    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final Map<String, dynamic> jsonData = json.decode(response.body);
        print(jsonData);
        
        // setState(() {
        //   leagueData = LeagueData.fromJson(jsonData);
        //   selectedGroup = leagueData?.groups.firstWhere(
        //     (group) => group.teams.any((team) => team.id != null),
        //   );
        // });

      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
      ),
    );

  }

}

// class LeaderboardTable extends StatelessWidget {
//   final Group group;
//   final String favTeam;

//   const LeaderboardTable({super.key, required this.group, required this.favTeam});

//   @override
//   Widget build(BuildContext context) {
//     return DataTable(
//       columnSpacing: 20,
//       columns: const [   
//         DataColumn(label: Text('R')),
//         DataColumn(label: Text('Team Name')),
//         DataColumn(label: Text('P')),
//         DataColumn(label: Text('W-D-L')),
//         DataColumn(label: Text('GS-GC')),
//       ],
//       rows: group.teams
//           .map((team) => DataRow(
//                 color: MaterialStateProperty.resolveWith<Color?>(
//                     (Set<MaterialState> states) {
//                   return team.id == favTeam
//                       ? Colors.yellow.withOpacity(0.2)
//                       : null;
//                 }),
//                 cells: [
//                   DataCell(Text(team.rank.toString())),
//                   DataCell(Text(team.name)),
//                   DataCell(Text(team.points.toString())),
//                   DataCell(Text('${team.wins}-${team.draws}-${team.losses}')),
//                   DataCell(Text('${team.goalsScored}-${team.goalsConceded}')),
//                 ],
//               ))
//           .toList(),
//     );
//   }
// }

