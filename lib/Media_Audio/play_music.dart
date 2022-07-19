import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
class PlayMusic extends StatefulWidget {
  const PlayMusic({Key key}) : super(key: key);

  @override
  _PlayMusicState createState() => _PlayMusicState();
}


class _PlayMusicState extends State<PlayMusic> {
  String Url = 'http://storys.esy.es/sound/الصحافة_المتخصصة.mp3';
  AudioPlayer player;
  bool isPlaying =false;
  Duration currentPostion = Duration();
  Duration musicLength = Duration();
//  int index =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player = AudioPlayer();
//    index = 0;
    setUp();
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
    return Scaffold(
      body: Container(
        height: 150,
        color: Colors.teal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${currentPostion.inSeconds}'),
                Container(
                    width: 280,
                    child: Slider(
                        value: currentPostion.inSeconds.toDouble(),
                        max: musicLength.inSeconds.toDouble(),
                        onChanged: (val){
                          seekTo(val.toInt());
                        })
                ),
                Text('${musicLength.inSeconds}'),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.first_page), iconSize: 35,
                  onPressed: (){
                    if(currentPostion.inSeconds == 0 || currentPostion.inSeconds < 10) {
                      seekTo(0);

                    }else if (currentPostion.inSeconds > 10 ) {
                      seekTo(currentPostion.inSeconds - 10);
                    }
                }, ),
                IconButton(onPressed: (){
                 if(isPlaying)
                   {
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
                  icon: isPlaying?Icon(Icons.pause):
                  Icon(Icons.play_arrow), iconSize: 35,),

                IconButton(
                  icon: Icon(Icons.last_page), iconSize: 35,
                  onPressed: (){
                    if(currentPostion < musicLength - Duration(seconds: 10)){
                      seekTo(currentPostion.inSeconds + 10);

                    }else{
                    }
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
