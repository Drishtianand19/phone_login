class UserModel {
  String name;
  String email;
  String bio;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;

  UserModel(
      {required this.name,
      required this.email,
      required this.bio,
      required this.profilePic,
      required this.createdAt,
      required this.phoneNumber,
      required this.uid});

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      profilePic: map['profilePic'] ?? '',
      createdAt: map['createdAt'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      uid: map['uid'] ?? '',
    );
  }
  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "bio": bio,
      "profilePic": profilePic,
      "createdAt": createdAt,
      "phoneNumber": phoneNumber,
      "uid": uid,
    };
  }
}
