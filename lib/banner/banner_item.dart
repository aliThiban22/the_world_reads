class Banner_Item {
  int id;
  String title;
  String name_Company;
  String about_company;
  String imageLink;
  String urlLink;
  int type;
  String startDate;
  String endDate;

  Banner_Item(
      {this.id,
      this.title,
      this.name_Company,
      this.about_company,
      this.imageLink,
      this.urlLink,
      this.type,
      this.startDate,
      this.endDate});

  factory Banner_Item.fromJson(Map<String, dynamic> json) {
    return Banner_Item(
        id: json['id'],
        title: json['title'],
        name_Company: json['name_Company'],
        about_company: json['about_company'],
        imageLink: json['imageLink'],
        urlLink: json['urlLink'],
        type: json['type'],
        startDate: json['startDate'],
        endDate: json['endDate']);
  }
}
