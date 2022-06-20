
import 'package:flutter/material.dart';
import 'package:raaga/common%20module/drawer/drawer_Raaga.dart';
import 'package:raaga/splash%20module/view/Screen_Splash.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/common%20module/openPlayer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:raaga/common%20module/constants.dart';
import 'package:raaga/common%20module/music_tile.dart';


final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");
class ScreenMyMusic extends StatelessWidget {
  ScreenMyMusic({Key? key}) : super(key: key);

  final _audioQuery = OnAudioQuery();

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor:maincolor,
        elevation: 10,
        title: const Text('RAAGA'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu)),
      ),
      drawer:  drawer_Raaga(),
      body: SafeArea(
        child: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
            sortType: SongSortType.ALBUM,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty) {
              return  Center(
                child:  Text(" No Songs Found",style: TextStyle(fontSize: 20,color: whitecolor),),
              );
            }
            return ListView.builder(
              itemCount: fullSongs.length,
              itemBuilder: (context, index) => InkWell(
                enableFeedback: true,
                onTap: () async {
                  await OpenPlayer(fullSongs: fullSongs, index: index)
                      .openAssetPlayer(index: index, songs: fullSongs);
                },
   
                child: MusicTile(w: _w,index: index),
              ),
              padding: const EdgeInsets.only(bottom: 80, top: 8),
            );
          },
        ),
      ),
    );
  }
}
