// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:raaga/Pages/Screen_Splash.dart';
import 'package:raaga/Pages/pageView_playlist.dart';
import 'package:raaga/Widgets/PlayLists/createNewPlaylistButton.dart';
import 'package:raaga/Widgets/PlayLists/playListTIle.dart';

import 'package:raaga/dataBase/songModel.dart';

class addToPlayList extends StatefulWidget {
  final String songId_For_NowPlaying;
  const addToPlayList({Key? key, required this.songId_For_NowPlaying})
      : super(key: key);

  @override
  _addToPlayListState createState() => _addToPlayListState();
}

class _addToPlayListState extends State<addToPlayList>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
  final temp  = databaseSongs(dbSongs_dataBase, widget.songId_For_NowPlaying);
songDataBaseModel songvalue;
    final box = Raaga_SongData.getInstance();
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHighlightChanged: (value) {},
      onTap: () {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            context: context,
            builder: (ctx) {
              bool isTapped = false;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onHighlightChanged: (value) {
                        setState(
                          () {
                            isTapped = value;
                          },
                        );
                      },
                      onTap: () async {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                const createNewPlaylistButton());
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: isTapped ? 30 : 40,
                        width: isTapped ? 190 : 200,
                        decoration: BoxDecoration(
                          color: isTapped
                              ? const Color.fromARGB(255, 190, 153, 193)
                              : const Color.fromARGB(255, 177, 177, 222),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 30,
                              offset: const Offset(3, 7),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: const Text(
                            "Create New Playlist",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 86, 42, 118),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                    
                     ValueListenableBuilder(
                      valueListenable: box.listenable(),
                      builder: (context, boxes, _) {
                        playlistsname = box.keys.toList();
                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: playlistsname.length,
                          itemBuilder: (context, index) {
                           playlistSongs = box.get(playlistsname[index])!.cast<songDataBaseModel>();

                            return Container(
                              child:  dbSongs_dataBase
                      .where((element) =>
                          element.id.toString() == widget.songId_For_NowPlaying).isNotEmpty?
                       
                              
                              playlistsname[index] != "musics" &&
                                      playlistsname[index] != "favourites" &&
                                      playlistsname[index] != "Recently_Played"
                                  ? GestureDetector(
                                      onTap: () async{
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         Playlist_SongView_page(
                                        //             playlistName:
                                        //                 playlistsname[index]),
                                        //   ),
                        //                 // );
                                         
                        //                   playlistSongs.add(songvalue);
                        // await box.put(playlistsname[index], playlistSongs);

                        setState(() {});

                                        ScaffoldMessenger.of(context)
                                            .removeCurrentSnackBar();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.only(
                                                bottom: 0, right: 10, left: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            backgroundColor: Color.fromARGB(
                                                255, 51, 49, 146),
                                            duration:
                                                Duration(milliseconds: 500),
                                            content: Text(
                                              " allready exixst in playlist",
                                            ),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: playlistTile(
                                          playlistNameFromTile:
                                              playlistsname[index],
                                          PlaylistName:
                                              playlistsname[index].toString(),
                                          SongsNumber:
                                              playlistSongs.length.toString()),
                                    )
                                  : const SizedBox()
                                  :SizedBox()
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            });
      },
      child: AnimatedContainer(
          height: 35,
          width: 35,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(5, 10),
              ),
            ],
            color: const Color.fromARGB(255, 210, 189, 229),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.library_music_outlined,
            color: Colors.black.withOpacity(0.6),
          )),
    );
  }
}

songDataBaseModel databaseSongs(List<songDataBaseModel> songs, String id) {
  return songs.firstWhere(
    (element) => element.id.toString().contains(id),
  );
}
