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
    List playlistsname_keys = box.keys.toList();
    final temp = databaseSongs(dbSongs_dataBase, widget.songId);
   final temp1 = databaseSongs(dbSongs_dataBase, widget.songId);
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
          child: Text(
            "Add to Playlist",
          ),
          value: "1",
        ),
      ],
      onSelected: (value) async {
        if (value == "1") {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          builder: (context, boxes,  _) {
                            playlistsname = box.keys.toList();
                            return ListView.builder(
                                itemCount: playlistsname.length,
                                itemBuilder: (context, index) {
                                  var playlistSongs =
                                      box.get(playlistsname[index])!;

                                  return Container(
                                      child: playlistsname[index] != "musics" &&
                                              playlistsname[index] !=
                                                  "favourites" &&
                                              playlistsname[index] !=
                                                  "Recently_Played" 
                                          ? 
                                              
                                              InkWell(
                                                  onTap: () async {
                                             
                                              
                                                        setState(() {});
                                                      },
                                                child: Container(
                                                    margin:
                                                        const EdgeInsets.all(10),
                                                    width: 300,
                                                    height: 75,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Color.fromARGB(
                                                          255, 92, 74, 197),
                                                    ),
                                                    child: ListTile(
                                            
                                                      leading: Container(
                                                        decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 61, 45, 104),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        width: 60,
                                                        height: 85,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: const Icon(
                                                            FontAwesomeIcons
                                                                .music,
                                                            size: 30,
                                                            color: Color.fromARGB(
                                                                255,
                                                                215,
                                                                206,
                                                                205),
                                                          ),
                                                        ),
                                                      ),
                                                      title: Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5,
                                                                    left: 5),
                                                            child: Icon(
                                                              Icons
                                                                  .my_library_music_rounded,
                                                              size: 17,
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5,
                                                                    left: 5),
                                                            child: Text(
                                                              playlistsname[
                                                                  index],
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        194,
                                                                        221,
                                                                        212,
                                                                        241),
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      subtitle: Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5,
                                                                    left: 5,
                                                                    top: 15),
                                                            child: Icon(
                                                              Icons.music_note,
                                                              size: 17,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5,
                                                                    left: 5,
                                                                    top: 15),
                                                            child: Text(
                                                              playlistSongs.length
                                                                      .toString() +
                                                                  " songs",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                        .fromARGB(
                                                                            119,
                                                                            234,
                                                                            185,
                                                                            185)
                                                                    .withOpacity(
                                                                        .8),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: PopupMenuButton(
                                                        icon: const FaIcon(
                                                          FontAwesomeIcons
                                                              .circleChevronDown,
                                                          size: 17,
                                                          color: Color.fromARGB(
                                                              255, 207, 200, 222),
                                                        ),
                                                        itemBuilder: (BuildContext
                                                                context) =>
                                                            [
                                                          PopupMenuItem(
                                                            value: 1,
                                                            onTap: () async {},
                                                            child: const Text(
                                                              "Edit PlayList",
                                                            ),
                                                          ),
                                                          PopupMenuItem(
                                                            value: 2,
                                                            onTap: () async {},
                                                            child: const Text(
                                                              "Delete PlayList",
                                                            ),
                                                          ),
                                                        ],
                                                        onSelected:
                                                            (value) async {
                                                          if (value == 1) {
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                title: const Text(
                                                                  'Edit Playlist',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                content:
                                                                    Container(
                                                                  width: 100,
                                                                  height: 100,
                                                                  color: Colors
                                                                      .white,
                                                                  child: Form(
                                                                    key: _formKey,
                                                                    child: Column(
                                                                      children: <
                                                                          Widget>[
                                                                        TextFormField(
                                                                          initialValue:
                                                                              playlistsname[index],
                                                                          decoration: InputDecoration(
                                                                              fillColor: Colors.white,
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                                borderSide: const BorderSide(
                                                                                  color: Colors.blue,
                                                                                ),
                                                                              ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                                borderSide: const BorderSide(
                                                                                  color: Color.fromARGB(255, 54, 101, 244),
                                                                                ),
                                                                              ),
                                                                              hintText: "Edit Playlist Name"),
                                                                          onChanged:
                                                                              (value) {
                                                                            _title =
                                                                                value.trim();
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            List
                                                                                keys =
                                                                                box.keys.toList();
                                                                            if (value!.trim() ==
                                                                                "") {
                                                                              return "name Required";
                                                                            }
                                                                            if (keys
                                                                                .where((element) => element == value.trim())
                                                                                .isNotEmpty) {
                                                                              return "this name already exits";
                                                                            }
                                                                            return null;
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context,
                                                                            'Cancel'),
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      if (_formKey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        List?
                                                                            playlists =
                                                                            box.get(
                                                                                playlistsname[index]);
                                                                        box.put(
                                                                            _title,
                                                                            playlists!);
                                                                        box.delete(
                                                                            playlistsname[
                                                                                index]);
                                                                      }
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        const SnackBar(
                                                                          behavior:
                                                                              SnackBarBehavior.floating,
                                                                          margin: EdgeInsets.only(
                                                                              bottom:
                                                                                  75,
                                                                              right:
                                                                                  10,
                                                                              left:
                                                                                  10),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(20)),
                                                                          ),
                                                                          backgroundColor: Color.fromARGB(
                                                                              255,
                                                                              42,
                                                                              41,
                                                                              123),
                                                                          duration:
                                                                              Duration(seconds: 1),
                                                                          content:
                                                                              const Text(
                                                                            "  Playlist re-named",
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            'Done'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                              
                                                            Navigator.canPop(
                                                                context);
                                                          }
                                              
                                                          if (value == 2) {
                                                            showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                title: const Text(
                                                                  'Delete Playlist',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                content: const Text(
                                                                    " Do you want to Delete this playlist"),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator
                                                                            .pop(
                                                                      context,
                                                                    ),
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      box.delete(
                                                                          playlistsname[
                                                                              index]);
                                                                      setState(
                                                                          () {
                                                                        playlistsname_keys = box
                                                                            .keys
                                                                            .toList();
                                                                      });
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        const SnackBar(
                                                                          duration:
                                                                              Duration(seconds: 1),
                                                                          behavior:
                                                                              SnackBarBehavior.floating,
                                                                          margin: EdgeInsets.only(
                                                                              bottom:
                                                                                  75,
                                                                              right:
                                                                                  10,
                                                                              left:
                                                                                  10),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(20)),
                                                                          ),
                                                                          backgroundColor: Color.fromARGB(
                                                                              255,
                                                                              42,
                                                                              41,
                                                                              123),
                                                                          content:
                                                                              Text("play List deleted"),
                                                                        ),
                                                                      );
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            'Done'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                              )
                                              : SizedBox()
                                      );
                                });
                          }),
                    ),
                  ],
                );
              });
          Navigator.canPop(context);
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
