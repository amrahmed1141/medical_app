class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? avatar;
  final DateTime? createdAt;

  UserModel({
    this.createdAt,
    required this.id,
    required this.email,
    this.name,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        id: json['id'] ?? '',
        email: json['email'] ?? '',
        name: json['name'],
        avatar: json['avatar']);
  }

  Map<String,dynamic> toJson(){
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'created_at': createdAt?.toIso8601String(),
    };
    }
    UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? avatar,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  }

