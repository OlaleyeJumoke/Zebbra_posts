class PostModel {
    PostModel({
        this.postId,
        this.id,
        this.title,
        this.body,
    });

    int? postId;
    int? id;
    String? title;
    String? body;

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        postId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "title": title,
        "body": body,
    };
}
