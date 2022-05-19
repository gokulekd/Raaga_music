import 'package:flutter/material.dart';
import 'package:raaga/Widgets/PlayLists/createNewPlayList.dart';
import 'package:raaga/Widgets/bottomsheet_playmusic/bottomsheet.dart';


// ignore: camel_case_types
class addToPlayList extends StatefulWidget {
  const addToPlayList({Key? key}) : super(key: key);

  @override
  _addToPlayListState createState() => _addToPlayListState();
}

class _addToPlayListState extends State<addToPlayList>
    with TickerProviderStateMixin {
  bool isPressed = true;
  bool isPressed2 = true;
  bool isHighlighted = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHighlightChanged: (value) {
        setState(() {
          isHighlighted = !isHighlighted;
        });
      },
      onTap: () {
     showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: new Icon(Icons.queue_music_outlined),
                            title: new Text('Ever Green'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),


                             ListTile(
                            leading: new Icon(Icons.queue_music_outlined),
                            title: new Text('Melody'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),


                           ListTile(
                            leading: new Icon(Icons.queue_music_outlined),
                            title: new Text('A R Rahman Hits'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),

                          ListTile(
                            leading: new Icon(Icons.queue_music_outlined),
                            title: new Text('Vijay Hits'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                     }
     );


     
        setState(() {
          isPressed2 = !isPressed2;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(isHighlighted ? 0 : 2.5),
        height: isHighlighted ? 35 : 25,
        width: isHighlighted ? 35 : 25,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(5, 10),
            ),
          ],
          color: Color.fromARGB(255, 210, 189, 229),
          shape: BoxShape.circle,
        ),
        child: isPressed2
            ? Icon(
                Icons.library_music_outlined,
                color: Colors.black.withOpacity(0.6),
              )
            : Icon(
                Icons.library_music_rounded,
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(1.0),
              ),
      ),
    );
  }
}
