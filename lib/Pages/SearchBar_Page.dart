// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:marquee/marquee.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:raaga/Pages/Screen_Splash.dart';
// import 'package:raaga/Widgets/musicPlayPage/pageView_musicPlay.dart';
// import 'package:raaga/Pages/pageView_myMusic.dart';
// import 'package:raaga/Widgets/albums/albumTile.dart';
// import 'package:raaga/Widgets/bottomNavBar/BottomNavbar.dart';
// import 'package:raaga/Widgets/favourite/playAll_Button.dart';
// import 'package:raaga/Widgets/my%20music/myMusic_search.dart';
// import 'package:raaga/dataBase/songModel.dart';

// class SearchBar_Page extends StatefulWidget {
//   const SearchBar_Page({Key? key}) : super(key: key);

//   @override
//   State<SearchBar_Page> createState() => _SearchBar_PageState();
// }
// final box = Raaga_SongData.getInstance();
// class _SearchBar_PageState extends State<SearchBar_Page> {

  
//  final _audioQuery = OnAudioQuery();
// final List dbsongs = box.get("musics")!;
//  final controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {

//       double _w = MediaQuery.of(context).size.width;
     

//     return Scaffold(
//            backgroundColor:Color(0xff262054),
//       appBar: AppBar(
//         toolbarHeight: 80,
//              backgroundColor:Color(0xff262054),

   
     
//         centerTitle: true,
//         title: Container(
//           padding: EdgeInsets.only(top: 8),
//           width: 150,
//           height: 40,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: Color.fromARGB(255, 94, 33, 168),
//           ),
//           child: Text(
//             "search",
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//       body:
        
   
//           searchBar(fullSongs: fullSongs),
//     );
//   }
//       //      Padding(
//       //        padding: const EdgeInsets.all(8.0),
//       //        child: GestureDetector(
//       //          onTap: () {
//       // List songName = dbSongs_dataBase;
//       //            showSearch(context: context, delegate: searchBar(fullSongs: fullSongs));
//       //          },
//       //          child: Container(
//       //            height: 40,
//       //            width: 380,
//       //            decoration: BoxDecoration(  
//       //              borderRadius: BorderRadius.circular(20),  color: Color.fromARGB(149, 183, 178, 232),),
                     
                   
                    
//       //            ),
//       //        ),
//       //      ),
       
// //                     Expanded(child: 

// //                      FutureBuilder<List<SongModel>>(
// //           future: _audioQuery.querySongs(
// //             sortType: null,
// //             orderType: OrderType.ASC_OR_SMALLER,
// //             uriType: UriType.EXTERNAL,
// //             ignoreCase: true,
// //           ),
// //           builder: (context, item) {
// //             if (item.data == null) {
// //               return Center(
// //                 child: CircularProgressIndicator(),
// //               );
// //             }
// //             if (item.data!.isEmpty) {
// //               return Center(
// //                 child: Text(" No Songs Found"),
// //               );
// //             }
// //             return ListView.builder(
// //               itemCount:dbSongs_dataBase.length,
// //               itemBuilder: (context, index) =>
// //                InkWell(
// //                  enableFeedback: true,
        
// //                  highlightColor: Colors.transparent,
// //                  splashColor: Colors.transparent,
// //                  child: Container(
// //                    margin: EdgeInsets.only(right: 10,top: 10,bottom: 10),
// //                    height: _w / 6,
// //                    width: _w,
// //                    alignment: Alignment.center,
// //                    decoration: BoxDecoration(
// //                      color: Color.fromARGB(255, 71, 64, 131),
// //                      borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30),),
// //                    ),
// //                    child: Row(
// //                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                      children: [
// //                        Container(
// //                          margin: EdgeInsets.only(left: 10),
// //                          width: 45.w,
// //                          height: 45.h,
// //                          decoration: BoxDecoration(
// //                              borderRadius: BorderRadius.circular(10)),
// //                          child: ClipRRect(
// //                            borderRadius: BorderRadius.circular(10),
// //                            child: QueryArtworkWidget(
// //                                nullArtworkWidget: Image.asset(
// //                                  "assets/songs logo.png",
// //                                  fit: BoxFit.cover,
// //                                ),
// //                                id: item.data![index].id,
// //                                artworkBorder: BorderRadius.circular(5.0),
// //                                type: ArtworkType.AUDIO),
// //                          ),
// //                        ),
// //                        Column(
// //                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                          children: [
// //                            Row(
// //                              children: [
// //                                Container(
// //                                  margin: EdgeInsets.only(right: 5),
// //                                  child: Icon(
// //                                    Icons.music_note,
// //                                    size: 17,
// //                                    color: Color.fromARGB(207, 215, 210, 225),
// //                                  ),
// //                                ),
// //                                Center(
// //                                  child: Container(
// //                                    margin: EdgeInsets.only(right: 4),
// //                                    width: 185.w,
// //                                    height: 25.h,
// //                                    child: Marquee(
// //                                      velocity: 20,
// //                                      text: item.data![index].displayNameWOExt,
// //                                      style: TextStyle(
// //                                        fontSize: 18,
// //                                        fontWeight: FontWeight.w600,
// //                                        color: Color.fromARGB(207, 215, 210, 225),
// //                                      ),
// //                                    ),
// //                                  ),
// //                                ),
// //                              ],
// //                            ),
// //                            Row(
// //                              children: [
// //                                Container(
// //                                  margin: EdgeInsets.only(right: 5),
// //                                  child: Icon(
// //                                    Icons.album,
// //                                    size: 17,
// //                                    color:  Color.fromARGB(207, 215, 210, 225),
// //                                  ),
// //                                ),
// //                                Center(
// //                                  child: Container(
// //                                    margin: REdgeInsets.only(right: 4),
// //                                    width: 185.w,
// //                                    height: 18.h,
// //                                    child: Text(
// //                                      item.data![index].artist.toString(),
// //                                      style: TextStyle(
// //                                        fontSize: 15,
// //                                        color: Color.fromARGB(157, 255, 255, 255),
// //                                      ),
// //                                    ),
// //                                  ),
// //                                ),
// //                              ],
// //                            )
// //                          ],
// //                        ),
// //                        Column(
// //                          mainAxisAlignment: MainAxisAlignment.start,
// //                          crossAxisAlignment: CrossAxisAlignment.center,
// //                          children: [
                        
                        
// //                          ],
// //                        ),
// //                      ],
// //                    ),
// //                  ),
// //                ),
// //               padding: EdgeInsets.only(bottom: 80,top: 8),
// //             );
// //           },
// //         ),
// //                     )
// //         ],
// //       ),
                

   
      
// //     );
// //   }
// // }
// // var searchsongs;
// // void searchSongs(String Query) {
//     // List<Audio> searchTitle = allSongs.where((element) {
//     //     return element.metas.title!.toLowerCase().startsWith(
//     //           search.toLowerCase(),
//     //         );
//     //   }).toList();

//     //   final books = allBooks.where((book) {
//     //     final titleLower = book.title.toLowerCase();
//     //     final authorLower = book.author.toLowerCase();
//     //     final searchLower = query.toLowerCase();

//     //     return titleLower.contains(searchLower) ||
//     //         authorLower.contains(searchLower);
//     //   }).toList();

//     //   setState(() {
//     //     this.query = query;
//     //     this.books = books;
//     //   });
//   }