class ElectionsModel {
  ElectionsModel({
    String? id,
    String? title,
    String? startDate,
    String? endDate,
    String? status,
    List<Parties>? parties,
    List<Candidates>? candidates,
    num? v,
  }) {
    _id = id;
    _title = title;
    _startDate = startDate;
    _endDate = endDate;
    _status = status;
    _parties = parties;
    _candidates = candidates;
    _v = v;
  }

  ElectionsModel.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _startDate = json['startDate'];
    _endDate = json['endDate'];
    _status = json['status'];
    if (json['parties'] != null) {
      _parties = [];
      json['parties'].forEach((v) {
        _parties?.add(Parties.fromJson(v));
      });
    }
    if (json['candidates'] != null) {
      _candidates = [];
      json['candidates'].forEach((v) {
        _candidates?.add(Candidates.fromJson(v));
      });
    }
    _v = json['__v'];
  }
  String? _id;
  String? _title;
  String? _startDate;
  String? _endDate;
  String? _status;
  List<Parties>? _parties;
  List<Candidates>? _candidates;
  num? _v;

  ElectionsModel copyWith({
    String? id,
    String? title,
    String? startDate,
    String? endDate,
    String? status,
    List<Parties>? parties,
    List<Candidates>? candidates,
    num? v,
  }) =>
      ElectionsModel(
        id: id ?? _id,
        title: title ?? _title,
        startDate: startDate ?? _startDate,
        endDate: endDate ?? _endDate,
        status: status ?? _status,
        parties: parties ?? _parties,
        candidates: candidates ?? _candidates,
        v: v ?? _v,
      );

  String? get id => _id;
  String? get title => _title;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get status => status;
  List<Parties>? get parties => _parties;
  List<Candidates>? get candidates => _candidates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['startDate'] = _startDate;
    map['endDate'] = _endDate;
    map['status'] = _status;
    if (_parties != null) {
      map['parties'] = _parties?.map((v) => v.toJson()).toList();
    }

    if (_candidates != null) {
      map['candidates'] = _candidates?.map((v) => v.toJson()).toList();
    }

    map['__v'] = _v;
    return map;
  }
}

class Candidates {
  Candidates({
    String? id,
    String? name,
    String? email,
    String? gender,
    num? age,
    num? phone,
    String? position,
    String? photo,
    String? party,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _gender = gender;
    _age = age;
    _phone = phone;
    _position = position;
    _photo = photo;
    _party = party;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Candidates.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _gender = json['gender'];
    _age = json['age'];
    _phone = json['phone'];
    _position = json['position'];
    _photo = json['photo'];
    _party = json['party'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _name;
  String? _email;
  String? _gender;
  num? _age;
  num? _phone;
  String? _position;
  String? _photo;
  String? _party;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  Candidates copyWith({
    String? id,
    String? name,
    String? email,
    String? gender,
    num? age,
    num? phone,
    String? position,
    String? photo,
    String? party,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      Candidates(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        gender: gender ?? _gender,
        age: age ?? _age,
        phone: phone ?? _phone,
        position: position ?? _position,
        photo: photo ?? _photo,
        party: party ?? _party,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
      );
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get gender => _gender;
  num? get age => _age;
  num? get phone => _phone;
  String? get position => _position;
  String? get photo => _photo;
  String? get party => _party;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['gender'] = _gender;
    map['age'] = _age;
    map['phone'] = _phone;
    map['position'] = _position;
    map['photo'] = _photo;
    map['party'] = _party;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}

class Parties {
  Parties({
    String? id,
    String? name,
    String? email,
    String? identification,
    String? password,
    String? description,
    String? createdAt,
    String? updatedAt,
    num? v,
    List<String>? candidates,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _identification = identification;
    _password = password;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _candidates = candidates;
  }

  Parties.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _identification = json['identification'];
    _password = json['password'];
    _description = json['description'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _candidates =
        json['candidates'] != null ? json['candidates'].cast<String>() : [];
  }
  String? _id;
  String? _name;
  String? _email;
  String? _identification;
  String? _password;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  List<String>? _candidates;
  Parties copyWith({
    String? id,
    String? name,
    String? email,
    String? identification,
    String? password,
    String? description,
    String? createdAt,
    String? updatedAt,
    num? v,
    List<String>? candidates,
  }) =>
      Parties(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        identification: identification ?? _identification,
        password: password ?? _password,
        description: description ?? _description,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
        candidates: candidates ?? _candidates,
      );
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get identification => _identification;
  String? get password => _password;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;
  List<String>? get candidates => _candidates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['identification'] = _identification;
    map['password'] = _password;
    map['description'] = _description;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['candidates'] = _candidates;
    return map;
  }
}
