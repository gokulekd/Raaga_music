import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/now%20playing%20module/controller/NowplayingController.dart';
import 'package:raaga/now%20playing%20module/controller/lotte_contoller.dart';
import 'package:raaga/now%20playing%20module/widgets/addToPlayList.dart';
import 'package:raaga/splash%20module/view/Screen_Splash.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:raaga/dataBase/songModel.dart';
import 'package:raaga/my%20music%20module/view/screen_my_music.dart';

final box = Raaga_SongData.getInstance();
List? mainFavouriteList = box.get("favourites");

// ignore: must_be_immutable
class MusicPlayPageView extends StatelessWidget {
  MusicPlayPageView({Key? key}) : super(key: key);

  bool isPlaying = false;
  bool isLooping = false;
  bool isShuffle = false;
  bool istapped = false;

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return assetAudioPlayer.builderCurrent(
        builder: (BuildContext context, Playing? playing) {
      final myAudio = find(fullSongs, playing!.audio.assetAudioPath);
      final temp = databaseSongs(dbSongs_dataBase, myAudio.metas.id.toString());

      return Scaffold(
        backgroundColor: const Color(0xff262054),
        appBar: AppBar(
          toolbarHeight: 90,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_down_sharp),
          ),
          backgroundColor: const Color.fromARGB(255, 46, 39, 101),
          elevation: 20,
          centerTitle: true,
          title: Column(
            children: [
              const Text(
                "Now Playing",
                style: TextStyle(
                    color: Color.fromARGB(116, 255, 255, 255), fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                myAudio.metas.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color.fromARGB(255, 233, 233, 233), fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                myAudio.metas.artist!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color.fromARGB(116, 255, 255, 255), fontSize: 15),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              GetBuilder<LotteController>(
                init: LotteController(),
                builder: (LotteChanger) {
                  return Center(
                    child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: 340,
                        height: 340,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: QueryArtworkWidget(
                              nullArtworkWidget: Container(
                                width: 400,
                                height: 400,
                                child: Lottie.asset(
                                    "assets/json/19782-listening-to-music.json",
                                    animate: LotteChanger.isLotteplaying.value,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover),
                              ),
                              id: int.parse(myAudio.metas.id!),
                              artworkBorder: BorderRadius.circular(5.0),
                              type: ArtworkType.AUDIO),
                        )),
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
              GetBuilder<NowPlayingController>(
                  init: NowPlayingController(),
                  builder: (NowPlayingController1) {
                    NowPlayingController1.isaddedToFavourite.value =
                        mainFavouriteList!
                            .where((element) =>
                                element.id.toString() == temp.id.toString())
                            .isEmpty;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        !NowPlayingController1.isshuffledbool.value
                            ? GestureDetector(
                                onTap: () {
                                  NowPlayingController1.isPlaymodechanged(true);

                                  NowPlayingController1.songshuffled();
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        255, 235, 227, 243),
                                  ),
                                  child: const Icon(Icons.loop),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  NowPlayingController1.isPlaymodechanged(
                                      false);
                                  NowPlayingController1.songlooped();
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        255, 210, 200, 220),
                                  ),
                                  child: const Icon(Icons.shuffle_outlined),
                                ),
                              ),
                        NowPlayingController1.isaddedToFavourite.value == true
                            ? GestureDetector(
                                onTap: () async {
                                  await NowPlayingController1
                                      .isaddedToFavouritecheck(true);
                                  mainFavouriteList!.add(temp);
                                  await box.put(
                                      "favourites", mainFavouriteList!);
                                  NowPlayingController1.favaddedSnak();
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        255, 210, 200, 220),
                                  ),
                                  child: const Icon(Icons.favorite_border),
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  await NowPlayingController1
                                      .isaddedToFavouritecheck(false);
                                  mainFavouriteList!.removeWhere((element) =>
                                      element.id.toString() ==
                                      temp.id.toString());
                                  await box.put(
                                      "favourites", mainFavouriteList!);

                                  NowPlayingController1.favRemovedSnak();
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        255, 210, 200, 220),
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                        AddtoPlayListFromNowPlaying(
                            songIdForNowPlaying: myAudio.metas.id.toString()),
                      ],
                    );
                  }),
              const SizedBox(
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
                    timeLabelTextStyle: const TextStyle(color: Colors.white),
                    progressBarColor: const Color.fromARGB(255, 255, 255, 255),
                    baseBarColor: const Color.fromARGB(255, 66, 36, 137),
                    thumbColor: const Color.fromARGB(255, 124, 116, 230),
                    barHeight: 5.0,
                    thumbRadius: 12.0,
                    progress: currentPos,
                    total: total,
                    onSeek: (duration) {
                      assetAudioPlayer.seek(duration);
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  playing.index == 0
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                        )
                      : IconButton(
                          onPressed: () {
                            assetAudioPlayer.previous();
                            Get.find<LotteController>().lotteChanger(true);
                          },
                          icon: const Icon(
                            Icons.fast_rewind,
                            size: 30,
                            color: Color.fromARGB(183, 255, 255, 255),
                          ),
                        ),
                  GestureDetector(
                    onTap: (() async {
                      await assetAudioPlayer.playOrPause();
                      Get.find<LotteController>()
                          .lotteChanger(assetAudioPlayer.isPlaying.value);

                      print(
                          "value vanneeeeeeee  ${Get.find<LotteController>().isLotteplaying.value}");
                    }),
                    child: Container(
                      height: 47.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color.fromARGB(255, 182, 165, 200)),
                      child: PlayerBuilder.isPlaying(
                          player: assetAudioPlayer,
                          builder: (context, isPlaying) {
                            return Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 30.h.w,
                              color: const Color.fromARGB(255, 86, 64, 147),
                            );
                          }),
                    ),
                  ),
                  playing.index == fullSongs.length - 1
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                        )
                      : IconButton(
                          onPressed: () {
                            assetAudioPlayer.next();
                            Get.find<LotteController>().lotteChanger(true);
                          },
                          icon: const Icon(
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
