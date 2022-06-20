import 'package:get/get.dart';

class LotteController extends GetxController{
    RxBool isLotteplaying = true.obs;
    lotteChanger(bool boolvalue) {
    isLotteplaying.value = boolvalue;
    update();
  }

}



