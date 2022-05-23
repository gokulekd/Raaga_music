// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:raaga/Widgets/PlayLists/createNewPlayList.dart';
import 'package:raaga/Widgets/PlayLists/createNewPlaylistButton.dart';
import 'package:raaga/Widgets/PlayLists/editButton.dart';

import 'package:raaga/Widgets/PlayLists/playListTIle.dart';
import 'package:raaga/Widgets/PlayLists/playlist_SongView_page.dart';
import 'package:raaga/Widgets/bottomNavBar/BottomNavbar.dart';
import 'package:raaga/Widgets/favourite/playAll_Button.dart';
import 'package:raaga/dataBase/songModel.dart';



class pageview_Playlist extends StatefulWidget {
  const pageview_Playlist({Key? key}) : super(key: key);

  @override
  State<pageview_Playlist> createState() => _pageview_PlaylistState();
}
final box = Raaga_SongData.getInstance();
List playlistsname = box.keys.toList();
List <songDataBaseModel>playlistSongs = [];

class _pageview_PlaylistState extends State<pageview_Playlist>
    with TickerProviderStateMixin {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xff262054),
        centerTitle: true,
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
                FontAwesomeIcons.circlePlay,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Playlist ",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xff262054),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onHighlightChanged: (value) {
                  setState(() {
                    isTapped = value;
                  },);
                },
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
                        : Color.fromARGB(255, 152, 152, 206),
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
                          color: Color.fromARGB(255, 60, 26, 85),
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
                    playlistsname = box.keys.toList();
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 100),
                        itemCount: playlistsname.length,
                        itemBuilder: (context, index) {

                          var playlistSongs = box.get(playlistsname[index])!;

                          return Container(
                            child: playlistsname[index] != "musics" &&
                                    playlistsname[index] != "favourites" &&
                                    playlistsname[index] != "Recently_Played"
                                ? GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Playlist_SongView_page(
                    playlistName:playlistsname[index]),
                                  ),
); 
                                  },
                                  child: playlistTile(
                                      playlistNameFromTile: playlistsname[index],
                                      PlaylistName:
                                          playlistsname[index].toString(),
                                      SongsNumber:
                                          playlistSongs.length.toString()),
                                )
                                : SizedBox(),
                          );
                        },
                        );
                  },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
