class PayItem {
  int id;
  int key_user;
  int type;
  String date_start;
  String date_end;

  PayItem({this.id, this.key_user, this.type, this.date_start, this.date_end});

  factory PayItem.fromJson(Map<String, dynamic> json) {
    return PayItem(
      id: json['id'],
      key_user: json['key_user'],
      type: json['type'],
      date_start: json['date_start'],
      date_end: json['date_end'],
    );
  }
}
