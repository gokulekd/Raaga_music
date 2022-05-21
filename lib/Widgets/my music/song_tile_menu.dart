// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:raaga/Pages/Screen_Splash.dart';
import 'package:raaga/Pages/pageView_playlist.dart';
import 'package:raaga/Widgets/PlayLists/createNewPlaylistButton.dart';
import 'package:raaga/Widgets/PlayLists/playListTIle.dart';
import 'package:raaga/Widgets/PlayLists/playlist_SongView_page.dart';
import 'package:raaga/Widgets/my%20music/bottomsheet_addToPlaylist_MyMusic.dart';
import 'package:raaga/dataBase/songModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class song_tile_menu extends StatefulWidget {
  final String songId;

  song_tile_menu({Key? key, required this.songId}) : super(key: key);

  @override
  State<song_tile_menu> createState() => _song_tile_menuState();
}

class _song_tile_menuState extends State<song_tile_menu> {
  String? _title;
  final box = Raaga_SongData.getInstance();

  List<songDataBaseModel> playlistSongs = [];

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    List? favourites = box.get("favourites");

    final temp = databaseSongs(dbSongs_dataBase, widget.songId);

    return PopupMenuButton(
      icon: const FaIcon(
        FontAwesomeIcons.circleChevronDown,
        size: 17,
        color: Color.fromARGB(255, 207, 200, 222),
      ),
      itemBuilder: (BuildContext context) => [
        favourites!
                .where((element) => element.id.toString() == temp.id.toString())
                .isEmpty
            ? PopupMenuItem(
                onTap: () async {
                  favourites.add(temp);
                  await box.put("favourites", favourites);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.only(
                          bottom: 75, right: 10, left: 10),
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(const Radius.circular(20)),
                      ),
                      backgroundColor: const Color.fromARGB(255, 42, 41, 123),
                      content: Text(
                        temp.title + " Added to Favourites",
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Add to Favourite",
                ),
              )
            : PopupMenuItem(
                onTap: () async {
                  favourites.removeWhere(
                      (element) => element.id.toString() == temp.id.toString());
                  await box.put("favourites", favourites);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.only(
                          bottom: 75, right: 10, left: 10),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      backgroundColor: const Color.fromARGB(255, 42, 41, 123),
                      duration: const Duration(seconds: 1),
                      content: Text(
                        temp.title + " Removed from Favourites",
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Remove From Favourite",
                ),
              ),
        const PopupMenuItem(
          value: 1,
          child: Text(
            "Add to Playlist",
          ),
        ),
      ],
      onSelected: (value) async {
        if (value == 1) {
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
                                  box.get(playlistsnameForAddingSongs);

                              return Container(
                                  child: playlistSongs![index] !=
                                              "musics" &&
                                         playlistSongs[index] !=  
                                              "favourites" 
                                          
                                        
                                      ? GestureDetector(
                                          onTap: () async {
                                              playlistSongs
                                              .where((element) =>
                                                  element.id.toString() ==
                                                  temp.id.toString())
                                              .isEmpty;
                                            playlistSongs.add(temp);
                                            await box.put(playlistsname[index],
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
                                                  playlistsname[index],
                                              PlaylistName: playlistsname[index]
                                                  .toString(),
                                              SongsNumber: playlistSongs.length
                                                  .toString()),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                        
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
                                                  playlistsname[index],
                                              PlaylistName: playlistsname[index]
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
  
        }
      },
    );
  }
}

songDataBaseModel databaseSongs(List<songDataBaseModel> songs, String id) {
  return songs.firstWhere(
    (element) => element.id.toString().contains(id),
  );
}
