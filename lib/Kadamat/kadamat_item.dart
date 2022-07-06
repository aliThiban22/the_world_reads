import '../users/users_item.dart';

class Kadamat_Item {
  int id;
  String title;
  String body;
  String img;
  int price;
  int type;
  int number_day;
  int Done;
  String time_post;
  int key_user;
  User_Item user_items;

  Kadamat_Item(
      {this.id,
      this.title,
      this.body,
      this.img,
      this.price,
      this.type,
      this.number_day,
      this.Done,
      this.time_post,
      this.key_user,
      this.user_items});

  factory Kadamat_Item.fromJson(Map<String, dynamic> json) {
    return Kadamat_Item(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      img: json['img'],
      price: json['price'],
      type: json['type'],
      number_day: json['number_day'],
      Done: json['Done'],
      time_post: json['time_post'],
      key_user: json['key_user'],
      user_items: User_Item.fromJson(json['user_items']),
    );
  }
}
