/// users : [{"id":"hanieffuady@dpenfojb.com","name":"M. Hanief Fuady","password":"dsgZy47N","phone_number":62818224865},{"id":"aditiarestianda@dpenfojb.com","name":"Aditia Restianda","password":"7XMSdsVJ","phone_number":6282215393034},{"id":"sitihajar@dpenfojb.com","name":"Siti Hajar Riyanti","password":"sBqxCZA9","phone_number":620},{"id":"rizkyrama@dpenfojb.com","name":"Rizky Rama","password":"9m2VDtvy","phone_number":6287736243565},{"id":"dedeanggy@dpenfojb.com","name":"Dede Anggy","password":"P2zVCfUp","phone_number":6282120999679},{"id":"wildan@dpenfojb.com","name":"Wildan","password":"7L5g3HDc","phone_number":620}]

class ListUser {
  ListUser({
    this.users,});

  ListUser.fromJson(dynamic json, {String keys: 'users'}) {
    if (json[keys] != null) {
      users = [];
      json[keys].forEach((v) {
        users?.add(User.fromJson(v));
      });
    }
  }
  List<User>? users;

  Map<String, dynamic> toJson({String keys: 'users'}) {
    final map = <String, dynamic>{};
    if (users != null) {
      map[keys] = users?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "hanieffuady@dpenfojb.com"
/// name : "M. Hanief Fuady"
/// password : "dsgZy47N"
/// phone_number : 62818224865

class User {
  User({
    this.id,
    this.name,
    this.password,/*
    this.id,*/});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
    // id = json['phone_number'];
  }
  String? id;
  String? name;
  String? password;
  // int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['password'] = password;
    // map['phone_number'] = id;
    return map;
  }

}