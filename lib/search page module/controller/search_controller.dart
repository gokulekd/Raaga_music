import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import '../../Widgets/PlayLists/playListTIle.dart';
import '../../dataBase/songModel.dart';

class SearchController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    searchSongs();
  }
      List<Audio> searchResult = [];

  List<songDataBaseModel> dbSongs = [];
  List<Audio> allSongs = [];
  var search = "".obs;
  searchtrim(value) {
    search.value = value.trim();
    update();
  }

  searchSongs() async {
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
}
