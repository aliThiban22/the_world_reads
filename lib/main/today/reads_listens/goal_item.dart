class Goal_item {
  int id;
  int number_book_year;
  int number_book_year_done;
  int number_song_year;
  int number_song_year_done;
  int number_year;
  int key_user;

  Goal_item(
      {this.id,
      this.number_book_year,
      this.number_book_year_done,
      this.number_song_year,
      this.number_song_year_done,
      this.number_year,
      this.key_user});

  factory Goal_item.fromJson(Map<String, dynamic> json) {
    return Goal_item(
        id: json['id'],
        number_book_year: json['number_book_year'],
        number_book_year_done: json['number_book_year_done'],
        number_song_year: json['number_song_year'],
        number_song_year_done: json['number_song_year_done'],
        number_year: json['number_year'],
        key_user: json['key_user']);
  }
}
