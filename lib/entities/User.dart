class User {
  String id;
  String email;
  int createdAt;
  int updatedAt;
  String picture;
  String displayName;

  User({
    required this.id,
    required this.email,
    required this.picture,
    required this.createdAt,
    required this.updatedAt,
    required this.displayName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'picture': this.picture,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'displayName': this.displayName,
    };
  }
}
