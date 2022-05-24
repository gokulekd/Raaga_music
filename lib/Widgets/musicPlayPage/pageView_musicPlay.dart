import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/Pages/Screen_Splash.dart';
import 'package:raaga/Widgets/musicPlayPage/addToPlayList.dart';import 'package:raaga/Widgets/musicPlayPage/shuffleSongs.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:raaga/dataBase/songModel.dart';

class DurationState {
  const DurationState({required this.progress, required this.total});
  final Duration progress;

  final Duration total;
}

class musicPlay_pageView extends StatefulWidget {
  List<Audio> AllSong = [];
  dynamic assetAudio_musicplayPage;
  musicPlay_pageView(
      {Key? key, required this.AllSong, required this.assetAudio_musicplayPage})
      : super(key: key);

  @override
  State<musicPlay_pageView> createState() => _musicPlay_pageViewState();
}

final box = Raaga_SongData.getInstance();

class _musicPlay_pageViewState extends State<musicPlay_pageView>{

bool isPlaying = false;
  bool isLooping = false;
  bool isShuffle = false;
  bool isLotteplaying = true;

  
  

  final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");

  List? mainFavouriteList = box.get("favourites");

  bool istapped = false;

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    
 bool lotteBool= false;
    var lotte = Lottie.asset("assets/json/19782-listening-to-music.json",animate: isLotteplaying);

    return assetAudioPlayer.builderCurrent(
        builder: (BuildContext context, Playing? playing) {
      final myAudio = find(widget.AllSong, playing!.audio.assetAudioPath);
      final temp = databaseSongs(dbSongs_dataBase, myAudio.metas.id.toString());
      return Scaffold(
        backgroundColor: Color(0xff262054),
        appBar: AppBar(
          toolbarHeight: 90,
          leading: IconButton(
            onPressed: () {
           
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_arrow_down_sharp),
          ),
          backgroundColor: Color.fromARGB(255, 46, 39, 101),
          elevation: 20,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                "Now Playing",
                style: TextStyle(
                    color: Color.fromARGB(116, 255, 255, 255), fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                myAudio.metas.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 233, 233, 233), fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                myAudio.metas.artist!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(116, 255, 255, 255), fontSize: 15),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 340,
                  height: 340,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: QueryArtworkWidget(
                        nullArtworkWidget: lotte,
                        id: int.parse(myAudio.metas.id!),
                        artworkBorder: BorderRadius.circular(5.0),
                        type: ArtworkType.AUDIO),
                        
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
   
                  StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return !isShuffle
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isShuffle = true;

                                  assetAudioPlayer
                                      .setLoopMode(LoopMode.playlist);
                                   assetAudioPlayer.toggleShuffle();
                                     ScaffoldMessenger.of(context).removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom: 0, right: 10, left: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 42, 41, 123),
                                    duration: Duration(milliseconds: 500),
                                content: Text(
                               " shuffled Song Play",
                                ),
                              ),
                            );
                                });
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 235, 227, 243),
                                ),
                                child: Icon(Icons.loop),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  isShuffle = false;
                                  assetAudioPlayer.toggleShuffle();


                                     ScaffoldMessenger.of(context).removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom: 0, right: 10, left: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 42, 41, 123),
                                      duration: Duration(milliseconds: 500),
                                content: Text(
                               " looped Song Play",
                                ),
                              ),


                            );
                                });
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 210, 200, 220),
                                ),
                                child: Icon(Icons.shuffle_outlined),
                              ),
                            );
                    },
                  ),
                  mainFavouriteList!
                          .where((element) =>
                              element.id.toString() == temp.id.toString())
                          .isEmpty
                      ? GestureDetector(
                          onTap: () async {

  
                            mainFavouriteList!.add(temp);
                            await box.put("favourites", mainFavouriteList!);
                            setState(() {
                       ScaffoldMessenger.of(context).removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom: 0, right: 10, left: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 42, 41, 123),
                                      duration: Duration(milliseconds: 500),
                                content: Text(
                               " Added to Favourite",
                                ),
                              ),

                            );

                        
                              
                            });
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 210, 200, 220),
                            ),
                            child: Icon(Icons.favorite_border),
                          ),
                        )
                      : 
                       GestureDetector(
                        onTap: () async {
                            mainFavouriteList!.removeWhere((element) =>
                                element.id.toString() == temp.id.toString());
                            await box.put("favourites", mainFavouriteList!);

                              ScaffoldMessenger.of(context).removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom: 0, right: 10, left: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 51, 49, 146),
                                      duration: Duration(milliseconds: 500),
                                content: Text(
                               " Removed from Favourite",
                                ),
                              ),
                              );
                            setState(() {
                              
                            });
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 210, 200, 220),
                            ),
                             child: Icon(Icons.favorite,color: Colors.red,),
                          ),
                        ),
                  addToPlayList(
                      songId_For_NowPlaying:myAudio.metas.id.toString()),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: assetAudioPlayer.builderRealtimePlayingInfos(
                    builder: (ctx, infos) {
                  Duration currentPos = infos.currentPosition;
                  Duration total = infos.duration;
                  return ProgressBar(
                    timeLabelPadding: 5,
                    timeLabelLocation: TimeLabelLocation.above,
                    timeLabelTextStyle: TextStyle(color: Colors.white),
                    progressBarColor: Color.fromARGB(255, 255, 255, 255),
                    baseBarColor: Color.fromARGB(255, 66, 36, 137),
                    thumbColor: Color.fromARGB(255, 124, 116, 230),
                    barHeight: 5.0,
                    thumbRadius: 12.0,
                    progress: currentPos,
                    total: total,
                    onSeek: (duration) {
                      assetAudioPlayer.seek(duration);

                      print('User selected a new time: $duration');
                    },
                  );
                }),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () async {
                        assetAudioPlayer.previous();
                      },
                      icon: Icon(
                        Icons.fast_rewind,
                        size: 30,
                        color: Color.fromARGB(183, 255, 255, 255),
                      )),
                   GestureDetector(
                     onTap: (()async {
                    
                            await assetAudioPlayer.playOrPause();
                           
                            setState(() {
                             
                            isLotteplaying = !isLotteplaying;
                           
                            
                            });
                       
                     }),
                     child: Container(
                  
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                             color: Color.fromARGB(255, 182, 165, 200)),
                        child: PlayerBuilder.isPlaying(
                            player: assetAudioPlayer,
                            builder: (context, isPlaying) {
                              isPlaying?lotteBool==true:lotteBool == false;
                              return 
                              
                                Icon(
                                  isPlaying ? Icons.pause  : Icons.play_arrow,
                                  size: 30.h.w,color: Color.fromARGB(255, 86, 64, 147),
                                  
                                
                              );
                            }),
                      ),
                   ),
                  IconButton(
                      onPressed: () {
                        assetAudioPlayer.next();
                        setState(() {
                            
                        });
                      },
                      icon: Icon(
                        Icons.fast_forward,
                        size: 30,
                        color: Color.fromARGB(183, 255, 255, 255),
                      )),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

songDataBaseModel databaseSongs(List<songDataBaseModel> songs, String id) {
  return songs.firstWhere(
    (element) => element.id.toString().contains(id),
  );
}
