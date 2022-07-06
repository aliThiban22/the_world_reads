class Plan_item_year {
  int id;
  int number_hour;
  int number_hour_done;
  int number_article;
  int number_article_done;
  int number_search;
  int number_search_done;
  int number_book;
  int number_book_done;
  String number_year;
  int key_user;

  Plan_item_year(
      {this.id,
      this.number_hour,
      this.number_hour_done,
      this.number_article,
      this.number_article_done,
      this.number_search,
      this.number_search_done,
      this.number_book,
      this.number_book_done,
      this.number_year,
      this.key_user});

  factory Plan_item_year.fromJson(Map<String, dynamic> json) {
    return Plan_item_year(
        id: json['id'],
        number_hour: json['number_hour'],
        number_hour_done: json['number_hour_done'],
        number_article: json['number_article'],
        number_article_done: json['number_article_done'],
        number_search: json['number_search'],
        number_search_done: json['number_search_done'],
        number_book: json['number_book'],
        number_book_done: json['number_book_done'],
        key_user: json['key_user']);
  }
}
