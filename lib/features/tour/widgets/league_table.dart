import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Group {
  final int id;
  final String name;
  final String group;

  Group({required this.id, required this.name, required this.group});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      group: json['group'],
    );
  }
}

Future<List<Group>> fetchGroups() async {
  final response = await http.get(Uri.parse(
      'https://admin.tournamyx.com/api/iiumrc/soccer-primary/tournament/groups'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((group) => new Group.fromJson(group)).toList();
  } else {
    throw Exception('Failed to load groups from API');
  }
}

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Group>>(
      future: fetchGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Group')),
              ],
              rows: snapshot.data!
                  .map(
                    (group) => DataRow(cells: [
                      DataCell(Text(group.id.toString())),
                      DataCell(Text(group.name)),
                      DataCell(Text(group.group)),
                    ]),
                  )
                  .toList(),
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
