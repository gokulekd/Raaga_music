

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Widgets/PlayLists/createNewPlaylistButton.dart';
import '../../Widgets/PlayLists/playListTIle.dart';
import '../../now playing module/controller/NowplayingController.dart';
import '../../splash module/view/Screen_Splash.dart';

class PlaylistController extends GetxController{


  updatePlaylist(context,songID,){
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
                          color: const Color.fromARGB(255, 177, 177, 222),
                          borderRadius: const BorderRadius.all(
                             Radius.circular(30),
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
                          child:  Text(
                            "Create New Playlist",
                            style: TextStyle(
                                color:  Color.fromARGB(255, 86, 42, 118),
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
                          padding: const EdgeInsets.only(bottom: 100),
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
                                          final songidToPlatlist =
                                              dbSongs_dataBase
                                                  .where((element) =>
                                                      element.id.toString() ==
                                                      songID)
                                                  .toList()[0];

                                          if (playlistSongs
                                              .where((element) =>
                                                  element.id.toString() ==
                                                 songID)
                                              .isEmpty) {
                                            playlistSongs
                                                .add(songidToPlatlist);
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
}