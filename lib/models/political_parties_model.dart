class PoliticalPartiesModel {
  PoliticalPartiesMidel({
    String? id, 
      String? name, 
      String? email, 
      String? identification, 
      String? password, 
      String? description, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _name = name;
    _email = email;
    _identification = identification;
    _password = password;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  PoliticalPartiesModel.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _identification = json['identification'];
    _password = json['password'];
    _description = json['description'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
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
PoliticalPartiesModel copyWith({  String? id,
  String? name,
  String? email,
  String? identification,
  String? password,
  String? description,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => PoliticalPartiesModel(  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  identification: identification ?? _identification,
  password: password ?? _password,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
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
    return map;
  }

}