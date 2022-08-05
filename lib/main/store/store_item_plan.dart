class Store_Item_Plan {
  int id;
  int number_pages;
  int number_search;
  int number_books;
  int number_articles;
  int number_hours;
  String store_date;
  String store_date_b;
  int key_user;

  Store_Item_Plan(
      {this.id,
      this.number_pages,
      this.number_search,
      this.number_books,
      this.number_articles,
      this.number_hours,
      this.store_date,
      this.store_date_b,
      this.key_user});

  factory Store_Item_Plan.fromJson(Map<String, dynamic> json) {
    return Store_Item_Plan(
        id: json['id'],
        number_pages: json['number_pages'],
        number_search: json['number_search'],
        number_books: json['number_books'],
        number_articles: json['number_articles'],
        number_hours: json['number_hours'],
        store_date: json['store_date'],
        store_date_b: json['store_date_b'],
        key_user: json['key_user']);
  }
}
