// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:raaga/Pages/Screen_Splash.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/Widgets/musicPlayPage/openPlayer.dart';
import 'package:raaga/Widgets/my%20music/drawer/drawer_Raaga.dart';
import 'package:raaga/Widgets/my%20music/myMusic_search.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:raaga/Widgets/my%20music/song_tile_menu.dart';

final _audioQuery = new OnAudioQuery();

class Screen_MyMusic extends StatefulWidget {
  List<Audio> Fullsongs = [];

  Screen_MyMusic({Key? key, required this.Fullsongs}) : super(key: key);

  @override
  Screen_MyMusicState createState() => Screen_MyMusicState();
}

class Screen_MyMusicState extends State<Screen_MyMusic>
    with SingleTickerProviderStateMixin {
  String Query = " ";
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  //  final box = Raaga_SongData.getInstance();
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");

  final _audioQuery = OnAudioQuery();

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -30)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff262054),
      appBar: AppBar(
        backgroundColor: const Color(0xff262054),
        elevation: 10,
        title: const Text('RAAGA'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu)),
      ),
      drawer: const drawer_Raaga(),

      body: SafeArea(
        child: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty) {
              return const Center(
                child: const Text(" No Songs Found"),
              );
            }
            return ListView.builder(
              itemCount: dbSongs_dataBase.length,
              itemBuilder: (context, index) => InkWell(
                enableFeedback: true,
                onTap: () async {
                  await OpenPlayer(fullSongs: fullSongs, index: index)
                      .openAssetPlayer(index: index, songs: widget.Fullsongs);
                },
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  height: _w / 6,
                  width: _w,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: const Color.fromARGB(255, 71, 64, 131),
                    borderRadius: const BorderRadius.only(
                      topRight: const Radius.circular(30),
                      bottomRight: const Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              id: item.data![index].id,
                              artworkBorder: BorderRadius.circular(5.0),
                              type: ArtworkType.AUDIO),
                        ),
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
                                  width: 185.w,
                                  height: 25.h,
                                  child: Marquee(
                                    velocity: 20,
                                    text: item.data![index].displayNameWOExt,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(207, 215, 210, 225),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 5),
                                child: const Icon(
                                  Icons.album,
                                  size: 17,
                                  color: Color.fromARGB(207, 215, 210, 225),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: REdgeInsets.only(right: 4),
                                  width: 185.w,
                                  height: 18.h,
                                  child: Text(
                                    item.data![index].artist.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: const Color.fromARGB(157, 255, 255, 255),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: song_tile_menu(
                                songId: widget.Fullsongs[index].metas.id
                                    .toString()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 80, top: 8),
            );
          },
        ),
      ),

      // top me rahna
    );
  }
}
