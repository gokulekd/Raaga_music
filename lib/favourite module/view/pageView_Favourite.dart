import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/Widgets/favourite/showModelBottomSheet.dart';
import 'package:raaga/common%20module/openPlayer.dart';
import 'package:raaga/dataBase/songModel.dart';

import '../../now playing module/view/pageView_musicPlay.dart';
 List? mainFavouriteList = box.get("favourites");
// ignore: camel_case_types, must_be_immutable
class PageViewFaourite extends StatelessWidget {
  PageViewFaourite({Key? key}) : super(key: key);

  List<songDataBaseModel>? dbSongs = [];
  List<Audio> playLiked = [];
  final box = Raaga_SongData.getInstance();
  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    final favSongs = box.get("favourites");

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.extended(
          clipBehavior: Clip.none,
          elevation: 20,
          splashColor: const Color.fromARGB(255, 54, 136, 244),
          backgroundColor: const Color.fromARGB(255, 63, 101, 159),
          onPressed: () {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                context: context,
                builder: (ctx) {
                  return Container(
                    color: const Color.fromARGB(255, 40, 16, 101),
                    height: double.infinity,
                    width: double.infinity,
                    child: showModelBottomSheet_favourite_Screen(),
                  );
                });
          },
          icon: const Icon(
            FontAwesomeIcons.music,
            size: 14,
          ),
          label: const Text("Add Songs"),
        ),
      ),
      backgroundColor: const Color(0xff262054),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: const Color(0xff262054),
        title: Container(
          padding: const EdgeInsets.only(top: 3),
          width: 400.w.h,
          height: 40.w.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(255, 61, 45, 104),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                FontAwesomeIcons.heartCircleCheck,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "favourites",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        elevation: 20,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, value, child) => ListView.builder(
                padding: const EdgeInsets.only(bottom: 80, top: 10),
                itemCount: favSongs!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    enableFeedback: true,
                    onTap: () async {
                      print("hai");

                      for (var element in favSongs) {
                        playLiked.add(
                          Audio.file(
                            element.uri!,
                            metas: Metas(
                              title: element.title,
                              id: element.id.toString(),
                              artist: element.artist,
                            ),
                          ),
                        );
                      }
                      OpenPlayer(fullSongs: playLiked, index: index)
                          .openAssetPlayer(index: index, songs: playLiked);
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      margin:
                          const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                      height: _w / 6,
                      width: _w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 71, 64, 131),
                        borderRadius: BorderRadius.only(
                          topRight: const Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: 45.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: QueryArtworkWidget(
                                  nullArtworkWidget: Image.asset(
                                    "assets/songs logo.png",
                                    fit: BoxFit.cover,
                                  ),
                                  id: favSongs[index].id,
                                  artworkBorder: BorderRadius.circular(5.0),
                                  type: ArtworkType.AUDIO),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const Icon(
                                      Icons.music_note,
                                      size: 17,
                                      color: Color.fromARGB(207, 215, 210, 225),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      width: 200.w,
                                      height: 25.h,
                                      child: Marquee(
                                        velocity: 20,
                                        text: favSongs[index].title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: const Color.fromARGB(
                                              207, 215, 210, 225),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: const Icon(
                                      Icons.album,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      margin: REdgeInsets.only(right: 4),
                                      width: 185.w,
                                      height: 18.h,
                                      child: Text(
                                        favSongs[index].artist.toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(
                                              157, 255, 255, 255),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 7, left: 12),
                                child: IconButton(
                                  onPressed: () async {
                                    mainFavouriteList!.removeWhere((element) =>
                                        element.id.toString() ==
                                        favSongs[index].id.toString());
                                    await box.put(
                                        "favourites", mainFavouriteList!);
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.circleXmark,
                                    size: 20,
                                    color: Color.fromARGB(199, 195, 209, 229),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
