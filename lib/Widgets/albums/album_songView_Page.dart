import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/Widgets/PlayLists/createNewPlayList.dart';
import 'package:raaga/Widgets/musicPlayPage/openPlayer.dart';

class album_SongView_page extends StatefulWidget {
    List<Audio> Fullsongs = [];
album_SongView_page({ Key? key }) : super(key: key);

  @override
  State<album_SongView_page> createState() => _album_SongView_pageState();
}

class _album_SongView_pageState extends State<album_SongView_page> {

  final _audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
      double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 187, 116, 194),
        title: const Text("Album Songs"),
        centerTitle: true,

      ),
      body:         FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
            sortType: null,
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
              return const Center(
                child: Text(" No Songs Found"),
              );
            }
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Opacity(
                opacity: 1,
                child: InkWell(
                  enableFeedback: true,
                  onTap: () async {
                      

                    print("hai");

                    await OpenPlayer(fullSongs: [], index: index)
                        .openAssetPlayer(index: index, songs: widget.Fullsongs);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(_w / 30, _w / 30, _w / 30, 0),
                    height: _w / 4.5,
                    width: _w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffB993CB),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 55.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: QueryArtworkWidget(
                                nullArtworkWidget: Image.asset(
                                  "assets/songs logo.png",
                                  fit: BoxFit.cover,
                                ),
                                id: item.data![index].id,
                                artworkBorder: BorderRadius.circular(5.0),
                                type: ArtworkType.AUDIO),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: const Icon(
                                    Icons.music_note,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    width: 185.w,
                                    height: 25.h,
                                    child: Marquee(
                                      velocity: 20,
                                      text: item.data![index].displayNameWOExt,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: const Icon(
                                    Icons.album,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    margin: REdgeInsets.only(right: 4),
                                    width: 185.w,
                                    height: 18.h,
                                    child: Text(
                                      item.data![index].artist.toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            
                          
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}