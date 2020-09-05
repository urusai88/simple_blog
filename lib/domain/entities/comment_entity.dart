class CommentEntity {
  int id;
  int postId;
  String name;
  String email;
  String body;

  CommentEntity({
    this.id,
    this.postId,
    this.name,
    this.email,
    this.body,
  });

  factory CommentEntity.fromJson(Map<String, dynamic> json) {
    return CommentEntity(
      id: json['id'],
      postId: json['postId'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}
