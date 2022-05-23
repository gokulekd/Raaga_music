import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/Pages/Screen_Splash.dart';
import 'package:raaga/dataBase/songModel.dart';
 List? mainFavouriteList = box.get("favourites");

 var dbSongs_dataBaseId ;
class showModelBottomSheet_favourite_Screen extends StatefulWidget {
  showModelBottomSheet_favourite_Screen({Key? key}) : super(key: key);

  @override
  State<showModelBottomSheet_favourite_Screen> createState() =>
      _showModelBottomSheet_favourite_ScreenState();
}

final box = Raaga_SongData.getInstance();

class _showModelBottomSheet_favourite_ScreenState
    extends State<showModelBottomSheet_favourite_Screen> {

      
  List? mainFavouriteList = box.get("favourites");

  bool istapped = false;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: fullSongs.length,
      itemBuilder: (context, index) =>

  
       InkWell(
        enableFeedback: true,
        onTap: () async {},
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.only(right: 5, top: 10, bottom: 10, left: 5),
          height: _w / 6,
          width: _w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 71, 64, 131),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 7),
                width: 45.w,
                height: 45.h,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: QueryArtworkWidget(
                      nullArtworkWidget: Image.asset(
                        "assets/songs logo.png",
                        fit: BoxFit.cover,
                      ),
                    id:dbSongs_dataBase[index].id!,
                      artworkBorder: BorderRadius.circular(20.0),
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
                          width: 220.w,
                          height: 25.h,
                          child: Marquee(
                            velocity: 20,
                            text: dbSongs_dataBase[index].title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color:  Color.fromARGB(207, 215, 210, 225),
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
                          color:  Color.fromARGB(207, 215, 210, 225),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: REdgeInsets.only(right: 4),
                          width: 220.w,
                          height: 18.h,
                          child: Text(
                            dbSongs_dataBase[index].artist.toString(),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(157, 255, 255, 255),
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
                    padding: const EdgeInsets.only(top: 8 , right: 8),
                    child: mainFavouriteList!
                            .where((element) =>
                                element.id.toString() ==
                                dbSongs_dataBase[index].id.toString())
                            .isEmpty
                        ? IconButton(
                            onPressed: () async {
                              istapped = !istapped;
                              mainFavouriteList!.add(dbSongs_dataBase[index]);
                              await box.put("favourites", mainFavouriteList!);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.favorite,
                              size: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ))
                        : IconButton(
                            onPressed: ()
                             async {
                              mainFavouriteList!.removeWhere((element) =>
                                  element.id.toString() ==
                                  dbSongs_dataBase[index].id.toString());
                              await box.put("favourites", mainFavouriteList!);
                              setState(() {});
                            },
                            icon: const Icon(Icons.favorite,
                                size: 20,
                                color: Color.fromARGB(255, 238, 21, 21)),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 80, top: 8),
    );
  }
}

  // songDataBaseModel databaseSongs(List<songDataBaseModel> songs, String id) {
  //   return songs.firstWhere(
  //     (element) => element.id.toString().contains(id),
  //   );
  // }