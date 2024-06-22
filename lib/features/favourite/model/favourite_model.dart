class TeamsModel {
  List<Teams>? teams;

  TeamsModel({this.teams});

  TeamsModel.fromJson(Map<String, dynamic> json) {
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teams != null) {
      data['teams'] = this.teams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  Supervisor? supervisor;
  String? sId;
  String? name;
  String? school;
  List<String>? participants;
  String? category;
  int? iV;
  String? id;

  Teams(
      {this.supervisor,
      this.sId,
      this.name,
      this.school,
      this.participants,
      this.category,
      this.iV,
      this.id});

  Teams.fromJson(Map<String, dynamic> json) {
    supervisor = json['supervisor'] != null
        ? new Supervisor.fromJson(json['supervisor'])
        : null;
    sId = json['_id'];
    name = json['name'];
    school = json['school'];
    participants = json['participants'].cast<String>();
    category = json['category'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supervisor != null) {
      data['supervisor'] = this.supervisor!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['school'] = this.school;
    data['participants'] = this.participants;
    data['category'] = this.category;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}

class Supervisor {
  String? name;
  String? email;
  String? phone;

  Supervisor({this.name, this.email, this.phone});

  Supervisor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
