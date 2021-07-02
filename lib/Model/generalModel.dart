class Place {
  List<PlaceModel> value;
  bool status;
  List<MessagesModel> messages;

  Place({this.value, this.status, this.messages});

  Place.fromJson(Map<String, dynamic> json) {
    if (json['Value'] != null) {
      value = new List<PlaceModel>();
      json['Value'].forEach((v) {
        value.add(new PlaceModel.fromJson(v));
      });
    }
    status = json['Status'];
    if (json['Messages'] != null) {
      messages = new List<MessagesModel>();
      json['Messages'].forEach((v) {
        messages.add(new MessagesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['Value'] = this.value.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    if (this.messages != null) {
      data['Messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlaceModel {
  int id;
  String level;
  String areaname;
  String created_at;
  String updated_at;

  PlaceModel({this.id, this.level, this.areaname, this.created_at, this.updated_at});

  PlaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    areaname = json['areaname'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    data['areaname'] = this.areaname;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}

class ListSearchPlace {
  int id;
  String level;
  String areaname;
  String created_at;
  String updated_at;

  ListSearchPlace({this.id, this.level, this.areaname, this.created_at, this.updated_at});

  ListSearchPlace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    areaname = json['areaname'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    data['areaname'] = this.areaname;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}

class Messages {
  int type;
  String title;
  String message;

  Messages({this.type, this.title, this.message});

  Messages.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    title = json['Title'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Title'] = this.title;
    data['Message'] = this.message;
    return data;
  }
}

class MessagesModel {
  int type;
  String title;
  String message;

  MessagesModel({this.type, this.title, this.message});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    title = json['Title'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Title'] = this.title;
    data['Message'] = this.message;
    return data;
  }
}