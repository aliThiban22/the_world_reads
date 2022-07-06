class Plan_item_data {
  int id;
  int type;
  String title;
  int number_page;
  int number_page_end;
  String start_date;
  String end_date;
  int done;
  int key_user;

  Plan_item_data({
    this.id,
    this.type,
    this.title,
    this.number_page,
    this.number_page_end,
    this.start_date,
    this.end_date,
    this.done,
    this.key_user,
  });

  factory Plan_item_data.fromJson(Map<String, dynamic> json) {
    return Plan_item_data(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      number_page: json['number_page'],
      number_page_end: json['number_page_end'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      done: json['done'],
      key_user: json['key_user'],
    );
  }
}
