
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/splash%20module/view/Screen_Splash.dart';
import 'package:raaga/my%20music%20module/widgets/song_tile_menu.dart';

class MusicTile extends StatelessWidget {
  final index;
  const MusicTile({
    Key? key,required this.index,
    required double w,
  }) : _w = w, super(key: key);

  final double _w;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
      height: _w / 6,
      width: _w,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color:  Color.fromARGB(255, 71, 64, 131),
        borderRadius:  BorderRadius.only(
          topRight:  Radius.circular(30),
          bottomRight:  Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            width: 45.w,
            height: 45.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: QueryArtworkWidget(
                  nullArtworkWidget: Image.asset(
                    "assets/songs logo.png",
                    fit: BoxFit.cover,
                  ),
                  id: int.parse(fullSongs[index].metas.id!),
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
                      color: Color.fromARGB(207, 215, 210, 225),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(right: 4),
                      width: 185.w,
                      height: 25.h,
                      child: Marquee(
                        velocity: 20,
                        text: fullSongs[index].metas.title!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(207, 215, 210, 225),
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
                      color: Color.fromARGB(207, 215, 210, 225),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: REdgeInsets.only(right: 4),
                      width: 185.w,
                      height: 18.h,
                      child: Text(
                        fullSongs[index].metas.artist!,
                        style: const TextStyle(
                          fontSize: 15,
                          color:  Color.fromARGB(
                              157, 255, 255, 255),
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
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: song_tile_menu(
                    songId: fullSongs[index].metas.id!),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
