import 'package:flutter/material.dart';
import 'package:mediaboster3/ui/audio_player_page/audio_player_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  toNextPage(){
    Future.delayed(Duration(seconds: 3)).then((value)=>Navigator.push(
        context,MaterialPageRoute(builder: (context)=>AudioPlayerPage())));
  }
  @override
  void initState(){
    toNextPage();
        super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Center(
          child:Image(
            image:AssetImage('assets/audio.png'),
          )
      ),
    )
    );
  }
}
