class Stars_item {
  int id;
  int star;
  int key_user;
  int key_book;

  Stars_item({this.id, this.star, this.key_user, this.key_book});

  factory Stars_item.fromJson(Map<String, dynamic> json) {
    return Stars_item(
        id: json['id'],
        star: json['star'],
        key_user: json['key_user'],
        key_book: json['key_book']);
  }
}
