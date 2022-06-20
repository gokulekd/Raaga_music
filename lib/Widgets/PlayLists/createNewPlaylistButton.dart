import 'package:flutter/material.dart';
import 'package:raaga/dataBase/songModel.dart';

class createNewPlaylistButton extends StatelessWidget {
  createNewPlaylistButton({Key? key}) : super(key: key);

  List<songDataBaseModel> playlists = [];
  final box = Raaga_SongData.getInstance();
  String? title;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Color.fromARGB(255, 205, 206, 234),
      title: const Center(
          child: Text(
        'Playlist Name',
        style: TextStyle(color: Color.fromARGB(255, 89, 96, 110)),
      )),
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
