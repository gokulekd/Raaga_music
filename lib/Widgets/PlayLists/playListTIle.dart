import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:raaga/Pages/pageView_playlist.dart';
import 'package:raaga/Widgets/PlayLists/playlist_SongView_page.dart';
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
        color:  Color.fromARGB(255, 71, 64, 131),
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
                  color: Color.fromARGB(194, 221, 212, 241),
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
          icon: const FaIcon(
            FontAwesomeIcons.circleChevronDown,
            size: 17,
            color: Color.fromARGB(255, 207, 200, 222),
          ),
          itemBuilder: (BuildContext context) => [
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
          onSelected: (value) async {
            if (value == 1) {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Edit Playlist',
                    textAlign: TextAlign.center,
                  ),
                  content: Container(
                    width: 100,
                    height: 100,
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            initialValue: widget.playlistNameFromTile,
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
                            onChanged: (value) {
                              _title = value.trim();
                            },
                            validator: (value) {
                              List keys = box.keys.toList();
                              if (value!.trim() == "") {
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
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                                bottom: 75, right: 10, left: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            backgroundColor: Color.fromARGB(255, 42, 41, 123),
                            duration: Duration(seconds: 1),
                            content: const Text(
                              "  Playlist re-named",
                            ),
                          ),
                        );
                      },
                      child: const Text('Done'),
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
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        box.delete(widget.playlistNameFromTile);
                        setState(() {
                          playlistsname_keys = box.keys.toList();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                                bottom: 75, right: 10, left: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            backgroundColor: Color.fromARGB(255, 42, 41, 123),
                            content: Text("play List deleted"),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('Done'),
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
      
      
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//              color: Color.fromARGB(255, 210, 189, 229),
//           ),
//           height: 75,
//           width: 320,
//         child: Row(
//           children: [
         
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//                     SizedBox(
//                     height: 12,
//                      ),
//                         Container(
//                           height: 30,
//                           width: 220,
                         
//                           child: 
//                         ),
    
//                       SizedBox(height: 1,),
//                       Container(
//                            height: 30,
//                     width: 220,
                     
//                         child: 
//                       )
//              ], 
//             ),
//             Column(
            
//               children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: IconButton(onPressed: (){
    
    
//                               showDialog<String>(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         title: const Text(
//                           'Edit Playlist',
//                           textAlign: TextAlign.center,
//                         ),
//                         content: Container(
//                           width: 100,
//                           height: 100,
//                           color: Colors.white,
//                           child: Form(
//                             key: _formKey,
//                             child: Column(
//                               children: <Widget>[
//                                 TextFormField(
//                                   decoration: InputDecoration(
//                                      fillColor: Colors.white,
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide: BorderSide(
//                           color: Colors.blue,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide: BorderSide(
//                           color: Color.fromARGB(255, 54, 101, 244),
                    
//                         ),
//                       ),
                                
//                                     hintText: "Edit Playlist Name"
//                                   ),
    
                                  
//                                   validator: (value) {
//                                     // validation logic
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, 'Cancel'),
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 // text in form is valid
//                               }
//                             },
//                             child: const Text('Done'),
//                           ),
//                         ],
//                       ),
//                     );
    
    
    
//                             }, icon: Icon(Icons.edit,color: Color.fromARGB(255, 128, 81, 81),size: 20,)),
//                           ),
//                           Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: IconButton(
//                         onPressed: () {
    
                                
//                               showDialog<String>(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         title: const Text(
//                           'Delete Playlist',
//                           textAlign: TextAlign.center,
//                         ),
//                         content:Text(" Do you want to Delete this playlist"),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, 'Cancel'),
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 // text in form is valid
//                               }
//                             },
//                             child: const Text('Done'),
//                           ),
//                         ],
//                       ),
//                     );
    
    
    
    
//                         }, icon: Icon(Icons.delete),color: Color.fromARGB(255, 128, 81, 81),),
//                   )
//               ],
//             ),
//           ],
//         ),
          
          
//         ),
//       ),
//     );
//   }
// }

