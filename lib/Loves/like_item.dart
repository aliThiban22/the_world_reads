class Like_item {
  int id;
  int love;
  int key_user;
  int key_book;

  Like_item({this.id, this.love, this.key_user, this.key_book});

  factory Like_item.fromJson(Map<String, dynamic> json) {
    return Like_item(
        id: json['id'],
        love: json['love'],
        key_user: json['key_user'],
        key_book: json['key_book']);
  }
}
