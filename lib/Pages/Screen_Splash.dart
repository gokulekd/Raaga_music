
import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:raaga/Widgets/bottomNavBar/BottomNavbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raaga/dataBase/songModel.dart';

   List<songDataBaseModel> mappedSongs_dataBase = [];
List<Audio> fullSongs = [];
List<songDataBaseModel> dbSongs_dataBase  = [];
class screen_splashScreen extends StatefulWidget {
  const screen_splashScreen({Key? key}) : super(key: key);

  @override
  State<screen_splashScreen> createState() => _screen_splashScreenState();
}

class _screen_splashScreenState extends State<screen_splashScreen> {
  @override
  void initState() {
    super.initState();
    fetchSongs();

    Timer(Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacement(
          SlideTransitionAnimation(BottomNavigation(allSongNav: fullSongs)));
    });
    Permission.storage.request();
  }

   final box = Raaga_SongData.getInstance();
  final player = AssetsAudioPlayer.withId("0");
  final _audioQuery = OnAudioQuery();

 List<SongModel> fetchedSongs_OnAudioQuery = [];
   List<SongModel> allSongs_OnAudioQuery = [];

  
 


  fetchSongs() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }
    fetchedSongs_OnAudioQuery = await _audioQuery.querySongs();

    for (var element in fetchedSongs_OnAudioQuery) {
      if (element.fileExtension == "mp3") {
        allSongs_OnAudioQuery.add(element);
      }
    }
  mappedSongs_dataBase = allSongs_OnAudioQuery.map((audio) =>
         songDataBaseModel(
           title: audio.title,
            artist: audio.artist, 
            songAlbumsname: audio.album,
             uri:audio.uri , 
             duration:audio.duration, 
             id: audio.id
             ),).toList();
            

    await box.put("musics", mappedSongs_dataBase);
    dbSongs_dataBase = box.get("musics") as List<songDataBaseModel>;
    for (var element in dbSongs_dataBase) {
      fullSongs.add(
        Audio.file(
          element.uri.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist
              ),
        ),
      );
    }
   


    setState(() {});

  
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 0),
            curve: Curves.fastLinearToSlowEaseIn,
            width: 393.w,
            height: 810.h,
            color: Colors.deepPurple,
          ),
          Column(
            children: [
              SizedBox(
                height: 130,
              ),
              Text(
                'Raaga',
                style: TextStyle(
                  fontFamily: 'font1',
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Play Your Favourite Tunes',
                style: TextStyle(
                  fontFamily: 'font1',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 425.5.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Image.asset(
                      "assets/logo9.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SlideTransitionAnimation extends PageRouteBuilder {
  final Widget page;

  SlideTransitionAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
              );
              return SlideTransition(
                position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(animation),
                textDirection: TextDirection.ltr,
                child: page,
              );
            });
}
