import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:raaga/splash%20module/view/Screen_Splash.dart';
import 'package:raaga/common%20module/constants.dart';
import '../../my music module/view/screen_my_music.dart';

class NowPlayingController extends GetxController {
  RxBool isshuffledbool = true.obs;
  RxBool isaddedToFavourite = true.obs;
  isPlaymodechanged(bool value) {
    isshuffledbool.value = value;
    update();
  }

  isaddedToFavouritecheck(bool value) async {
    isaddedToFavourite.value = value;
    update();
  }

  songshuffled() {
    assetAudioPlayer.toggleShuffle();
    Get.closeAllSnackbars();
    Get.snackbar("Message", "  shuffled Song Play",
        duration: const Duration(milliseconds: 900), colorText: whitecolor);
    update();
  }

  songlooped() {
    assetAudioPlayer.setLoopMode(LoopMode.playlist);
    Get.closeAllSnackbars();
    Get.snackbar("Message", "  looped Song Play",
        duration: const Duration(milliseconds: 900), colorText: whitecolor);
    update();
  }

  favaddedSnak() {
    Get.closeAllSnackbars();
    Get.snackbar("Message", "added to Favourite",
        duration: const Duration(milliseconds: 900), colorText: whitecolor);
    update();
  }
   favRemovedSnak() {
    Get.closeAllSnackbars();
    Get.snackbar("Message", "Remove from Favourite",
        duration: const Duration(milliseconds: 900), colorText: whitecolor);
    update();
  }
     AddedToplaylist() {
    Get.closeAllSnackbars();
    Get.snackbar("Message", "Added to Playlist",
        duration: const Duration(milliseconds: 900), colorText: whitecolor);
    update();
  }
       RemovedFromPlaylist() {
    Get.closeAllSnackbars();
    Get.snackbar("Message", "Allready Exist ",
        duration: const Duration(milliseconds: 900), colorText: whitecolor);
    update();
  }
}
