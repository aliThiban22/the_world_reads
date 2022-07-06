import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toggle_bar/toggle_bar.dart';

import '../Admin/app_data.dart';
import '../Comment/comment_item.dart';
import '../Loves/like_item.dart';
import '../Quotes/quotes_item.dart';
import '../Stars/stars_item.dart';
import '../network/api.dart';
import 'book_item.dart';
import 'book_read.dart';

class Book_Pag extends StatefulWidget {
  Book_Item _book_item;

  Book_Pag(this._book_item);

  @override
  _Book_PagState createState() => _Book_PagState();
}

class _Book_PagState extends State<Book_Pag> {
  final key_scaffold = GlobalKey<ScaffoldState>();
  final key_form_stat = GlobalKey<FormState>();
  String comm;

  dynamic int_stars_add = 0;
  int numbers = 0;
  int number_likes = 0;
  dynamic ssttaarrss = 0;
  List<String> labels = ["الاقتباسات", "التعليقات"];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    App_Data.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // ازاله البانر العلويه
        home: Scaffold(
            key: key_scaffold,
            appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(
                            widget._book_item.title,
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () {
                                /////////------
                              },
                              child: const Icon(
                                Icons.favorite_border,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ))),

//            key: key_scaffold,
            body: Container(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [

                            Expanded(
                                flex: 1,
                                child:Image.network(
                              API.URL_IMG_BOOK + widget._book_item.img,
                              fit: BoxFit.cover,
                              height: 300,
                              // width: double.infinity,
                              alignment: Alignment.center,
//                                 width: 100,
                            )),
                            Expanded(
                                flex: 1,
                                child:Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(widget._book_item.title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.teal)),
                                      Text(widget._book_item.author,
                                          textAlign: TextAlign.right),
                                    ],
                                  ),
                                )),
                          ],
                        )),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${widget._book_item.number_pag_book} صفحات '),
                        const Icon(
                          Icons.import_contacts,
                          size: 40,
                          color: Colors.teal,
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Text('${widget._book_item.number_minute} دقيقة '),
                        const Icon(
                          Icons.watch_later,
                          size: 40,
                          color: Colors.teal,
                        )
                      ],
                    ),

                    const Divider(),

                    stars_get(),

                    likes_get(),

                    const Divider(),

                    Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shadowColor: MaterialStateProperty.all(Colors.teal),
                            // الظل
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                            // الهامش
                            minimumSize: MaterialStateProperty.all(const Size(200, 20)),
                            //ألطول والعرض

                            // حواف مائلة
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green[700]),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Book_Read(widget._book_item)));
                          },
                          child: const Text("قراءة      |      استماع",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20))),
                    ),
                    Divider(),
                    Text('دار النشر :',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 16,
                        )),
                    Text(
                      '${widget._book_item.dar_alnasher}',
                      textDirection: TextDirection.rtl,
                    ),
                    Text('تاريخ النشر :',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            height: 5, color: Colors.teal, fontSize: 16)),
                    Text('${widget._book_item.date_print}',
                        textDirection: TextDirection.rtl),
                    Text('رقم الطبعة :',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            height: 5, color: Colors.teal, fontSize: 16)),
                    Text('${widget._book_item.number_print}',
                        textDirection: TextDirection.rtl),
                    Text('نبذة عن الكتاب :',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            height: 5, color: Colors.teal, fontSize: 16)),
                    Text('${widget._book_item.about}',
                        textDirection: TextDirection.rtl),
                    Divider(),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ToggleBar(
                            labels: labels,
                            backgroundColor: Colors.teal,
                            onSelectionUpdated: (index) =>
                                setState(() => currentIndex = index),
                          ),
                          getCommentAndQuotes(currentIndex),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                )))));
  }

  // جلب التعليقات والاقتباسات
  Widget getCommentAndQuotes(int index) {
    if (index == 1) {
      return comment_add();
    } else {
      return Container(
        child: getQuotes(),
      );
    }
  }

  // جلب التعليقات
  Widget getComment() {
    return FutureBuilder(
        future: API.Comment_Get(widget._book_item.id),
        // async work
        builder: (BuildContext contextBook,
            AsyncSnapshot<List<Comment_item>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Text('لا يوجد اتصال بالانترنت!');
              } else {
                return Container(
                  height: 1000,
                  child: ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            leading: Image.network(
                                "http://storys.esy.es/images/users/reading.png",width: 50,height: 50,),
                            // تعيين الأيقونة
                            title: Text(
                                "${snapshot.data[index].user_items.name}",
                                style: TextStyle(
                                    color: Colors.teal, fontSize: 16)),
                            subtitle: Text("${snapshot.data[index].comments}"),
                            onTap: () {},
                          ));
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
                );
              }
          }
        });
  }

  // اضافة تعليق
  Widget comment_add() {
    return Form(
      key: key_form_stat,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all(Colors.teal),
                      // الظل
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10)),
                      // حواف مائلة
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green[700]),
                    ),
                    onPressed: () {
                      if (key_form_stat.currentState.validate()) {
                        if (App_Data.getUserID() == 0) {
                          key_scaffold.currentState.showSnackBar(SnackBar(
                            content: Text("يجب تسجيل الدخول اولاً"),
                          ));
                        } else {
                          API.Comment_Add(comm, widget._book_item.id)
                              .then((comment) {
                            key_scaffold.currentState.showSnackBar(SnackBar(
                              content: Text("تم نشر التعليق"),
                            ));

                            setState(() {
                              getComment();
                            });
                          });
                        }
                      }
                    },
                    child: const Text("اضف تعليق",
                        style: TextStyle(color: Colors.white, fontSize: 14))),
              ),
              Expanded(
                flex: 3,
                child: TextFormField(
                  textAlign: TextAlign.end,
                  decoration: const InputDecoration(
                      hintText: 'اكتب تعليقك ...',
                      suffixIcon: Icon(Icons.short_text)),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty || value.length < 1) {
                      return "التعليق فارغ !";
                    } else {
                      comm = value;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          getComment(),
        ],
      ),
    );
  }

  // جلب الاقتباسات
  Widget getQuotes() {
    return FutureBuilder(
        future: API.Quotes_Get_Book(widget._book_item.id),
        // async work
        builder: (BuildContext contextBook,
            AsyncSnapshot<List<Quotes_item>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error: ${snapshot.error}');
              } else {
                return Container(
                  height: 1000,
                  child: ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            leading: Image.network(
                                "http://storys.esy.es/images/users/reading.png"),
                            // تعيين الأيقونة
                            title:
                                Text("${snapshot.data[index].user_items.name}",
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 20,
                                    )),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text.rich(TextSpan(
                                    text: 'اقتباس الكتاب :       ',
                                    children: [
                                      TextSpan(
                                          text:
                                              '${snapshot.data[index].quote_book}',
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontStyle: FontStyle.italic))
                                    ])),
                                Text(
                                    '-----------------------------------------'),
                                Text.rich(TextSpan(
                                    text: 'اقتباس المستخدم :       ',
                                    children: [
                                      TextSpan(
                                          text:
                                              '${snapshot.data[index].quote_user}',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.teal))
                                    ])),
                              ],
                            ),

                            onTap: () {},
                          ));
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
                );
              }
          }
        });
  }

  // جلب الاعجابات
  Widget likes_get() {
    return FutureBuilder(
        future: API.Love_Get(App_Data.user_item.id, widget._book_item.id),
        // async work
        builder: (BuildContext contextBook, AsyncSnapshot<Like_item> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Text('لا يوجد اتصال بالانترنت');
              } else {
                String icon_likes;

                if (App_Data.getUserID() == snapshot.data.key_user) {
                  icon_likes = 'images/like_add.png';
                } else {
                  icon_likes = 'images/like_delete.png';
                }
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.remove_red_eye,
                      color: Colors.teal,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(' المشاهدات : ${widget._book_item.number_see}',
                        textDirection: TextDirection.rtl),
                    const SizedBox(width: 50,),
                    InkWell(
                        onTap: () {
                          add_like();
                        },
                        child: Image.asset(
                          icon_likes,
                          width: 30,
                          height: 30,
                        )),
                    const SizedBox(width: 10),
                    Center(
                      child: Text(' الاعجابات : ${snapshot.data.love}',
                          textDirection: TextDirection.rtl),
                    ),
                  ],
                );
              }
          }
        });
  }

  //اضافة وحذف اعجاب
  add_like() {
    if (App_Data.getUserID() == 0) {
      key_scaffold.currentState.showSnackBar(SnackBar(
        content: Text("يجب تسجيل الدخول اولاً"),
      ));
      Fluttertoast.showToast(
          msg: 'يجب تسجيل الدخول اولاً',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    } else {
      API.Love_Add(App_Data.getUserID(), widget._book_item.id).then((st) {
        if (st != null || st.id != 0) {
          if (st.id == -1) {
            key_scaffold.currentState.showSnackBar(SnackBar(
              content: Text("تم حذف الاعجاب"),
            ));
            setState(() {});
          } else {
            key_scaffold.currentState.showSnackBar(SnackBar(
              content: Text("تم اضافة اعجاب"),
            ));
            setState(() {});
          }
        } else {
          //كلمة المرور غير صحيحة او لا يوجد اتصال بالشبكة
          Fluttertoast.showToast(
              msg: 'فشلت العملية',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.yellow);
        }
      });
    }
  }

  // جلب التقيممات
  Widget stars_get() {
    return FutureBuilder(
      future: API.Stars_Get(widget._book_item.id), // async work
      builder: (BuildContext contextBook, AsyncSnapshot<Stars_item> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              // print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.data == null) {
                numbers = 1;
                ssttaarrss = 1;
              } else {
                numbers = snapshot.data.key_user;
                ssttaarrss = snapshot.data.star;
              }
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: contextBook,
                          builder: (BuildContext conte) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0))),
                              contentPadding: EdgeInsets.only(top: 10.0),
                              content: Container(
                                width: 300.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Center(
                                      child: RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          int_stars_add = rating;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (int_stars_add == 0) {
                                          Fluttertoast.showToast(
                                              msg: "يجب تحديد تقييم اولاً",
                                              toastLength: Toast.LENGTH_SHORT,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.yellow);
                                        } else {
                                          if (App_Data.user_item.id == 0 ||
                                              App_Data.user_item.id == null) {
                                            Fluttertoast.showToast(
                                                msg: "يجب تسجيل الدخول اولاً",
                                                toastLength: Toast.LENGTH_SHORT,
                                                timeInSecForIosWeb: 3,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.yellow);
                                          } else {
                                            add_stars(int_stars_add, conte);
                                          }
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 20.0, bottom: 20.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF33b17c),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(32.0),
                                              bottomRight:
                                                  Radius.circular(32.0)),
                                        ),
                                        child: Text(
                                          "اضف تقييم",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.teal,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RatingBarIndicator(
                      rating: ssttaarrss.round() / numbers,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 30.0,
                      unratedColor: Colors.amber.withAlpha(50),
                      direction: Axis.horizontal,
                    ),
                  ),
                  Center(child: Text("التقييمات : $numbers", style: TextStyle(fontSize: 14),))
                ],
              );
            }
        }
      },
    );
  }

  // اضافة تقييم
  add_stars(dynamic star, BuildContext context) {
    API.Stars_Add(star, App_Data.getUserID(), widget._book_item.id).then((st) {
      if (st != null || st.id != 0) {
        key_scaffold.currentState.showSnackBar(SnackBar(
          content: Text("اضافة التقييم"),
        ));
        Navigator.pop(context);
        setState(() {});
      } else {
        //كلمة المرور غير صحيحة او لا يوجد اتصال بالشبكة
        Fluttertoast.showToast(
            msg: 'فشلت العملية ،، اضف قيم جديدة',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    });
  }
}
