class User {
  String id;
  String image;
  String displayName;
  int createdAt;
  int updatedAt;

  User({
    required this.id,
    required this.displayName,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userId': this.image,
      'displayName': this.displayName,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
    };
  }
}
