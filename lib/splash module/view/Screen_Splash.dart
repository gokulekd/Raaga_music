import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raaga/common%20module/bottom_navbar/view/BottomNavbar.dart';
import 'package:raaga/dataBase/songModel.dart';
import 'package:raaga/splash%20module/controller/splash_controller.dart';

import '../../Pages/pageView_playlist.dart';

List<songDataBaseModel> mappedSongs_dataBase = [];
List<Audio> fullSongs = [];
List<songDataBaseModel> dbSongs_dataBase = [];

// ignore: must_be_immutable
class ScreenSplash extends StatelessWidget {
  ScreenSplash({Key? key}) : super(key: key);

  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 393.w,
            height: 810.h,
            color: const Color(0xff262054),
          ),
          Column(
            children: [
              const SizedBox(height: 90),
              Text(
                'Raaga',
                style: TextStyle(
                  fontFamily: 'font1',
                  fontSize: 50.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40.5.h),
              Text(
                'Play Your Favourite Tunes',
                style: TextStyle(
                  fontFamily: 'font1',
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30.5.h),
              SizedBox(
                  height: 80,
                  width: 80,
                  child: Lottie.asset("assets/json/14467-music.json")),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 400.h,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Image.asset(
                      "assets/logo9.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
