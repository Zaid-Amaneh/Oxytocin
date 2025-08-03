class UserProfileModel {
  final String id;
  final String name;
  final int age;
  final String? profileImage;
  final String? email;
  final String? phone;
  final String? address;
  final String? medicalHistory;
  final List<String> favorites;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.age,
    this.profileImage,
    this.email,
    this.phone,
    this.address,
    this.medicalHistory,
    this.favorites = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      profileImage: json['profile_image'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      medicalHistory: json['medical_history'],
      favorites: List<String>.from(json['favorites'] ?? []),
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'profile_image': profileImage,
      'email': email,
      'phone': phone,
      'address': address,
      'medical_history': medicalHistory,
      'favorites': favorites,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserProfileModel copyWith({
    String? id,
    String? name,
    int? age,
    String? profileImage,
    String? email,
    String? phone,
    String? address,
    String? medicalHistory,
    List<String>? favorites,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      profileImage: profileImage ?? this.profileImage,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      favorites: favorites ?? this.favorites,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
