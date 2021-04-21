class WinCreateDTO {
  String title;
  String userId;

  WinCreateDTO({
    required this.title,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'userId': this.userId,
    };
  }
}
