class Win {
  String id;
  String title;
  String userId;
  bool isImportant;
  int createdAt;
  int updatedAt;

  Win({
    required this.id,
    required this.title,
    required this.userId,
    required this.isImportant,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'userId': this.userId,
      'isImportant': this.isImportant,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
    };
  }
}
