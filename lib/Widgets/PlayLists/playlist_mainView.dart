import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:raaga/Pages/Screen_Splash.dart';
import 'package:raaga/Widgets/PlayLists/createNewPlaylistButton.dart';
import 'package:raaga/Widgets/PlayLists/playListTIle.dart';
import 'package:raaga/Widgets/PlayLists/playlist_SongView_page.dart';
import 'package:raaga/dataBase/songModel.dart';

import '../../Pages/pageView_playlist.dart';

class playlistmain_View extends StatefulWidget {
  final songid;
  playlistmain_View({Key? key, required this.songid}) : super(key: key);

  @override
  State<playlistmain_View> createState() => _playlistmain_ViewState();
}

final box = Raaga_SongData.getInstance();

class _playlistmain_ViewState extends State<playlistmain_View> {
  List playlistsname = box.keys.toList();
  List<songDataBaseModel> playlistSongs = [];

  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
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
                  builder: (BuildContext context) => createNewPlaylistButton());
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
              playlistsname = box.keys.toList();
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 100),
                itemCount: playlistsname.length,
                itemBuilder: (context, index) {
                    var  playlistSongs = box.get(playlistsname[index])!.cast<songDataBaseModel>();
                  final songidToPlatlist = dbSongs_dataBase
                      .where(
                          (element) => element.id.toString() == widget.songid)
                      .toList()[0];
                  return Container(
                      child: playlistsname[index] != "musics" &&
                              playlistsname[index] != "favourites" &&
                              playlistsname[index] != "Recently_Played"
                                ?
                          
                             
                         
                                
                                 GestureDetector(
                                  
                                  
                                    onTap: () {
                                       playlistSongs.where((element) => element.id.toString() == songidToPlatlist.toString()).isEmpty?
                                      

                                         //  final songid_to_platlist =dbSongs_dataBase.where((element) => element.id.toString()== widget.songid).toList()[0];
                                            //  print(playlistSongs[index].id);
                                            //  print(songid_to_platlist.id);
   
                                          setState(() {
                                             playlistSongs.add(songidToPlatlist);
                                             box.put(playlistsname[index], playlistSongs);
                                         
                                          }):

                                                
                                      
                                     
                                  
                                      ScaffoldMessenger.of(context)
                                          .removeCurrentSnackBar();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.only(
                                              bottom: 0, right: 10, left: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          backgroundColor:
                                              Color.fromARGB(255, 51, 49, 146),
                                          duration: Duration(milliseconds: 500),
                                          content: Text(
                                            " allready exist",
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
                                  ):Container()
                               
                              
                  
                                      
                                         

                                                
                                      
                                     
                                  
                                   
                                  
                          
                          
                          
                          );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
