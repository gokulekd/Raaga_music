// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:raaga/playlist%20module/controller/playlistController.dart';

// ignore: must_be_immutable
class AddtoPlayListFromNowPlaying extends StatelessWidget {
  final String songIdForNowPlaying;

  AddtoPlayListFromNowPlaying({Key? key, required this.songIdForNowPlaying})
      : super(key: key);
  PlaylistController controllerPlaylist = Get.put(PlaylistController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controllerPlaylist.updatePlaylist(context, songIdForNowPlaying);
      },
      child: Container(
          height: 35,
          width: 35,
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
