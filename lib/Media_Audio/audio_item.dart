class Audio_item {
  int id;
  String url;
  int key_book;

  Audio_item(
      {this.id,
        this.url,
        this.key_book,
      });

  factory Audio_item.fromJson(Map<String, dynamic> json) {
    return Audio_item(
        id: json['id'],
        url: json['url'],
        key_book: json['key_book']
    );
  }

}
