import 'package:flutter/material.dart';
import 'package:raaga/Pages/pageView_playlist.dart';
import 'package:raaga/dataBase/songModel.dart';

TextEditingController _controller = TextEditingController();
 var playlistNameKey =_controller.text; 
class createNewPlaylistButton extends StatefulWidget {
  const createNewPlaylistButton({Key? key}) : super(key: key);

  @override
  State<createNewPlaylistButton> createState() =>
      _createNewPlaylistButtonState();
}

class _createNewPlaylistButtonState extends State<createNewPlaylistButton> {

  List<songDataBaseModel> playlists = [];
  final box = Raaga_SongData.getInstance();
  String? title;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
  
    return 
     
   AlertDialog(
      title: const Text('Playlist Name'),
      content: Form(
          key: formkey,
          child: TextFormField(
            onChanged: (value) {
              title = value.trim();
            },
            validator: (value) {
              List keys = box.keys.toList();
              if (value!.trim() == "") {
                return "Name Required";
              }
              if (keys.where((element) => element == value.trim()).isNotEmpty) {
                return "This Name Already Exists";
              }
              return null;
            },
          )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    box.put(title, playlists);
                    Navigator.pop(context);
                    setState(() {});
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
      ],
    
    );
  }
}
