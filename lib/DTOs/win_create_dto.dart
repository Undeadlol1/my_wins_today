class WinCreateDTO {
  String title;
  String userId;
  bool isImportant;

  WinCreateDTO({
    required this.title,
    required this.userId,
    required this.isImportant,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'userId': this.userId,
      'isImportant': this.isImportant,
    };
  }
}
