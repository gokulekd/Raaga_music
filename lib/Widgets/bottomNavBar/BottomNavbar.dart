import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:raaga/Pages/pageView_Favourite.dart';
import 'package:raaga/Pages/pageview_mymusic.dart';
import 'package:raaga/Pages/pageView_playlist.dart';
import 'package:raaga/Widgets/bottomsheet_playmusic/bottomsheet.dart';
import 'package:raaga/Widgets/my%20music/drawer/drawer_Raaga.dart';
import 'package:raaga/Pages/myMusic_search.dart';

class BottomNavigation extends StatefulWidget {
  List<Audio> allSongNav;
  BottomNavigation({Key? key, required this.allSongNav}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");
  final audioQuery = OnAudioQuery();
  int _selectedIndex = 0;

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final Pages = [
      Screen_MyMusic(),
      const pageView_Faourite(),
      searchBar(fullSongs: widget.allSongNav),
      const pageview_Playlist(),
    ];
    return Scaffold(
      drawer: const drawer_Raaga(),
      body: Pages[_selectedIndex],
      bottomSheet:
          bottomsheet_musicPlay(Allsongs_bottomsheet: widget.allSongNav),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: const Color.fromARGB(255, 47, 40, 101),
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        ),
        child: BottomNavigationBar(
            // fixedColor: Colors.red,

            currentIndex: _selectedIndex,
            onTap: (newindex) {
              setState(() {
                _selectedIndex = newindex;
              });
            },
            elevation: 0,
            selectedItemColor: const Color.fromARGB(247, 206, 206, 255),
            unselectedItemColor: const Color.fromARGB(255, 126, 113, 145),
            selectedFontSize: 16,
            items: const [
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 30,
                  child: Icon(
                    Icons.headphones_rounded,
                    size: 30,
                  ),
                ),
                label: "MyMusic",
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_outlined,
                    size: 30,
                  ),
                  label: "Favourite"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  label: "search"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.queue_music_sharp,
                    size: 30,
                  ),
                  label: "playlist"),
            ]),
      ),
    );
  }
}
