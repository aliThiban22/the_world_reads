import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_world_reads/users/users_item.dart';

class User_Data {
  static saveUserData(
      int id,
      String name,
      String about,
      String email,
      String password,
      int sex,
      int age,
      String city,
      String country,
      String img) async {
    // تخزين البيانات
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("id", id);
    prefs.setString("name", name);
    prefs.setString("about", about);
    prefs.setString("email", email);
    prefs.setString("password", password);
    prefs.setInt("sex", sex);
    prefs.setInt("age", age);
    prefs.setString("city", city);
    prefs.setString("country", country);
    prefs.setString("img", img);
  }

  static Future<int> getUserDataId() async {
    // استرجاع البيانات
    int id = 0;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt("id");
    if (id == null) {
      id = 0;
    }
    return id;
  }

  static Future<User_Item> getUserData() async {
    // استرجاع البيانات
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User_Item item = new User_Item();
    item.id = prefs.getInt("id");
    item.name = prefs.getString("name");
    item.about = prefs.getString("about");
    item.email = prefs.getString("email");
    item.password = prefs.getString("password");
    item.sex = prefs.getInt("sex");
    item.age = prefs.getInt("age");
    item.city = prefs.getString("city");
    item.country = prefs.getString(prefs.getString("country"));
    item.img = prefs.getString("img");

    return item;
  }

  static removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print("تم");
//    prefs.remove("stringValue");
//    prefs.remove("boolValue");
//    prefs.remove("intValue");
//    prefs.remove("doubleValue");
  }
}
