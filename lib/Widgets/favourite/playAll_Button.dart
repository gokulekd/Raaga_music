import 'package:flutter/material.dart';

class PlayAll_Button extends StatefulWidget {
    var name;
  IconData iconName1;
    IconData iconName2;
  Function onTap;

PlayAll_Button({Key? key,required this.iconName1,required this.name,required this.onTap,required this.iconName2}) : super(key: key);

  @override
  State<PlayAll_Button> createState() => _PlayAll_ButtonState();
}

class _PlayAll_ButtonState extends State<PlayAll_Button>
    with TickerProviderStateMixin {

  bool isPressed = true;
  bool isPressed2 = true;
  bool isHighlighted = true;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){widget.onTap();},
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onHighlightChanged: (value) {
          setState(() {
            isHighlighted = !isHighlighted;
          });
        },
        onTap: () {
          setState(() {
            isPressed2 = !isPressed2;
          });
        },
        child: Center(
          child: AnimatedContainer(
              padding: EdgeInsetsDirectional.only(start: 20),
              margin: EdgeInsets.all(isHighlighted ? 0 : 2.5),
              height: isHighlighted ? 40 : 25,
              width:180,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: Offset(5, 10),
                  ),
                ],
                color: Color.fromARGB(255, 95, 65, 131),
              ),
              child: Row(
                children: [
                  Center(child: isPressed2 ? Icon(widget.iconName1,color: Colors.white,size: 25,) : Icon(widget.iconName2,color: Color.fromARGB(255, 105, 11, 168) ,)),
                  SizedBox(width: 10,),
                  Center(
                    child: isPressed2? Text(
                           widget.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        : Text(
                       widget.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 105, 11, 168)),
                          ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
