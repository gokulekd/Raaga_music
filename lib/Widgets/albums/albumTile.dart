import 'package:flutter/material.dart';
import 'package:raaga/Widgets/albums/album_songView_Page.dart';

class albumTile extends StatefulWidget {


  const albumTile({ Key? key }) : super(key: key);

  @override
  State<albumTile> createState() => _albumTileState();
}

class _albumTileState extends State<albumTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
     Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => album_SongView_page()));
      
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.all(15),
           padding: EdgeInsets.all(5),
          height: 225,
          width:160,
    
          child: Column(
            children: [
        
              Container(
                width: 140,
                height: 160,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               color: Colors.blue
             ),
             child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
               child: Image.network("https://static.toiimg.com/photo/msid-88588422/88588422.jpg?45754",fit: BoxFit.cover,),
             ),
              ),
               SizedBox(height: 10,),
              Text("Bro Daddy",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("123Musiq.com"),
    
            ],
          ),
          
        ),
      ),
    );
  }
}