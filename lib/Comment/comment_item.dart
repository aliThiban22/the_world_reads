import '../users/users_item.dart';

class Comment_item {
  int id;
  String comments;
  int key_user;
  int key_book;
  int type;
  String date_comment;
  User_Item user_items;

  Comment_item(
      {this.id,
      this.comments,
      this.key_user,
      this.key_book,
      this.type,
      this.date_comment,
      this.user_items});

  factory Comment_item.fromJson(Map<String, dynamic> json) {
    return Comment_item(
      id: json['id'],
      comments: json['comments'],
      key_user: json['key_user'],
      key_book: json['key_book'],
      type: json['type'],
      date_comment: json['date_comment'],
      user_items: User_Item.fromJson(json['user_items']),
    );
  }
}
