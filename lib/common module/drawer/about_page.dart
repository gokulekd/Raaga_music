import 'package:flutter/material.dart';

class About_Page_Raaga extends StatelessWidget {
  const About_Page_Raaga({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar:AppBar(
        title: Text("About"),
      ),
      body: Center(
        child: Text("about"),
      ),
    );
  }
}