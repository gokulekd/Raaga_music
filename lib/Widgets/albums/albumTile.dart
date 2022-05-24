import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          margin: const EdgeInsets.all(15),
           padding: const EdgeInsets.all(5),
          height: 225.h,
          width:160.w,
    
          child: Column(
            children: [
        
              Container(
                width: 140.w,
                height: 160.h,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               color: Colors.blue
             ),
             child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
               child: Image.network("https://static.toiimg.com/photo/msid-88588422/88588422.jpg?45754",fit: BoxFit.cover,),
             ),
              ),
               const SizedBox(height: 10,),
              const Text("Bro Daddy",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              const Text("123Musiq.com"),
    
            ],
          ),
          
        ),
      ),
    );
  }
}