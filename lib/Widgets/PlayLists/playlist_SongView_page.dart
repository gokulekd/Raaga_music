import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/Widgets/PlayLists/bottomsheet_plalist.dart'; 
import 'package:raaga/Widgets/musicPlayPage/openPlayer.dart';
import 'package:raaga/dataBase/songModel.dart';

class Playlist_SongView_page extends StatefulWidget {
  List<Audio> Fullsongs = [];
  String playlistName;
  Playlist_SongView_page({Key? key, required this.playlistName})
      : super(key: key);

  @override
  State<Playlist_SongView_page> createState() => _Playlist_SongView_pageState();
}

class _Playlist_SongView_pageState extends State<Playlist_SongView_page> {
  final box = Raaga_SongData.getInstance();
  List<songDataBaseModel>? dbSongs = [];
  List<songDataBaseModel>? playlistSongs = [];
  List<Audio> playPlaylist = [];

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65),
        child: FloatingActionButton.extended(
          clipBehavior: Clip.none,
          elevation: 20,
          splashColor: Color.fromARGB(255, 54, 136, 244),
          backgroundColor: Color.fromARGB(255, 63, 101, 159),
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
                    color: Color.fromARGB(255, 40, 16, 101),
                    height: double.infinity,
                    width: double.infinity,
                    child: bottomsheet_plalist_songView_Page(
                        playlistNameBottomSheet: widget.playlistName),
                  );
                });
          },
          icon: Icon(
            FontAwesomeIcons.music,
            size: 14,
          ),
          label: Text("Add Songs"),
        ), 
      ),
      backgroundColor: const Color(0xff262054),
      appBar: AppBar(
        backgroundColor: const Color(0xff262054),
        title: Text(
          "Playlist Songs",
          style: TextStyle(color: Color.fromARGB(186, 255, 255, 255)),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, value, child) {
              var playlistSongs = box.get(widget.playlistName);
              return playlistSongs!.isEmpty
                  ? Center(
                      child: Text(
                        " No songs found ",
                        style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(171, 255, 255, 255)),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80, top: 10),
                      itemCount: playlistSongs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          enableFeedback: true,
                          onTap: () async {
                            print("hai");

                            for (var element in playlistSongs) {
                              playPlaylist.add(
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
                            OpenPlayer(fullSongs: playPlaylist, index: index)
                                .openAssetPlayer(
                                    index: index, songs: playPlaylist);
                          },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 10, top: 10, bottom: 10),
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
                                       id: playlistSongs[index].id,
                                        artworkBorder:
                                            BorderRadius.circular(5.0),
                                        type: ArtworkType.AUDIO),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          child: const Icon(
                                            Icons.music_note,
                                            size: 17,
                                            color: Color.fromARGB(
                                                207, 215, 210, 225),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 4),
                                            width: 200.w,
                                            height: 25.h,
                                            child: Marquee(
                                              velocity: 20,
                                              text: playlistSongs[index].title,
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
                                          margin:
                                              const EdgeInsets.only(right: 20),
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
                                              playlistSongs[index]
                                                  .artist
                                                  .toString(),
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
                             GestureDetector(
                               onTap: () {
                            
                                        setState(() {
                                          playlistSongs.removeAt(index);
                                          box.put(widget.playlistName,
                                              playlistSongs);
                                        });
                                
                                      
                               },
                               child: Padding(
                                 padding: const EdgeInsets.only(left: 25,bottom: 2),
                                 child: Icon(FontAwesomeIcons.circleXmark,color: Color.fromARGB(255, 190, 173, 173),size: 20,),
                               ),
                             )
                              ],
                            ),
                          ),
                        );
                      });
            }),
      ),
    );
  }
}
