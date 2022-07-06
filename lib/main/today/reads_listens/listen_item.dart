class Listen_Item {
  int id;
  String title;
  String target;
  String type_video;
  String writer_name;
  int time_video;
  int time_end;
  String start_date;
  int type;
  int done;
  int key_user;

  Listen_Item(
      {this.id,
      this.title,
      this.target,
      this.type_video,
      this.writer_name,
      this.time_video,
      this.time_end,
      this.start_date,
      this.type,
      this.done,
      this.key_user});

  factory Listen_Item.fromJson(Map<String, dynamic> json) {
    return Listen_Item(
        id: json['id'],
        title: json['title'],
        target: json['target'],
        type_video: json['type_video'],
        writer_name: json['writer_name'],
        time_video: json['time_video'],
        time_end: json['time_end'],
        start_date: json['start_date'],
        type: json['type'],
        done: json['done'],
        key_user: json['key_user']);
  }
}
