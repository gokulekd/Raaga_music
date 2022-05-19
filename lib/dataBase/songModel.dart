import 'package:hive_flutter/hive_flutter.dart';
part 'songModel.g.dart';



@HiveType(typeId: 0)
class songDataBaseModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String? artist;
  @HiveField(2)
  final String? songAlbumsname;
   @HiveField(3)
   final String? uri;
    @HiveField(4)
    final int? duration;
     @HiveField(5)
     final int? id;


  songDataBaseModel(
      {
      required this.title,
      required this.artist,
      required this.songAlbumsname,
      required this.uri,
      required this.duration,
      required this.id,

      });
}



String boxname = "songs";



class Raaga_SongData {
  static Box<List>? _box;

  static Box<List> getInstance() {
    return _box ??= Hive.box(boxname);
  }
} 