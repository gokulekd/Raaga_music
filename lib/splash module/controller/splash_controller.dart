import 'package:get/get.dart';
import 'package:raaga/splash%20module/widgets/fetchsongs.dart';

import '../../common module/bottom_navbar/view/BottomNavbar.dart';

class SplashController extends GetxController {
  
  @override
  void onInit() {
    super.onInit();
    fetchSongs();
    navigate() ;
  }

  navigate() async {
      await Future.delayed(const Duration(seconds: 3));
    // Navigator.of(context)
    //     .pushReplacement(MaterialPageRoute(builder: (ctx) => BottomNavigation()));
    Get.to(const BottomNavigation(),transition: Transition.rightToLeft,duration: const Duration(seconds: 2));
 
}


}
