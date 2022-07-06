class Read_item {
  int id;
  String title;
  int type;
  String writer_name;
  String library_name;
  String writer_date;
  int number_pages;
  String start_date;
  String end_date;
  int number_pages_end;
  int done;
  int key_user;

  Read_item(
      {this.id,
      this.title,
      this.type,
      this.writer_name,
      this.library_name,
      this.writer_date,
      this.number_pages,
      this.start_date,
      this.end_date,
      this.number_pages_end,
      this.done,
      this.key_user});

  factory Read_item.fromJson(Map<String, dynamic> json) {
    return Read_item(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      writer_name: json['writer_name'],
      library_name: json['library_name'],
      writer_date: json['writer_date'],
      number_pages: json['number_pages'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      number_pages_end: json['number_pages_end'],
      done: json['done'],
      key_user: json['key_user'],
    );
  }
}
