class CandidatesModel {
  CandidatesModel ({
    String? id,
    String? name,
    String? email,
    String? gender,
    num? age,
    num? phone,
    String? position,
    String? photo,
    Party? party,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) {
    _id= id;
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

  CandidatesModel.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _gender= json['gender'];
    _age = json['age'];
    _phone = json['phone'];
    _position = json['position'];
    _photo = json['photo'];
    _party = json['party'] != null ? Party.fromJson(json['party']) : null;
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
  Party? _party;
  String? _createdAt;
  String? _updatedAt;
  num? _v;


  CandidatesModel copywith({ String? id,
  String? name,
  String? email,
  String? gender,
  num? age,
  num? phone,
  String? position,
  String? photo,
  Party? party,
  String? createdAt,
  String? updatedAt,
  num? v,  }) => CandidatesModel (id: id ?? _id, 
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
  Party? get party => _party;
  String? get createdAt => _createdAt;
  String? get updateAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic>toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['gender'] = _gender;
    map['age'] = _age;
    map['phone'] = _phone;
    map['position'] = _position;
    map['photo'] = _photo;
    if (party != null) {
      map['party'] = _party?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;

    return map;
  }

}





class Party {
  Party({
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

  Party.fromJson(dynamic json){
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _identification = json['identification'];
    _password = json['password'];
    _description = json['description'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _candidates = json['candidates'] != null ? json['candidates'].
    cast<String>() : [];
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


  Party copywith({String? id,
  String? name,
  String? email,
  String? identification,
  String? password,
  String? description,
  String? createdAt,
  String? updatedAt,
  num? v,
  List<String>? candidates,
  
  }) => Party(id: id ?? _id,
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
    map['identification']= _identification;
    map['password']= _password;
    map['description']= _description;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v']= _v;
    map['candidates'] = candidates;

    return map;

  }



}