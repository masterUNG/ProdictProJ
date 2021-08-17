import 'dart:convert';

class UserModel {
  final String name;
  final String password;
  final String type;
  UserModel({
    required this.name,
    required this.password,
    required this.type,
  });

  UserModel copyWith({
    String? name,
    String? password,
    String? type,
  }) {
    return UserModel(
      name: name ?? this.name,
      password: password ?? this.password,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
      'type': type,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      password: map['password'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(name: $name, password: $password, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.name == name &&
      other.password == password &&
      other.type == type;
  }

  @override
  int get hashCode => name.hashCode ^ password.hashCode ^ type.hashCode;
}
