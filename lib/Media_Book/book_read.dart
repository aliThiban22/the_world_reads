import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

import '../Media_Audio/audio_item.dart';
import '../network/api.dart';
import 'book_item.dart';

class Book_Read extends StatefulWidget {
  Book_Item _book_item;

  Book_Read(this._book_item);

  @override
  _Book_ReadState createState() => _Book_ReadState();
}

class _Book_ReadState extends State<Book_Read> {
  Size get screenSize => MediaQuery.of(context).size;
  WebViewXController webviewController;

  // خاص بالصوت
  Audio_item audio_item = new Audio_item();
  String Url ='';
  AudioPlayer player;
  bool isPlaying =false;
  Duration currentPostion = Duration();
  Duration musicLength = Duration();

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    setUp();
    get_data_audio();
  }

  get_data_audio() async {
    audio_item = await API.Song_Get(widget._book_item.id);
    Url = API.URL_SONG + audio_item.url ;
    setState(() {

    });
  }


  setUp(){
    player.onAudioPositionChanged.listen((d) {
      // Give us the current position of the Audio file
      setState(() {
        currentPostion = d;
      });

      player.onDurationChanged.listen((d) {
        //Returns the duration of the audio file
        setState(() {
          musicLength = d;
        });

      });

    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ازاله البانر العلويه
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.teal,
          title: Container(
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
              ],
            ),
              ),
        ),
        body:Container(
          child: Container(
              child: Column(
                children: [
                  Expanded(
                      flex: 5,
                      child: WebViewX(
                        initialContent:
                        "http://www.storys.esy.es/book/reading/reader.php?id=${widget._book_item.book_url.toString()}",
                        initialSourceType: SourceType.url,
                      )),

                  Expanded(
                    flex: 1,
                    child: get_AudioPlayers(),
                  )
                ],
              )),
        ),
      ),
    );
  }

  void showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(content),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  Widget get_AudioPlayers(){
    return Container(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(child: Text('${currentPostion.inSeconds}')),
                Container(
                  width: 260,
                    child: Slider(
                        value: currentPostion.inSeconds.toDouble(),
                        max: musicLength.inSeconds.toDouble(),
                        onChanged: (val) {
                          seekTo(val.toInt());
                        })
                ),
                Center(child: Text('${musicLength.inSeconds}')),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.first_page), iconSize: 35,
                  onPressed: () {
                    if (currentPostion.inSeconds == 0 ||
                        currentPostion.inSeconds < 10) {
                      seekTo(0);
                    } else if (currentPostion.inSeconds > 10) {
                      seekTo(currentPostion.inSeconds - 10);
                    }
                  },),
                IconButton(onPressed: () {
                  if (isPlaying) {
                    setState(() {
                      isPlaying = false;
                    });
                    stopMusic();
                  }
                  else {
                    setState(() {
                      isPlaying = true;
                    });
                    playMusic(Url);
                  }
                },
                  icon: isPlaying ? Icon(Icons.pause) :
                  Icon(Icons.play_arrow), iconSize: 35,),

                IconButton(
                  icon: Icon(Icons.last_page), iconSize: 35,
                  onPressed: () {
                    if (currentPostion < musicLength - Duration(seconds: 10)) {
                      seekTo(currentPostion.inSeconds + 10);
                    } else {}
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }



  playMusic(String song)
  { // to play the Audio
//    await player.play(Url);

    player.play(song);
  }
  stopMusic()
  {// to pause the Audio
    player.pause();
  }
  seekTo(int sec)
  {// To seek the audio to a new position
    player.seek(Duration(seconds: sec));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }

}
