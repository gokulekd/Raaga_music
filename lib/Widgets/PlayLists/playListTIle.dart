import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:raaga/dataBase/songModel.dart';

class playlistTile extends StatefulWidget {
  String PlaylistName;
  String SongsNumber;
  String playlistNameFromTile;

  playlistTile({
    Key? key,
    required this.PlaylistName,
    required this.SongsNumber,
    required this.playlistNameFromTile,
  }) : super(key: key);

  @override
  State<playlistTile> createState() => _playlistTileState();
}

final box = Raaga_SongData.getInstance();
String? _title;

class _playlistTileState extends State<playlistTile> {
  List playlistsname_keys = box.keys.toList();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 300,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 71, 64, 131),
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 22, 24, 63),
            borderRadius: BorderRadius.circular(15),
          ),
          width: 60,
          height: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: const Icon(
              FontAwesomeIcons.music,
              size: 30,
              color: Color.fromARGB(255, 215, 206, 205),
            ),
          ),
        ),
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 5, left: 5),
              child: Icon(
                Icons.my_library_music_rounded,
                size: 17,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5, left: 5),
              child: Text(
                widget.PlaylistName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(194, 200, 197, 207),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 5, left: 5, top: 15),
              child: Icon(
                Icons.music_note,
                size: 17,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5, left: 5, top: 15),
              child: Text(
                widget.SongsNumber + " songs",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(119, 234, 185, 185).withOpacity(.8),
                ),
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton(
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
            PopupMenuItem(
              value: 1,
              onTap: () async {},
              child: Row(children: const [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(FontAwesomeIcons.edit),
                ),
                Text(
                  "Edit Playlist",
                )
              ]),
            ),
            PopupMenuItem(
              value: 2,
              onTap: () async {},
              child: Row(children: const [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(FontAwesomeIcons.trash),
                ),
                Text(
                  "Delete Playlist",
                )
              ]),
            ),
          ],
          onSelected: (value) async {
            if (value == 1) {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  backgroundColor: Color.fromARGB(255, 205, 206, 234),
                  title: const Center(
                      child: Text(
                    'Edit Playlist Name',
                    style: TextStyle(color: Color.fromARGB(255, 89, 96, 110)),
                  )),
                  content: Container(
                    width: 100,
                    height: 100,
                    color: Color.fromARGB(255, 205, 206, 234),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            initialValue: widget.playlistNameFromTile,
                            decoration: InputDecoration(
                                fillColor: Color.fromARGB(255, 205, 206, 234),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(239, 16, 35, 50),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 12, 16, 28),
                                  ),
                                ),
                                hintText: "Edit Playlist Name"),
                            onChanged: (value) {
                              _title = value.trim();
                            },
                            validator: (value) {
                              List keys = box.keys.toList();
                              if (value!.trim() == "") {
                                return "Name Required";
                              }
                              if (keys
                                  .where((element) => element == value.trim())
                                  .isNotEmpty) {
                                return "This name already exits";
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
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (_formKey.currentState!.validate()) {
                          List? playlists =
                              box.get(widget.playlistNameFromTile);
                          box.put(_title, playlists!);
                          box.delete(widget.playlistNameFromTile);
                        }
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              );

              Navigator.canPop(context);
            }

            if (value == 2) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  backgroundColor: Color.fromARGB(255, 205, 206, 234),
                  title: const Text(
                    'Delete Playlist',
                    textAlign: TextAlign.center,
                  ),
                  content: const Text(" Do you want to Delete this playlist"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.black)),
                    ),
                    TextButton(
                      onPressed: () async {
                        await box.delete(widget.playlistNameFromTile);
                        playlistsname_keys = box.keys.toList();
                        
                        Get.back();
                      },
                      child: const Text('Done',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
