import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/Pages/Screen_Splash.dart';
import 'package:raaga/Widgets/bottomsheet_playmusic/playbutton_bottomSheet.dart';
import 'package:raaga/Widgets/musicPlayPage/addToPlayList.dart';
import 'package:raaga/Widgets/musicPlayPage/shuffleSongs.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

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

class _musicPlay_pageViewState extends State<musicPlay_pageView> {
  bool isPlaying = false;
  bool isLooping = false;
  bool isShuffle = false;

  final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return assetAudioPlayer.builderCurrent(
        builder: (BuildContext context, Playing? playing) {
      final myAudio = find(widget.AllSong, playing!.audio.assetAudioPath);
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
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.ios_share_outlined),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 340,
                  height: 360,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: QueryArtworkWidget(
                        nullArtworkWidget: Image.asset(
                          "assets/songs logo.png",
                          fit: BoxFit.cover,
                        ),
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
                  //  FavouriteButton(AddFAVid:fullSongs[inde].id.toString()),
                  StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return !isShuffle
                          ? Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 235, 227, 243),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isShuffle = true;

                                    assetAudioPlayer
                                        .setLoopMode(LoopMode.playlist);
                                    var snackBar = SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text('Shuffled Song Play'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                },
                                icon: Icon(Icons.shuffle),
                              ),
                            )
                          : Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 210, 200, 220),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isShuffle = false;
                                    assetAudioPlayer.toggleShuffle();
                                    var snackBar = SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text('looped song play'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                },
                                icon: Icon(Icons.loop),
                              ),
                            );
                    },
                  ),
               
                  addToPlayList(),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
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
                  playButton_bottomSheet(
                      PlayButton_obj_assetAudioplayer:
                          widget.assetAudio_musicplayPage),
                  IconButton(
                      onPressed: () {
                        assetAudioPlayer.next();
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
