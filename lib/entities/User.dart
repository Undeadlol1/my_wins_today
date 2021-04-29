class User {
  String id;
  String title;
  String email;
  int createdAt;
  int updatedAt;
  String picture;
  bool isImportant;
  String displayName;

  User({
    required this.id,
    required this.title,
    required this.email,
    required this.picture,
    required this.createdAt,
    required this.updatedAt,
    required this.isImportant,
    required this.displayName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'title': this.title,
      'picture': this.picture,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'isImportant': this.isImportant,
      'displayName': this.displayName,
    };
  }
}
