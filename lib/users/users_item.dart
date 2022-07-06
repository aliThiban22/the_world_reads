class User_Item {
  int id;
  String name;
  String about;
  String email;
  String password;
  int sex;
  int age;
  String city;
  String country;
  String img;

  User_Item(
      {this.id,
      this.name,
      this.about,
      this.email,
      this.password,
      this.sex,
      this.age,
      this.city,
      this.country,
      this.img});

  factory User_Item.fromJson(Map<String, dynamic> json) {
    return User_Item(
      id: json['id'],
      name: json['name'],
      about: json['about'],
      email: json['email'],
      password: json['password'],
      sex: json['sex'],
      age: json['age'],
      city: json['city'],
      country: json['country'],
      img: json['img'],
    );
  }
}
