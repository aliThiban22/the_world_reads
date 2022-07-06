class Store_Item {
  int id;
  int number_pages;
  int number_book;
  int number_minutes;
  String store_date;
  String store_date_b;
  int key_user;

  Store_Item(
      {this.id,
      this.number_pages,
      this.number_book,
      this.number_minutes,
      this.store_date,
      this.store_date_b,
      this.key_user});

  factory Store_Item.fromJson(Map<String, dynamic> json) {
    return Store_Item(
        id: json['id'],
        number_pages: json['number_pages'],
        number_book: json['number_book'],
        number_minutes: json['number_minutes'],
        store_date: json['store_date'],
        store_date_b: json['store_date_b'],
        key_user: json['key_user']);
  }
}
