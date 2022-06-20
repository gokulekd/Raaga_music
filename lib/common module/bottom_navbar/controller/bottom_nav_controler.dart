import 'package:get/get.dart';

class BottomNavbarController extends GetxController{
     var selectedIndex = 0.obs;
    @override
  void onInit() {

    super.onInit();

  }
  indexchange(int index){
    selectedIndex.value = index;
    update();
  }


}