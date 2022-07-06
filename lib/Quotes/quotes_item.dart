import '../users/users_item.dart';

class Quotes_item {
  int id;
  String quote_book;
  String quote_user;
  int key_user;
  int key_book;
  String date_quotes;
  int type;

  User_Item user_items;

  Quotes_item(
      {this.id,
      this.quote_book,
      this.quote_user,
      this.key_user,
      this.key_book,
      this.date_quotes,
      this.type,
      this.user_items});

  factory Quotes_item.fromJson(Map<String, dynamic> json) {
    return Quotes_item(
      id: json['id'],
      quote_book: json['quote_book'],
      quote_user: json['quote_user'],
      key_user: json['key_user'],
      key_book: json['key_book'],
      date_quotes: json['date_quotes'],
      type: json['type'],
      user_items: User_Item.fromJson(json['user_items']),
    );
  }
}
