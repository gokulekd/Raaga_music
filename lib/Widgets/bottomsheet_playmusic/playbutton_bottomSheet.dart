import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/Widgets/musicPlayPage/openPlayer.dart';

class playButton_bottomSheet extends StatefulWidget {
  dynamic PlayButton_obj_assetAudioplayer;
  playButton_bottomSheet(
      {Key? key, required this.PlayButton_obj_assetAudioplayer})
      : super(key: key);

  @override
  State<playButton_bottomSheet> createState() => _playButton_bottomSheetState();
}

class _playButton_bottomSheetState extends State<playButton_bottomSheet> {
  
  bool isPressed= true ;

  @override
  Widget build(BuildContext context) {
setState(() {
  
});
  
    return PlayerBuilder.isPlaying(
        player: widget.PlayButton_obj_assetAudioplayer,
        builder: (context, isPlaying) {
          return Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () async {
                widget.PlayButton_obj_assetAudioplayer
                          .playOrPause();
                            

                      setState(() {
                    
                        isPressed = !isPressed;
                      });
                          widget.PlayButton_obj_assetAudioplayer
                          .playOrPause();
                    },
                    child: AnimatedContainer(
                      height: 60,
                      width: 60,
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(isPressed ? 0.2 : 0.0),
                            blurRadius: 20,
                            offset: Offset(5, 10),
                          ),
                        ],
                        color: isPressed
                            ? Color.fromARGB(255, 199, 196, 207)
                            : Color.fromARGB(248, 181, 160, 223)
                                .withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPressed ? Icons.pause : Icons.play_arrow,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
