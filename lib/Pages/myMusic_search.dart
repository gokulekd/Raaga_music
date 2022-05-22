import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/Widgets/musicPlayPage/openPlayer.dart';
import 'package:raaga/Widgets/my%20music/song_tile_menu.dart';
import 'package:raaga/dataBase/songModel.dart';

class searchBar extends StatefulWidget {
  List<Audio> fullSongs = [];
  searchBar({Key? key, required this.fullSongs}) : super(key: key);

  @override
  State<searchBar> createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  @override
  final box = Raaga_SongData.getInstance();
  String search = "";

  List<songDataBaseModel> dbSongs = [];
  List<Audio> allSongs = [];

  searchSongs() {
    dbSongs = box.get("musics") as List<songDataBaseModel>;
    // ignore: avoid_function_literals_in_foreach_calls
    dbSongs.forEach(
      (element) {
        allSongs.add(
          Audio.file(
            element.uri.toString(),
            metas: Metas(
                title: element.title,
                id: element.id.toString(),
                artist: element.artist),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    searchSongs();
  }

  @override
  Widget build(BuildContext context) {
       double _w = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Audio> searchTitle = allSongs.where((element) {
      return element.metas.title!.toLowerCase().startsWith(
            search.toLowerCase(),
          );
    }).toList();

    List<Audio> searchArtist = allSongs.where((element) {
      return element.metas.artist!.toLowerCase().startsWith(
            search.toLowerCase(),
          );
    }).toList();

    List<Audio> searchResult = [];
    if (searchTitle.isNotEmpty) {
      searchResult = searchTitle;
    } else {
      searchResult = searchArtist;
    }

    return Scaffold(
     backgroundColor:const Color(0xff262054),
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor:const Color(0xff262054),
        title: Container(
          padding: const EdgeInsets.only(top: 3),
          width: 390,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(255, 61, 45, 104),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                FontAwesomeIcons.search,color: Colors.white,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Search Songs ",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),

      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              height: MediaQuery.of(context).size.height * .07,
              width: MediaQuery.of(context).size.width * .9,
              child: TextField(
                cursorHeight: 18.h,
                cursorColor: Colors.black,
                


                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 197, 188, 211)
        ),
        borderRadius: BorderRadius.all(Radius.circular(50),),
      ),
     
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),),

                
                  contentPadding:
                      EdgeInsets.only(top: 14.h, right: 10.w, left: 10.w),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Color.fromRGBO(119, 68, 201, 1),
                  ),
                  hintText: ' Search a song',
                  filled: true,
                  fillColor: Color.fromARGB(152, 231, 230, 232),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      search = value.trim();
                    },
                  );
                },
              ),
            ),
             search.isEmpty?
                Expanded(
                        child: ListView.builder(
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                              future: Future.delayed(
                                const Duration(microseconds: 0),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return GestureDetector(
                                    child:
                                    InkWell(
                enableFeedback: true,
                onTap: () async {
                  await OpenPlayer(fullSongs: searchResult, index: index)
                      .openAssetPlayer(index: index, songs: searchResult);
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
                              id:int.parse(searchResult[index].metas.id!) ,
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
                                    text: searchResult[index].metas.title!,
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
                                    searchResult[index].metas.artist!,
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
                                songId: searchResult[index].metas.id!
                                    .toString()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
                                  );
                                }
                                return Container();
                              },
                            );
                          },
                        ),
                      ):
                      SizedBox(),






















            search.isNotEmpty
                ? searchResult.isNotEmpty? 
                
                
                
                
                
                Expanded(
                        child: ListView.builder(
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                              future: Future.delayed(
                                const Duration(microseconds: 0),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return GestureDetector(
                                    child:
                                    InkWell(
                enableFeedback: true,
                onTap: () async {
                  await OpenPlayer(fullSongs: searchResult, index: index)
                      .openAssetPlayer(index: index, songs: searchResult);
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
                              id:int.parse(searchResult[index].metas.id!) ,
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
                                    text: searchResult[index].metas.title!,
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
                                    searchResult[index].metas.artist!,
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
                                songId: searchResult[index].metas.id!
                                    .toString()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
                                  );
                                }
                                return Container();
                              },
                            );
                          },
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(30.h.w),
                        child: Text(
                          "No Result Found",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white
                          ),
                        ),
                      )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

