class FavouriteTeamModel {
  String? teamCategory;
  String? teamID;
  String? teamName;
  String? tourName;

  FavouriteTeamModel({
    this.teamCategory,
    this.teamID,
    this.teamName,
    this.tourName,
  });

  // Factory constructor to create a FavouriteTeamModel from a JSON map
  factory FavouriteTeamModel.fromJson(Map<String, dynamic> json) {
    return FavouriteTeamModel(
      teamCategory: json['teamCategory'],
      teamID: json['teamID'],
      teamName: json['teamName'],
      tourName: json['tourName'],
    );
  }

  // Method to convert FavouriteTeamModel instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'teamCategory': teamCategory,
      'teamID': teamID,
      'teamName': teamName,
      'tourName': tourName,
    };
  }
}


// for leaderboard
class LeagueData {
  final List<Group> groups;

  LeagueData({required this.groups});

  factory LeagueData.fromJson(Map<String, dynamic> json) {
    return LeagueData(
      groups: (json['groups'] as List).map((group) => Group.fromJson(group)).toList(),
    );
  }
}

class Group {
  final String groupId;
  final List<Team> teams;

  Group({required this.groupId, required this.teams});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['groupId'],
      teams: (json['teams'] as List).map((team) => Team.fromJson(team)).toList(),
    );
  }
}

class Team {
  final String id;
  final String name;
  final int wins;
  final int draws;
  final int losses;
  final int points;
  final int goalsScored;
  final int goalsConceded;
  final int rank;

  Team({
    required this.id,
    required this.name,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.points,
    required this.goalsScored,
    required this.goalsConceded,
    required this.rank,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      wins: json['wins'],
      draws: json['draws'],
      losses: json['losses'],
      points: json['points'],
      goalsScored: json['goalsScored'],
      goalsConceded: json['goalsConceded'],
      rank: json['rank'],
    );
  }
}