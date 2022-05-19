import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/dataBase/songModel.dart';

class searchBar extends StatefulWidget {
  List<Audio> fullSongs = [];
  searchBar({Key? key, required this.fullSongs}) : super(key: key);

  @override
  State<searchBar> createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  @override
  final box = Raaga_SongData.getInstance();
  String search = "";

  List<songDataBaseModel> dbSongs = [];
  List<Audio> allSongs = [];

  searchSongs() {
    dbSongs = box.get("musics") as List<songDataBaseModel>;
    // ignore: avoid_function_literals_in_foreach_calls
    dbSongs.forEach(
      (element) {
        allSongs.add(
          Audio.file(
            element.uri.toString(),
            metas: Metas(
                title: element.title,
                id: element.id.toString(),
                artist: element.artist),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    searchSongs();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Audio> searchTitle = allSongs.where((element) {
      return element.metas.title!.toLowerCase().startsWith(
            search.toLowerCase(),
          );
    }).toList();

    List<Audio> searchArtist = allSongs.where((element) {
      return element.metas.artist!.toLowerCase().startsWith(
            search.toLowerCase(),
          );
    }).toList();

    List<Audio> searchResult = [];
    if (searchTitle.isNotEmpty) {
      searchResult = searchTitle;
    } else {
      searchResult = searchArtist;
    }

    return Scaffold(
     backgroundColor:const Color(0xff262054),
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor:const Color(0xff262054),
        title: Container(
          padding: const EdgeInsets.only(top: 3),
          width: 390,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(255, 61, 45, 104),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                FontAwesomeIcons.search,color: Colors.white,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Search Songs ",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),

      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              height: MediaQuery.of(context).size.height * .07,
              width: MediaQuery.of(context).size.width * .9,
              child: TextField(
                cursorHeight: 18.h,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                
                  contentPadding:
                      EdgeInsets.only(top: 14.h, right: 10.w, left: 10.w),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Color.fromRGBO(119, 68, 201, 1),
                  ),
                  hintText: ' Search a song',
                  filled: true,
                  fillColor: Color.fromARGB(255, 215, 211, 220),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      search = value.trim();
                    },
                  );
                },
              ),
            ),
            search.isNotEmpty
                ? searchResult.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                              future: Future.delayed(
                                const Duration(microseconds: 0),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return GestureDetector(
                                    child: ListTile(
                                      leading: SizedBox(
                                        height: 50.h,
                                        width: 50.w,
                                        child: QueryArtworkWidget(
                                          id: int.parse(
                                              searchResult[index].metas.id!),
                                          type: ArtworkType.AUDIO,
                                          artworkBorder:
                                              BorderRadius.circular(15),
                                          artworkFit: BoxFit.cover,
                                          nullArtworkWidget: Container(
                                            height: 50.h,
                                            width: 50.w,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/songs logo.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        searchResult[index].metas.title!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 227, 216, 216),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      subtitle: Text(
                                        searchResult[index].metas.artist!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                               color: Color.fromARGB(255, 188, 175, 175),
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            );
                          },
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(30.h.w),
                        child: Text(
                          "No Result Found",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:raaga/dataBase/songModel.dart';

// class searchBar_Mymusic extends SearchDelegate{

//   final List<String> nameOfSongs;
//   searchBar_Mymusic(this.nameOfSongs);
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//   IconButton(onPressed: (){}, icon: Icon(Icons.clear));
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//   return IconButton(onPressed: (){}, icon: Icon(Icons.backspace_sharp));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
// final suggetions = nameOfSongs.where((value){
// return value.toString().toLowerCase().contains(query.toLowerCase());
//   });
//   return ListView.builder(
//     itemCount: suggetions.length,
//     itemBuilder: (BuildContext context,int index){
//       return ListTile(
// title: Text(suggetions.elementAt(index)),
//       );
//     }
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//  final suggetions = nameOfSongs.where((value){
// return value.toString().toLowerCase().contains(query.toLowerCase());
//   });
//   return ListView.builder(
//     itemCount: suggetions.length,
//     itemBuilder: (BuildContext context,int index){
//       return ListTile(
// title: Text(suggetions.elementAt(index)),
//       );
//     }
//     );
//   }
  
// }