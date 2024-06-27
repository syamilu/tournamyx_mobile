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
