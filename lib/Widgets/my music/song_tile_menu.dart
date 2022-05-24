// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:raaga/Pages/Screen_Splash.dart';
import 'package:raaga/Pages/pageView_playlist.dart';
import 'package:raaga/Widgets/PlayLists/createNewPlaylistButton.dart';
import 'package:raaga/Widgets/PlayLists/playListTIle.dart';
import 'package:raaga/Widgets/PlayLists/playlist_SongView_page.dart';
import 'package:raaga/Widgets/PlayLists/playlist_mainView.dart';
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
  final box = Raaga_SongData.getInstance();

  List<songDataBaseModel> playlistSongs = [];

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    List? favourites = box.get("favourites");

    final temp = databaseSongs(dbSongs_dataBase, widget.songId);

    return PopupMenuButton(
       shape: const RoundedRectangleBorder(         //Adding Round Border
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
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
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: 75, right: 10, left: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      backgroundColor: Color.fromARGB(255, 42, 41, 123),
                      duration: Duration(milliseconds: 500),
                      content: Text(
                        " Added to Favourites",
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
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: 75, right: 10, left: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      backgroundColor: Color.fromARGB(255, 42, 41, 123),
                      duration: Duration(milliseconds: 500),
                      content: Text(
                        " Removed from Favourites",
                        style: TextStyle(fontFamily: 'Poppins'),
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
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            context: context,
            builder: (ctx) {
              bool isTapped = false;
              return playlistmain_View(songid: widget.songId);
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
