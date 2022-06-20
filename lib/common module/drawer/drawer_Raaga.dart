import 'package:flutter/material.dart';
import 'package:raaga/common%20module/drawer/feedBack_Raaga.dart';
import 'package:share_plus/share_plus.dart';
import 'PrivacyAndPolicy.dart';
import 'TermsAndConditions.dart';

class drawer_Raaga extends StatelessWidget {
   drawer_Raaga({Key? key}) : super(key: key);
  @override
 
  final Padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 85, 46, 136),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.asset(
                "assets/Raaga.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
                name: "Share The App",
                IconName: Icons.share,
                onClicked: () async {
                  await Share.share("https://gokulekd.github.io/my-website/");
                }),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              name: "Privacy And Policy",
              IconName: Icons.message,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              name: "Terms And Conditions",
              IconName: Icons.new_releases,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              name: "FeedBack",
              IconName: Icons.pending_actions_sharp,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              name: "About",
              IconName: Icons.info,
              onClicked: () => selectedItem(context, 4),
            ),
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PrivacyAndPolicy(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const termsAndConditions()));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const feedBack_to_Mail(),
        ));
        break;

      case 4:
        showAboutDialog(
            context: context,
            applicationName: "Raaga",
            applicationVersion: "1.0.0",
            applicationIcon: CircleAvatar(
                radius: (52),
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset("assets/app Icon.png"),
                )));
    }
  }

  Widget buildMenuItem({
    required String name,
    required IconData IconName,
    VoidCallback? onClicked,
    bool? iconButtonNeed = false,
  }) {
    final itemcolor = Colors.white;
    return ListTile(
      leading: Icon(
        IconName,
        color: itemcolor,
        size: 28,
      ),
      title: Text(
        name,
        style: TextStyle(color: itemcolor, fontSize: 15),
      ),
      onTap: onClicked,
    );
  }

  bool isSwitched = true;
  var textValue = 'Switch is OFF';


}
