import 'dart:core';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mediaboster3/data/models/Music_Model.dart';

class AudioPlayerPage extends StatefulWidget {
   AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  List <MusicModel>music=[
    MusicModel(musicName: 'Tu Hai Wahi',
        author:'Asha Bhosle',
        cover: 'assets/tu.jpeg',
        path: 'old.mp3'),
    MusicModel(musicName: 'What Jhumka',
        author:'Mukesh',
        cover: 'assets/jhumka.webp',
        path: 'What.mp3'),
    MusicModel(
        musicName: 'Bheegi Bheegi raaton mein',
        author: 'asha bhosle',
        cover: 'assets/bheegi.jpeg',
        path:'Bheegi.mp3'),
    MusicModel(
        musicName: 'Nazar ke samne',
        author: 'kumar sanu',
        cover: 'assets/nazar.jpeg',
        path:'nazar.mp3'),
    MusicModel(
        musicName: 'Yeh raaten yeh mausam',
        author: 'kumar',
        cover: 'assets/yeh.webp',
        path:'Yeh.mp3'),
    MusicModel(
        musicName: 'Dil to pagal hai',
        author: 'jaydev',
        cover: 'assets/dil.jpeg',
        path:'new.mp3'),

  ];

  int currentMusic=0;
  bool isPlaying=false;
  Duration duration=Duration.zero;
  Duration position=Duration.zero;
   final player = AudioPlayer();
   String formatTime(int seconds){
     return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8,'0');
   }
   void initState(){
     super.initState();
     player.onPlayerStateChanged.listen((state){
       setState(() {
         isPlaying=state==PlayerState.playing;
       });
     });
     player.onDurationChanged.listen((newDuration){
       setState(() {
         duration=newDuration;
       });
     });
     player.onPositionChanged.listen((newPosition){
       setState(() {
         position=newPosition;
       });
     });
   }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text('Audio Player',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24
          ),),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Container(
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width*0.7,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(music[currentMusic].cover),fit: BoxFit.cover
                )
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: Text(music[currentMusic].musicName,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24
              ),),
            ),
            Text(music[currentMusic].author,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 20
              ),),
            SizedBox(height: 10,),
            Slider(min: 0,
              max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value){
              final position=Duration(seconds: value.toInt());
              player.seek(position);
              player.resume();
                }),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position.inSeconds)),
                  Text(formatTime(duration.inSeconds))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: (){
                  player.stop();
                  player.play(AssetSource(music[--currentMusic%music.length].path));
                },
                    icon: Icon(
                      Icons.skip_previous,
                      size: 40,
                    color: Colors.white,)),
                IconButton(onPressed: () {
                  player.state==PlayerState.playing
                      ?player.pause()
                      :player.play(AssetSource(music[currentMusic].path));
                  setState(() {

                  });
                },
                    icon: Icon(
                      player.state==PlayerState.playing
                          ? Icons.pause
                      :Icons.play_arrow,
                      size: 40,
                    color: Colors.white,)),
                IconButton(onPressed: (){
                  player.stop();
                  setState(() {
                    player.play(AssetSource(music[++currentMusic%music.length].path));
                  });
                },
                    icon: Icon(
                      Icons.skip_next,
                      size: 40,
                    color: Colors.white,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
