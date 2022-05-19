import 'package:flutter/material.dart';

class createPlaylist extends StatefulWidget {
  const createPlaylist({Key? key}) : super(key: key);

  @override
  State<createPlaylist> createState() => _createPlaylistState();
}

class _createPlaylistState extends State<createPlaylist> {
  @override
  Widget build(BuildContext context) {
    return 
           AlertDialog(
            title: const Text(
              'Add To Playlist',
              textAlign: TextAlign.center,
            ),
            content: Container(
              width: 100,
              height: 200,
              color: Colors.white,
              child: ListView(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Melody",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Ever Green",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                
                child: const Text('Create new Playlist'),
                onPressed: () => Navigator.pop(context, 'Create new Playlist'),
              ),
            ],
          );
        
  }
}
