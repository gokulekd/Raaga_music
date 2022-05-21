import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:raaga/Pages/Screen_Splash.dart';
import 'package:raaga/Widgets/PlayLists/createNewPlayList.dart';
import 'package:raaga/Widgets/PlayLists/createNewPlaylistButton.dart';
import 'package:raaga/Widgets/PlayLists/playListTIle.dart';
import 'package:raaga/Widgets/bottomsheet_playmusic/bottomsheet.dart';

import '../../dataBase/songModel.dart';


// ignore: camel_case_types
class addToPlayList extends StatefulWidget {
    final String songId_For_NowPlaying;
  const addToPlayList({Key? key,required this.songId_For_NowPlaying}) : super(key: key);

  @override
  _addToPlayListState createState() => _addToPlayListState();
}

class _addToPlayListState extends State<addToPlayList>
    with TickerProviderStateMixin {
  bool isPressed = true;
  bool isPressed2 = true;
  bool isHighlighted = true;
 
  @override
  Widget build(BuildContext context) {
    final temp = databaseSongs(dbSongs_dataBase,widget.songId_For_NowPlaying);
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHighlightChanged: (value) {
        setState(() {
          isHighlighted = !isHighlighted;
        });
      },
      onTap: () {
      showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              context: context,
              builder: (ctx) {
                bool isTapped = false;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onHighlightChanged: (value) {},
                        onTap: () async {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  createNewPlaylistButton());
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: isTapped ? 30 : 40,
                          width: isTapped ? 190 : 200,
                          decoration: BoxDecoration(
                            color: isTapped
                                ? Color.fromARGB(255, 190, 153, 193)
                                : Color.fromARGB(255, 177, 177, 222),
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
                      child: ValueListenableBuilder(
                        valueListenable: box.listenable(),
                        builder: (context, boxes, _) {
                          List playlistsnameForAddingSongs = box.keys.toList();
                          return ListView.builder(
                            itemCount: playlistsnameForAddingSongs.length,
                            itemBuilder: (context, index) {
                              var playlistSongs =
                                  box.get(playlistsnameForAddingSongs[index])!;

                              return Container(
                                  child: playlistsnameForAddingSongs[index] !=
                                              "musics" &&
                                          playlistsnameForAddingSongs[index] !=
                                              "favourites" &&
                                          playlistsnameForAddingSongs[index] !=
                                              "Recently_Played" &&
                                          playlistSongs
                                              .where((element) =>
                                                  element.id.toString() ==
                                                  temp.id.toString())
                                              .isEmpty
                                      ? GestureDetector(
                                          onTap: () async {
                                            playlistSongs.add(temp);
                                            await box.put(playlistsnameForAddingSongs[index],
                                                playlistSongs);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    bottom: 75,
                                                    right: 10,
                                                    left: 10),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                                backgroundColor: Color.fromARGB(
                                                    255, 42, 41, 123),
                                                     duration: Duration(milliseconds: 500),
                                                content: Text(
                                                  " Added to playlist",
                                                ),
                                              ),
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: playlistTile(
                                              playlistNameFromTile:
                                                 playlistsnameForAddingSongs[index],
                                              PlaylistName:playlistsnameForAddingSongs[index]
                                                  .toString(),
                                              SongsNumber: playlistSongs.length
                                                  .toString()),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            await box.put(playlistsnameForAddingSongs[index],
                                                playlistSongs);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    bottom: 75,
                                                    right: 10,
                                                    left: 10),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                                backgroundColor: Color.fromARGB(
                                                    255, 42, 41, 123),
                                                duration: Duration(milliseconds: 500),
                                                content: Text(
                                                  "allready in playlist",
                                                ),
                                              ),
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: playlistTile(
                                              playlistNameFromTile:
                                                  playlistsnameForAddingSongs[index],
                                              PlaylistName:playlistsnameForAddingSongs[index]
                                                  .toString(),
                                              SongsNumber: playlistSongs.length
                                                  .toString()),
                                        ));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
                 },
              );


     
        setState(() {
          isPressed2 = !isPressed2;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(isHighlighted ? 0 : 2.5),
        height: isHighlighted ? 35 : 25,
        width: isHighlighted ? 35 : 25,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(5, 10),
            ),
          ],
          color: Color.fromARGB(255, 210, 189, 229),
          shape: BoxShape.circle,
        ),
        child: isPressed2
            ? Icon(
                Icons.library_music_outlined,
                color: Colors.black.withOpacity(0.6),
              )
            : Icon(
                Icons.library_music_rounded,
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(1.0),
              ),
      ),
    );
  }
}
songDataBaseModel databaseSongs(List<songDataBaseModel> songs, String id) {
  return songs.firstWhere(
    (element) => element.id.toString().contains(id),
  );
}