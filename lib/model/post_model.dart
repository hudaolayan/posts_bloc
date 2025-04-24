class PostModel {
  int? userId;
  int? id;
  String? title;
  String? body;
  bool? isLoading;

  PostModel({this.userId, this.id, this.title, this.body,this.isLoading});

  PostModel.fromJson({required Map<String, dynamic> json}) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
    isLoading=false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
