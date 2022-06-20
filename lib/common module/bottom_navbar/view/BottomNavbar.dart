import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raaga/favourite%20module/view/pageView_Favourite.dart';
import 'package:raaga/my%20music%20module/view/screen_my_music.dart';
import 'package:raaga/Pages/pageView_playlist.dart';
import 'package:raaga/common%20module/bottom%20sheet/view/bottomsheet.dart';
import 'package:raaga/search%20page%20module/view/screen_search.dart';
import 'package:raaga/common%20module/bottom_navbar/controller/bottom_nav_controler.dart';

import '../../drawer/drawer_Raaga.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final pages = [
      ScreenMyMusic(),
       PageViewFaourite(),
       searchBar(),
       pageview_Playlist(),
    ];
    return GetBuilder<BottomNavbarController>(
        init: BottomNavbarController(),
        builder: (controller) {
          return Scaffold(
            drawer:  drawer_Raaga(),
            body: pages[controller.selectedIndex.value],
            bottomSheet: BottomsheetMusicPlay(),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: const Color.fromARGB(255, 47, 40, 101),
              ),
              child: BottomNavigationBar(
                  currentIndex: controller.selectedIndex.value,
                  onTap: (newindex) {
                    controller.indexchange(newindex);
                  },
                  elevation: 0,
                  selectedItemColor: const Color.fromARGB(247, 206, 206, 255),
                  unselectedItemColor: const Color.fromARGB(255, 126, 113, 145),
                  selectedFontSize: 16,
                  items: const [
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        height: 30,
                        child: Icon(
                          Icons.headphones_rounded,
                          size: 30,
                        ),
                      ),
                      label: "MyMusic",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.favorite_outlined,
                          size: 30,
                        ),
                        label: "Favourite"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.search,
                          size: 30,
                        ),
                        label: "search"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.queue_music_sharp,
                          size: 30,
                        ),
                        label: "playlist"),
                  ]),
            ),
          );
        });
  }
}
