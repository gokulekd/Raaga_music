import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/dataBase/songModel.dart';



class bottomsheet_plalist_songView_Page extends StatefulWidget {
  var playlistNameBottomSheet;
bottomsheet_plalist_songView_Page({ Key? key,required this.playlistNameBottomSheet}) : super(key: key);


  @override
  State<bottomsheet_plalist_songView_Page> createState() => _bottomsheet_plalist_songView_PageState();
}

class _bottomsheet_plalist_songView_PageState extends State<bottomsheet_plalist_songView_Page> {
final box = Raaga_SongData.getInstance();

  List<songDataBaseModel> dbSongs = [];
  List<songDataBaseModel> playlistSongs = [];
  @override
  void initState() {
    super.initState();
    fullSongs();
  }

  fullSongs() {
    dbSongs = box.get("musics") as List<songDataBaseModel>;

    playlistSongs = box.get(widget.playlistNameBottomSheet)!.cast<songDataBaseModel>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dbSongs.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10,top
          : 10),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 93, 103, 195),
              borderRadius: BorderRadius.circular(30)

            ),
          
            child: ListTile(
              leading: SizedBox(
                height: 50.h,
                width: 50.w,
                child: QueryArtworkWidget(
                  id: dbSongs[index].id!,
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(15),
                  artworkFit: BoxFit.cover,
                  nullArtworkWidget: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                        image: AssetImage("assets/songs logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                dbSongs[index].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,style: TextStyle(color: Color.fromARGB(201, 255, 255, 255)),
              ),
              subtitle: Text(
                dbSongs[index].artist!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,style: TextStyle(color: Color.fromARGB(201, 255, 255, 255)),
              ),
              trailing: playlistSongs
                      .where((element) =>
                          element.id.toString() == dbSongs[index].id.toString())
                      .isEmpty
                  ? IconButton(
                      onPressed: () async {
                        playlistSongs.add(dbSongs[index]);
                        await box.put(widget.playlistNameBottomSheet, playlistSongs);

                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ))
                  : IconButton(
                      onPressed: () async {
                        playlistSongs.removeWhere((elemet) =>
                            elemet.id.toString() == dbSongs[index].id.toString());

                        await box.put(widget.playlistNameBottomSheet, playlistSongs);
                        setState(() {});
                      },
                      icon: const Icon(Icons.check_box, color: Color.fromARGB(255, 252, 252, 252)),
                    ),
            ),
          ),
        );
      },
    );
  }
}
