// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:raaga/now%20playing%20module/controller/NowplayingController.dart';
import 'package:raaga/splash%20module/view/Screen_Splash.dart';
import 'package:raaga/Widgets/PlayLists/playlist_mainView.dart';
import 'package:raaga/dataBase/songModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Widgets/PlayLists/createNewPlaylistButton.dart';
import '../../Widgets/PlayLists/playListTIle.dart';

class song_tile_menu extends StatelessWidget {
  final String songId;

  song_tile_menu({Key? key, required this.songId}) : super(key: key);

  final box = Raaga_SongData.getInstance();

  List<songDataBaseModel> playlistSongs = [];
  NowPlayingController controller = Get.put(NowPlayingController());
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    List? favourites = box.get("favourites");

    final temp = databaseSongs(dbSongs_dataBase, songId);

    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
        //Adding Round Border
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
                  controller.favaddedSnak();
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
                  controller.favRemovedSnak();
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
                      child: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 177, 177, 222),
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
                        var playlistsname = box.keys.toList();
                        return ListView.builder(
                          padding: EdgeInsets.only(bottom: 100),
                          itemCount: playlistsname.length,
                          itemBuilder: (context, index) {
                            var playlistSongs = box.get(playlistsname[index])!;

                            return Container(
                                child: playlistsname[index] != "musics" &&
                                        playlistsname[index] != "favourites" &&
                                        playlistsname[index] !=
                                            "Recently_Played"
                                    ? GestureDetector(
                                        onTap: () {
                                          final songid_to_platlist =
                                              dbSongs_dataBase
                                                  .where((element) =>
                                                      element.id.toString() ==
                                                     temp.id.toString())
                                                  .toList()[0];

                                          if (playlistSongs
                                              .where((element) =>
                                                  element.id.toString() ==
                                                  songId)
                                              .isEmpty) {
                                            playlistSongs
                                                .add(songid_to_platlist);
                                            box.put(playlistsname[index],
                                                playlistSongs);
                                            Get.find<NowPlayingController>()
                                                .AddedToplaylist();
                                          } else {
                                            Get.find<NowPlayingController>()
                                                .RemovedFromPlaylist();
                                          }

                                          Navigator.pop(context);
                                        },
                                        child: playlistTile(
                                            playlistNameFromTile:
                                                playlistsname[index],
                                            PlaylistName:
                                                playlistsname[index].toString(),
                                            SongsNumber: playlistSongs.length
                                                .toString()),
                                      )
                                    : Container());
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
