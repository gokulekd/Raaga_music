// ignore_for_file: unnecessary_const

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/Widgets/musicPlayPage/pageView_musicPlay.dart';

class bottomsheet_musicPlay extends StatefulWidget {
  List<Audio> Allsongs_bottomsheet = [];

  bottomsheet_musicPlay({Key? key, required this.Allsongs_bottomsheet})
      : super(key: key);

  @override
  State<bottomsheet_musicPlay> createState() => _bottomsheet_musicPlayState();
}

class _bottomsheet_musicPlayState extends State<bottomsheet_musicPlay> {
  bool isPressed = true;
  bool isPressed2 = true;
  bool isHighlighted = true;


  final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      isPressed= !isPressed;
      
      
    });
    return GestureDetector(
      onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              musicPlay_pageView(AllSong: widget.Allsongs_bottomsheet,assetAudio_musicplayPage:assetAudioPlayer ,
              ),
              ),  
              );
                   }, 
    child: assetAudioPlayer.builderCurrent(
      builder: (BuildContext context, Playing? playing) {
        final myAudio =
            find(widget.Allsongs_bottomsheet, playing!.audio.assetAudioPath);

        return Container(
          color: const Color.fromARGB(255, 47, 40, 101),
          width: double.infinity,
          height: 75.h,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 55.w,
                height: 55.h,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: QueryArtworkWidget(
                      nullArtworkWidget: Image.asset(
                        "assets/songs logo.png",
                        fit: BoxFit.cover,
                      ),
                      id: int.parse(myAudio.metas.id!),
                      artworkBorder: BorderRadius.circular(5.0),
                      type: ArtworkType.AUDIO),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10,left: 5),
                        child: const Icon(
                          Icons.music_note,
                          size: 17,
                          color: const Color.fromARGB(207, 220, 214, 231),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                           padding: const EdgeInsets.only(left: 5,),
                        height: 20.h,
                        width: 150.w,
                        child: Text(
                          myAudio.metas.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Color.fromARGB(208, 211, 206, 193)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                            padding: EdgeInsets.only(top: 10,left: 5),
                        child: Icon(
                          Icons.album,
                          size: 17,
                          color: Color.fromARGB(207, 195, 190, 206),
                        ),
                      ),
                      Container(
                 
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.only(left: 10,),
                        height: 20.h,
                        width: 150.w,
                        child: Text(
                          myAudio.metas.artist!,
                          

                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 193, 190, 177)
                          )
                          
                       
                        ),
                      ),
                    ],
                  ),
                ],
              ),
                GestureDetector(
              onTap: () {

               
                   assetAudioPlayer.previous();
                   setState(() {
                            
                    isLotteplaying = true;
 
                   });
                   },
                 child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 22.h,
                    width: 22.w,
                    decoration: BoxDecoration(
                       color: const Color.fromARGB(248, 172, 162, 193),
                       borderRadius: BorderRadius.circular(50)
                    ),
                   
                    child: const Icon(Icons.fast_rewind_rounded,size: 20,),
               
                  )
                             ),
               ),

               GestureDetector(
                     onTap: (()async {
                     
                            await assetAudioPlayer.playOrPause();
                            setState(() {
                                isLotteplaying = assetAudioPlayer.isPlaying.value;
                       print(isLotteplaying);
 
                            });
                       
                     }),
                     child: Container(
                  
                        height: 47.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                             color:const Color.fromARGB(255, 182, 165, 200)),
                        child: PlayerBuilder.isPlaying(
                            player: assetAudioPlayer,
                            builder: (context, isPlaying) {
                              return 
                              
                                Icon(
                                  isPlaying ? Icons.pause  : Icons.play_arrow,
                                  size: 30.h.w,color: const Color.fromARGB(255, 86, 64, 147),
                                
                              );
                            }),
                      ),
                   ),

               GestureDetector(
                 onTap: () {

                   assetAudioPlayer.next();
                   setState(() {
                            
                    isLotteplaying = true;
 
                   });
                   },
                 child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 22.h,
                    width: 22.w,
                    decoration: BoxDecoration(
                       color: const Color.fromARGB(248, 172, 162, 193),
                       borderRadius: BorderRadius.circular(50)
                    ),
                   
                    child: const Icon(Icons.fast_forward_rounded,size: 20,),
               
                  )
                             ),
               ),
             
               
            
            ],
          ),
        );
      },
    ));
  }
}
