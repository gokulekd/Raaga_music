import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:raaga/splash%20module/view/Screen_Splash.dart';
import 'package:raaga/dataBase/songModel.dart';

fetchSongs() async {
  final box = Raaga_SongData.getInstance();
  final _audioQuery = OnAudioQuery();
  List<SongModel> fetchedSongs_OnAudioQuery = [];
  List<SongModel> allSongs_OnAudioQuery = [];

  bool permissionStatus = await _audioQuery.permissionsStatus();
  if (!permissionStatus) {
    await _audioQuery.permissionsRequest();
  }
  fetchedSongs_OnAudioQuery = await _audioQuery.querySongs();

  for (var element in fetchedSongs_OnAudioQuery) {
    if (element.fileExtension == "mp3") {
      allSongs_OnAudioQuery.add(element);
    }
  }
  mappedSongs_dataBase = allSongs_OnAudioQuery
      .map(
        (audio) => songDataBaseModel(
            title: audio.title,
            artist: audio.artist,
            songAlbumsname: audio.album,
            uri: audio.uri,
            duration: audio.duration,
            id: audio.id),
      )
      .toList();

  await box.put("musics", mappedSongs_dataBase);
  dbSongs_dataBase = box.get("musics") as List<songDataBaseModel>;
  for (var element in dbSongs_dataBase) {
    fullSongs.add(
      Audio.file(
        element.uri.toString(),
        metas: Metas(
            title: element.title,
            id: element.id.toString(),
            artist: element.artist),
      ),
    );
  }
}
