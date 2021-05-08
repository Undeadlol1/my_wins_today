class Win {
  String id;
  String title;
  String userId;
  bool isImportant;
  List<String> likedByUsers;
  int createdAt;
  int updatedAt;

  Win({
    required this.id,
    required this.title,
    required this.userId,
    required this.isImportant,
    required this.createdAt,
    required this.updatedAt,
    required this.likedByUsers,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'userId': this.userId,
      'isImportant': this.isImportant,
      'likedByUsers': this.likedByUsers,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
    };
  }
}
