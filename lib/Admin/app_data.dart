
import '../users/user_data.dart';
import '../users/users_item.dart';

class App_Data {
  // استرجاع بيانات المستخدم
  static User_Item user_item = new User_Item();

  static getUserData() async {
    user_item = await User_Data.getUserData();
  }

  //جلب رقم المستخدم
  static int getUserID() {
    int id = 0;
    if (user_item.id == null) {
      id = 0;
    } else {
      id = App_Data.user_item.id;
    }
    return id;
  }

  // حساب تاريخ الشهر الصحيح
  static String getDate_month(int month) {
    String m = "";
    if (month < 10) {
      return m = "0$month";
    } else {
      return m = "$month";
    }
  }

  // حساب تاريخ اليوم الصحيح
  static String getDate_Day(int day) {
    String d = "";
    if (day < 10) {
      return d = "0$day";
    } else {
      return d = "$day";
    }
  }
}
