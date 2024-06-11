import 'package:flutter/material.dart';

class GroupFixture extends StatelessWidget {
  const GroupFixture({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('Group A',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16.0),
                Table(
                  children: const [
                    TableRow(children: [
                      TableCell(
                          child: Text('Team ID',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      TableCell(
                          child: Text('Team Name',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      TableCell(
                          child: Text('W',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      TableCell(
                          child: Text('D',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      TableCell(
                          child: Text('L',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      TableCell(
                          child: Text('GD',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      TableCell(
                          child: Text('Pts',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ]),
                    TableRow(children: [
                      TableCell(child: Text('SCP01')),
                      TableCell(child: Text('Team A')),
                      TableCell(child: Text('2')),
                      TableCell(child: Text('1')),
                      TableCell(child: Text('0')),
                      TableCell(child: Text('1')),
                      TableCell(child: Text('3')),
                    ]),
                    TableRow(children: [
                      TableCell(child: Text('SCP02')),
                      TableCell(child: Text('Team B')),
                      TableCell(child: Text('1')),
                      TableCell(child: Text('1')),
                      TableCell(child: Text('1')),
                      TableCell(child: Text('0')),
                      TableCell(child: Text('4')),
                    ]),
                    TableRow(children: [
                      TableCell(child: Text('SCP03')),
                      TableCell(child: Text('Team C')),
                      TableCell(child: Text('0')),
                      TableCell(child: Text('0')),
                      TableCell(child: Text('2')),
                      TableCell(child: Text('0')),
                      TableCell(child: Text('0')),
                    ]),
                    TableRow(children: [
                      TableCell(child: Text('SCP04')),
                      TableCell(child: Text('Team D')),
                      TableCell(child: Text('1')),
                      TableCell(child: Text('1')),
                      TableCell(child: Text('1')),
                      TableCell(child: Text('0')),
                      TableCell(child: Text('4')),
                    ]),
                    TableRow(children: [
                      TableCell(child: Text('SCP05')),
                      TableCell(child: Text('Team E')),
                      TableCell(child: Text('2')),
                      TableCell(child: Text('0')),
                      TableCell(child: Text('1')),
                      TableCell(child: Text('1')),
                      TableCell(child: Text('6')),
                    ]),
                  ],
                ),
              ],
            )));
  }
}
