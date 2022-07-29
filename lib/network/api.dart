//import 'package:http/http.dart' as x;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import '../Admin/app_data.dart';
import '../Comment/comment_item.dart';
import '../Kadamat/kadamat_item.dart';
import '../Loves/like_item.dart';
import '../Media_Audio/audio_item.dart';
import '../Media_Book/book_item.dart';
import '../Quotes/quotes_item.dart';
import '../Stars/stars_item.dart';
import '../banner/banner_item.dart';
import '../main/store/store_item.dart';
import '../main/store/store_item_plan.dart';
import '../main/today/plan/plan_item_data.dart';
import '../main/today/plan/plan_item_year.dart';
import '../main/today/reads_listens/goal_item.dart';
import '../main/today/reads_listens/listen_item.dart';
import '../main/today/reads_listens/read_item.dart';
import '../pay/pay_item.dart';
import '../users/user_data.dart';
import '../users/users_item.dart';

class API {
  static const String MAIN_URL = "http://storys.esy.es/api/";

  static const String URL_POST_BANNER = "http://storys.esy.es/images/banner/";

  static const String URL_POST_BANNER_IN_IMAGS =
      "http://storys.esy.es/images/banner/images/";

  static const String URL_IMG_USERS = "http://storys.esy.es/images/users/";

  static const String URL_IMG_KADAMAT = "http://storys.esy.es/images/kadamat/";

  static const String URL_IMG_BOOK =
      "http://storys.esy.es/book/img/"; //صور الكتاب
  static const String URL_BOOK =
      "http://www.storys.esy.es/book/reading/reader.php?id="; //قارئ الكتب
  static const String URL_SONG = "http://storys.esy.es/sound/"; //الصوت

  static const String _erorr = 'فشل الاتصال بالانترنت!';


  //    // --------------------------------| المستخدم |-----------------------------
  // تسجيل الدخول
  static Future<User_Item> user_login(String email, String password) async {
    final Response response = await post(Uri.parse('$MAIN_URL/User_Login.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }));

    if (response.statusCode == 200) {
      print(response.body);

      if (User_Item.fromJson(json.decode(response.body)).id != null) {

        return User_Item.fromJson(json.decode(response.body));

      } else {
        Fluttertoast.showToast(
            msg: 'الايميل او كلمة المرور غير صحيحة!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }

    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  //اضافة مستخدم
  static Future<User_Item> user_Sing_Up(
      String name, String email, String password) async {
    final Response response = await post(Uri.parse('$MAIN_URL/User_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "about": " ",
          "email": email,
          "password": password,
          "sex": 1,
          "age": 0,
          "city": " ",
          "country": " ",
          "img": " ",
        }));

    if (response.statusCode == 200) {
      App_Data.user_item = User_Item.fromJson(json.decode(response.body));
//      print(response.body);
      if (User_Item.fromJson(json.decode(response.body)).id != null) {
        return User_Item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'الايميل او كلمة المرور غير صحيحة!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  // تعديل بيانات المستخدم
  static Future<User_Item> User_Updata(String name, String email, String password, int age, String country) async {
    final Response response = await post(Uri.parse('$MAIN_URL/User_Updata.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": await User_Data.getUserDataId(),
          "name": name,
          "about": " ",
          "email": email,
          "password": password,
          "sex": 1,
          "age": age,
          "city": " ",
          "country": country,
          "img": " ",
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (User_Item.fromJson(json.decode(response.body)).id != null) {
        return User_Item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'الايميل او كلمة المرور غير صحيحة!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  // حذف المستخدم
  static Future<User_Item> User_delete(int id) async {
    final Response response = await post(Uri.parse('$MAIN_URL/User_delete.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, int>{
          "id": id
        }));

    if (response.statusCode == 200) {
      print(response.body);

      if (User_Item.fromJson(json.decode(response.body)).id != null) {

        return User_Item.fromJson(json.decode(response.body));

      } else {
        Fluttertoast.showToast(
            msg: 'الايميل او كلمة المرور غير صحيحة!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }

    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

//    // --------------------------------| عمليات الشراء |-----------------------------
  // جلب الشراء الحقيقي
  static Future<PayItem> Pay_Real_Get() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Pay_Real_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "key_user": await User_Data.getUserDataId(),
        }));

    if (response.statusCode == 200) {
//      print(response.body);
      if (PayItem.fromJson(json.decode(response.body)).id != null) {
        return PayItem.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // اضافة شراء حقيقي
  static Future<PayItem> Pay_Real_Add() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Pay_Real_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "key_user": await User_Data.getUserDataId(),
        }));

    if (response.statusCode == 200) {
//      print(response.body);
      if (PayItem.fromJson(json.decode(response.body)).id != null) {
        return PayItem.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // جلب بيانات الخطة المجانية
  static Future<PayItem> Pay_Free_Get() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Pay_Free_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "key_user": await User_Data.getUserDataId(),
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (PayItem.fromJson(json.decode(response.body)).id != null) {
        return PayItem.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }
  // التاكد بيانات الخطة المجانية
  static Future<PayItem> Pay_Free_Get_user() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Pay_Free_Get_user.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "key_user": await User_Data.getUserDataId(),
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (PayItem.fromJson(json.decode(response.body)).id != null) {
        return PayItem.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }


//    // --------------------------------| القراءة و الاستماع |-----------------------------
  //-----------السنة
  // عرض  تحدي العام
  static Future<Goal_item> GoalYearBook_Get() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/GoalYearBook_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "key_user": await User_Data.getUserDataId(),
        }));

    if (response.statusCode == 200) {
//      print(response.body);
      if (Goal_item.fromJson(json.decode(response.body)).id != null) {
        return Goal_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // اضافة تحدي العام
  static Future<Goal_item> GoalYearBook_Add(
      int number_book_year, int number_song_year, String number_year) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/GoalYearBook_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "number_book_year": number_book_year,
          "number_book_year_done": 0,
          "number_song_year": number_song_year,
          "number_song_year_done": 0,
          "number_year": number_year,
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Goal_item.fromJson(json.decode(response.body)).id != null) {
        return Goal_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // تعديل تحدي العام
  static Future<Goal_item> GoalYearBook_Updata(
      int id,
      int number_book_year,
      int number_song_year,
      int number_book_year_done,
      int number_song_year_done,
      int number_year) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/GoalYearBook_Updata.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "number_book_year": number_book_year,
          "number_book_year_done": number_book_year_done,
          "number_song_year": number_song_year,
          "number_song_year_done": number_song_year_done,
          "number_year": number_year,
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Goal_item.fromJson(json.decode(response.body)).id != null) {
        return Goal_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  //------------ البيانات القراءة
  // جلب بيانات لاقراءة
  static Future<List<Read_item>> Reads_Get() async {
    final Response response = await post(Uri.parse('$MAIN_URL/Reads_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"key_user": await User_Data.getUserDataId()}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Read_item>((item) => Read_item.fromJson(item)).toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }
  // جلب بيانات لاقراءة المنجزة
  static Future<List<Read_item>> Reads_Get_Done() async {
    final Response response = await post(Uri.parse('$MAIN_URL/Reads_Get_Done.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Read_item>((item) => Read_item.fromJson(item)).toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  // اضافة كتاب للقراءة
  static Future<Read_item> Reads_Add(String title, String writer_name,
      String library_name, int number_pages, String start_date) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Reads_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "type": 1,
          "writer_name": writer_name,
          "library_name": library_name,
          "writer_date": " ",
          "number_pages": number_pages,
          "start_date": start_date,
          "number_pages_end": 0,
          "done": 1,
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Read_item.fromJson(json.decode(response.body)).id != null) {
        return Read_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // تعديل كتاب
  static Future<Read_item> Reads_Updata_All(
      int id, String title, String writer_name, String library_name,
      int number_pages, String start_date ) async {

    final Response response = await post(
        Uri.parse('$MAIN_URL/Reads_Updata_All.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "title": title,
          "writer_name": writer_name,
          "library_name": library_name,
          "writer_date": "no",
          "number_pages": number_pages,
          "start_date": start_date,
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Read_item.fromJson(json.decode(response.body)).id != null) {
        return Read_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // حذف كتاب
  static Future<Read_item> Reads_Delete(int id) async {

    final Response response = await post(
        Uri.parse('$MAIN_URL/Reads_Delete.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": id
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Read_item.fromJson(json.decode(response.body)).id != null) {
        return Read_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }


  // تعديل  انجاز كتاب للقراءة
  static Future<Read_item> Reads_Updata(
      int id, int done, int number_pages_end) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Reads_Updata.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "done": done,
          "number_pages_end": number_pages_end,
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Read_item.fromJson(json.decode(response.body)).id != null) {
        return Read_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  //-------------------------- البيانات الاستماع
  // جلب بيانات الاستماع
  static Future<List<Listen_Item>> Listen_Get() async {
    final Response response = await post(Uri.parse('$MAIN_URL/Listen_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"key_user": await User_Data.getUserDataId()}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Listen_Item>((item) => Listen_Item.fromJson(item))
          .toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }
  // جلب بيانات الاستماع المنجزة
  static Future<List<Listen_Item>> Listen_Get_Done() async {
    final Response response = await post(Uri.parse('$MAIN_URL/Listen_Get_Done.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Listen_Item>((item) => Listen_Item.fromJson(item)).toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }


  // اضافة استماع جديد
  static Future<Read_item> Listen_Add(
      String title,
      String target,
      String type_video,
      String writer_name,
      int time_video,
      String start_date) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Listen_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "type": 2,
          "target": target,
          "type_video": type_video,
          "writer_name": writer_name,
          "time_video": time_video,
          "start_date": start_date,
          "time_end": 0,
          "done": 1,
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Read_item.fromJson(json.decode(response.body)).id != null) {
        return Read_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // تعديل بيانات استماع
  static Future<Read_item> Listen_Updata_All( int id ,
      String title,
      String target,
      String type_video,
      String writer_name,
      int time_video,
      String start_date) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Listen_Updata_All.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "title": title,
          "type": 2,
          "target": target,
          "type_video": type_video,
          "writer_name": writer_name,
          "time_video": time_video,
          "start_date": start_date,
          "time_end": 0,
          "done": 1,
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Read_item.fromJson(json.decode(response.body)).id != null) {
        return Read_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // حذف استماع
  static Future<Read_item> Listen_Delete(int id) async {

    final Response response = await post(
        Uri.parse('$MAIN_URL/Listen_Delete.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": id
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Read_item.fromJson(json.decode(response.body)).id != null) {
        return Read_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }


  // تعديل انجاز برنامج صوتي
  static Future<Read_item> Listen_Updata(int id, int done, int time_end) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Listen_Updata.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "done": done,
          "time_end": time_end,
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Read_item.fromJson(json.decode(response.body)).id != null) {
        return Read_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

//    // --------------------------------| الخدمات |-----------------------------
  static Future<List<Kadamat_Item>> Kadamat_Get(int type) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Kadamat_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"type": type}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Kadamat_Item>((item) => Kadamat_Item.fromJson(item))
          .toList();

//      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//      return parsed.map<Comment_item>((item) => Comment_item.fromJson(item))
//          .toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  static Future<Kadamat_Item> Kadamat_Add(String title, String body,
      String img, int price, int type, int number_day, String time_post, BuildContext cxn) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Kadamat_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "body": body,
          "img": img,
          "price": price,
          "type": type,
          "number_day": number_day,
          "Done": 0,
          "time_post": time_post,
          "city": " ",
          "country": " ",
          "key_user": App_Data.getUserID()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      Navigator.pop(cxn);

      if (Kadamat_Item.fromJson(json.decode(response.body)) != null) {
        return Kadamat_Item.fromJson(json.decode(response.body));

      } else {
        Fluttertoast.showToast(
            msg: _erorr,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

//    // --------------------------------| الخطة البحثية |-----------------------------
  //-----------السنة
  // جلب بيانات السنة
  static Future<Plan_item_year> Plan_Year_Get() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Plan_Year_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "key_user": await User_Data.getUserDataId(),
        }));

    if (response.statusCode == 200) {
//      print(response.body);
      if (Plan_item_year.fromJson(json.decode(response.body)).id != null) {
        return Plan_item_year.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // اضافة تحدي العام
  static Future<Plan_item_year> Plan_Year_Add(
      int number_hour,
      int number_article,
      int number_search,
      int number_book,
      String number_year) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Plan_Year_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "number_hour": number_hour,
          "number_article": number_article,
          "number_search": number_search,
          "number_book": number_book,
          "number_year": number_year,
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Plan_item_year.fromJson(json.decode(response.body)).id != null) {
        return Plan_item_year.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // تعديل تحدي العام
  static Future<Plan_item_year> Plan_Year_Updata(
      int id,
      int number_hour,
      int number_article,
      int number_search,
      int number_book,
      String number_year) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Plan_Year_Updata.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "number_hour": number_hour,
          "number_article": number_article,
          "number_search": number_search,
          "number_book": number_book,
          "number_year": number_year,
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Plan_item_year.fromJson(json.decode(response.body)).id != null) {
        return Plan_item_year.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // تعديل الخطة للسنة بالبيانات المنجزة
  static Future<Plan_item_year> Plan_Year_Updata_Done(
      int id,
      int number_hour_done,
      int number_article_done,
      int number_search_done,
      int number_book_done) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Plan_Year_Updata_Done.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "number_hour_done": number_hour_done,
          "number_article_done": number_article_done,
          "number_search_done": number_search_done,
          "number_book_done": number_book_done,
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Plan_item_year.fromJson(json.decode(response.body)).id != null) {
        return Plan_item_year.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: _erorr,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  //------------------------------ البيانات
  // جلب بيانات الخطة البحثية
  static Future<List<Plan_item_data>> Plan_Data_Get() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Plan_Data_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"key_user": await User_Data.getUserDataId()}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Plan_item_data>((item) => Plan_item_data.fromJson(item))
          .toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  // جلب بيانات الخطة البحثية المنجزة
  static Future<List<Plan_item_data>> Plan_Data_Get_Done() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Plan_Data_Get_Done.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Plan_item_data>((item) => Plan_item_data.fromJson(item))
          .toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  // اضافة بيانات خطة بحثية
  static Future<Read_item> Plan_Data_Add(
      int type, String title, int number_page, String start_date) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Plan_Data_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "type": type,
          "title": title,
          "number_page": number_page,
          "start_date": start_date,
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Read_item.fromJson(json.decode(response.body)).id != null) {
        return Read_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // تعديل بيانات خطة بحثية
  static Future<Read_item> Plan_Data_Updata(int id, int type, String title,
      int number_page, int number_page_end, int done, String start_date) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Plan_Data_Updata.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "type": type,
          "title": title,
          "number_page": number_page,
          "number_page_end": number_page_end,
          "done": done,
          "start_date": start_date,
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Read_item.fromJson(json.decode(response.body)).id != null) {
        return Read_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'لا توجد بيانات اشتراك للمستخدم',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

//    // --------------------------------| الرصيد المعرفي |-----------------------------
  // جلب الكتب و الاستماع
  static Future<List<Store_Item>> StoreBook_Get() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/StoreBook_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"key_user": await User_Data.getUserDataId()}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Store_Item>((item) => Store_Item.fromJson(item))
          .toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  // جلب الخطة البحثية
  static Future<List<Store_Item_Plan>> StorePlan_Get() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/StorePlan_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"key_user": await User_Data.getUserDataId()}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Store_Item_Plan>((item) => Store_Item_Plan.fromJson(item))
          .toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  // اضافة بيانات رصيد الكتب والاستماع
  static Future<Store_Item_Plan> StoreBook_Add(int number_pages,
      int number_book, int number_minutes, String store_date) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/StoreBook_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "number_pages": number_pages,
          "number_book": number_book,
          "number_minutes": number_minutes,
          "store_date": store_date,
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Store_Item_Plan.fromJson(json.decode(response.body)).id != null) {
        return Store_Item_Plan.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: '11111',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

  // اضافة بيانات رصيد الخطة بحثية
  static Future<Store_Item_Plan> StorePlan_Add(
      int number_articles,
      int number_search,
      int number_books,
      int number_pages,
      String store_date) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/StorePlan_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "number_articles": number_articles,
          "number_search": number_search,
          "number_books": number_books,
          "number_pages": number_pages,
          "number_hours": 0,
          "store_date": store_date,
          "key_user": await User_Data.getUserDataId()
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Store_Item_Plan.fromJson(json.decode(response.body)).id != null) {
        return Store_Item_Plan.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: '11111',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
//      throw Exception('فشل الاتصال بالانترنت !');
    }
  }

//    // --------------------------------| البانر |-----------------------------
  static Future<List<Banner_Item>> Banner_Get() async {
    final Response response = await post(Uri.parse('$MAIN_URL/Banner_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"id": 1}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Banner_Item>((item) => Banner_Item.fromJson(item))
          .toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

//    // --------------------------------| الكتب |-----------------------------
  // البحث للكتب
  static Future<List<Book_Item>> Book_Find(String title) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Book_Find.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"title": title}));

    if (response.statusCode == 200) {
     print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Book_Item>((item) => Book_Item.fromJson(item)).toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }



  // جميع الكتب
  static Future<List<Book_Item>> Book_Get_All() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Book_Get_All.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"id": 1}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Book_Item>((item) => Book_Item.fromJson(item)).toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  // كتب الرئيسية
  static Future<List<Book_Item>> Book_Get_MainActivity() async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Book_Get_MainActivity.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"id": 1}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Book_Item>((item) => Book_Item.fromJson(item)).toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  // كتب القوائم
  static Future<List<Book_Item>> Book_Lists(String name_list_main) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Book_Lists.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "name_list_main": name_list_main,
          "esdaratna": 1,
        }));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Book_Item>((item) => Book_Item.fromJson(item)).toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  //    // --------------------------------| الاقتباسات |-----------------------------
  //جلب الاقتباسات
  static Future<List<Quotes_item>> Quotes_Get_Book(int key_book) async {
    final Response response = await post(
        Uri.parse('$MAIN_URL/Quotes_Get_Book.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"key_book": key_book}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Quotes_item>((item) => Quotes_item.fromJson(item))
          .toList();

//      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//      return parsed.map<Comment_item>((item) => Comment_item.fromJson(item))
//          .toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  // اضافة اقتباس
  static Future<Quotes_item> Quotes_Add(String comment, int key_book) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Quotes_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "comments": comment,
          "key_book": key_book,
          "key_user": await User_Data.getUserDataId(),
          "type": 1
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Quotes_item.fromJson(json.decode(response.body)) != null) {
        return Quotes_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'الايميل او كلمة المرور غير صحيحة!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

//    // --------------------------------| التعليقات |-----------------------------
  static Future<List<Comment_item>> Comment_Get(int key_book) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Comment_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"key_book": key_book}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Comment_item>((item) => Comment_item.fromJson(item))
          .toList();

//      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//      return parsed.map<Comment_item>((item) => Comment_item.fromJson(item))
//          .toList();
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  // اضافة تعليق
  static Future<Comment_item> Comment_Add(String comment, int key_book) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Comment_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "comments": comment,
          "key_book": key_book,
          "key_user": await User_Data.getUserDataId(),
          "type": 1
        }));

    if (response.statusCode == 200) {
      print(response.body);
      if (Comment_item.fromJson(json.decode(response.body)) != null) {
        return Comment_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: 'الايميل او كلمة المرور غير صحيحة!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } else {
      Fluttertoast.showToast(
          msg: _erorr,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  //    // --------------------------------| الاعجابات |-----------------------------
  static Future<Like_item> Love_Get(int key_user, int keyBook) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Love_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "key_user": await User_Data.getUserDataId(),
          "key_book": keyBook
        }));

    if (response.statusCode == 200) {
      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      if (Like_item.fromJson(json.decode(response.body)) != null) {
        return Like_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: "لا توجد اعجابات للكتاب",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    }
  }

  static Future<Like_item> Love_Add(int keyUser, int key_book) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Love_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "love": 1,
          "key_user": await User_Data.getUserDataId(),
          "key_book": key_book,
        }));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      if (Like_item.fromJson(json.decode(response.body)) != null) {
        return Like_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: _erorr,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    }
  }

//    // --------------------------------| التقيممات |-----------------------------
  static Future<Stars_item> Stars_Add(
      double star, int keyUser, int key_book) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Stars_Add.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "star": star,
          "key_user": await User_Data.getUserDataId(),
          "key_book": key_book,
        }));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      if (Stars_item.fromJson(json.decode(response.body)).id != null) {
        if (Stars_item.fromJson(json.decode(response.body)).id == -1) {
          Fluttertoast.showToast(
              msg: "لقد قمت بالتقييم مسبقاً",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.yellow);
        } else {
          return Stars_item.fromJson(json.decode(response.body));
        }
      } else {
        Fluttertoast.showToast(
            msg: _erorr,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    }
  }

  static Future<Stars_item> Stars_Get(int keyBook) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Stars_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"key_book": keyBook}));

    if (response.statusCode == 200) {
//      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      if (Stars_item.fromJson(json.decode(response.body)).star != null) {
        return Stars_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: "لا توجد تقييمات للكتاب",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    }
  }

//    // --------------------------------| الصوتيات |-----------------------------
  static Future<Audio_item> Song_Get(int keyBook) async {
    final Response response = await post(Uri.parse('$MAIN_URL/Song_Get.php'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{"key_book": keyBook}));

    if (response.statusCode == 200) {
      print(response.body);
//    return FoodItemApi.fromJson(json.decode(response.body));
      if (Audio_item.fromJson(json.decode(response.body)) != null) {
        return Audio_item.fromJson(json.decode(response.body));
      } else {
        Fluttertoast.showToast(
            msg: "لا توجد تقييمات للكتاب",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    }
  }

}
