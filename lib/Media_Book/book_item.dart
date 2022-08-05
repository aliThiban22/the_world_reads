import 'package:flutter/material.dart';

import '../network/api.dart';
import 'book_pag.dart';

class Book_Item {
  int id;
  String title;
  String about;
  String img;
  String author;
  String voice_actor;
  String dar_alnasher;
  int number_print;
  String date_print;
  int number_parts;
  int number_pag_book;
  int number_minute;
  String name_list_main;
  String name_list_sub;
  String keywords;
  int price;
  String book_url;
  int type;
  int number_see;
  int esdaratna;
  int key_user;

  Book_Item(
      {this.id,
      this.title,
      this.about,
      this.img,
      this.author,
      this.voice_actor,
      this.dar_alnasher,
      this.number_print,
      this.date_print,
      this.number_parts,
      this.number_pag_book,
      this.number_minute,
      this.name_list_main,
      this.name_list_sub,
      this.keywords,
      this.price,
      this.book_url,
      this.type,
      this.number_see,
      this.esdaratna,
      this.key_user});

  factory Book_Item.fromJson(Map<String, dynamic> json) {
    return Book_Item(
        id: json['id'],
        title: json['title'],
        about: json['about'],
        img: json['img'],
        author: json['author'],
        voice_actor: json['voice_actor'],
        dar_alnasher: json['dar_alnasher'],
        number_print: json['number_print'],
        date_print: json['date_print'].toString(),
        number_parts: json['number_parts'],
        number_pag_book: json['number_pag_book'],
        number_minute: json['number_minute'],
        name_list_main: json['name_list_main'],
        name_list_sub: json['name_list_sub'],
        keywords: json['keywords'],
        price: json['price'],
        book_url: json['book_url'],
        type: json['type'],
        number_see: json['number_see'],
        esdaratna: json['esdaratna'],
        key_user: json['key_user']);
  }

  static Widget bookItemWidget(Book_Item bookItem, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Book_Pag(bookItem)));
      },
      child: Container(
          margin: const EdgeInsets.all(5.0),
          width: 170,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            child: SizedBox(
              height: 250,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                      child: Image.network(
                        API.URL_IMG_BOOK + bookItem.img,
                        fit: BoxFit.fill,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Center(
                          child: Text(
                        bookItem.title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(fontSize: 13),
                      ))),
                  Expanded(
                      flex: 1,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: Center(
                          child: Text(
                            '${bookItem.author}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
