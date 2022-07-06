class Read_And_Listen_item {
  int id;
  String title;
  String day;
  int number_pages;
  int number_stop;
  int number_end;
  int number_days;
  int is_done;
  int type;

  Read_And_Listen_item(
      {this.id,
      this.title,
      this.day,
      this.number_pages,
      this.number_stop,
      this.number_end,
      this.number_days,
      this.is_done,
      this.type});

  factory Read_And_Listen_item.fromJson(Map<String, dynamic> json) {
    return Read_And_Listen_item(
        id: json['id'],
        title: json['title'],
        day: json['day'],
        number_pages: json['number_pages'],
        number_stop: json['number_stop'],
        number_end: json['number_end'],
        number_days: json['number_days'],
        is_done: json['is_done'],
        type: json['type']);
  }
}
