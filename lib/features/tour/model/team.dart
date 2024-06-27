class TeamModel {
  final String id;
  final String name;
  final int wins;
  final int draws;
  final int losses;
  final int points;
  final int goalsScored;
  final int goalsConceded;
  final int rank;

  TeamModel({
    required this.id,
    required this.name,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.points,
    required this.goalsScored,
    required this.goalsConceded,
    required this.rank
  });

  //* Factory constructor to create a FavouriteTeamModel from a JSON map
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
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

class Group {
  final String groupId;
  final List<TeamModel> teams;

  Group({
    required this.groupId,
    required this.teams
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['groupId'],
      teams: (json['teams'] as List).map((team) => TeamModel.fromJson(team)).toList(),
    );
  }

  get name => null;
}

class LeagueData {
  final List<Group> groups;

  LeagueData({
    required this.groups
  });

  factory LeagueData.fromJson(Map<String, dynamic> json) {
    return LeagueData(
      groups: (json['groups'] as List).map((group) => Group.fromJson(group)).toList(),
    );
  }
}
