class PostEntity {
  final int id;
  final int userId;
  final String title;
  final String body;

  PostEntity({this.id, this.userId, this.title, this.body});

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}
