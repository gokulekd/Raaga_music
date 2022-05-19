import 'package:flutter/material.dart';
import 'package:raaga/Pages/Screen_Splash.dart';
import 'package:raaga/Widgets/my%20music/drawer/PrivacyAndPolicy.dart';
import 'package:raaga/Widgets/my%20music/drawer/TermsAndConditions.dart';
import 'package:raaga/Widgets/my%20music/drawer/about_page.dart';
import 'package:raaga/Widgets/my%20music/drawer/feedBack_Raaga.dart';

class drawer_Raaga extends StatefulWidget {
  const drawer_Raaga({Key? key}) : super(key: key);

  @override
  State<drawer_Raaga> createState() => _drawer_RaagaState();
}

class _drawer_RaagaState extends State<drawer_Raaga> {
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
             
                ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
                name: "Notification",
                IconName: Icons.notifications_active,
            
                iconButtonNeed: true),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              name: "Privacy And Policy",
              IconName: Icons.message,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              name: "Terms And Conditions",
              IconName: Icons.new_releases,
              onClicked: () => selectedItem(context, 4),
            ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              name: "FeedBack",
              IconName: Icons.pending_actions_sharp,
              onClicked: () => selectedItem(context, 5),
            ),
            const SizedBox(
              height: 5,
            ),
            buildMenuItem(
              name: "About",
              IconName: Icons.info,
              onClicked: () => selectedItem(context, 6),
            ),
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext, int index) {
    switch (index) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const feedBack_Raaga(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const feedBack_Raaga(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PrivacyAndPolicy(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const termsAndConditions(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const feedBack_Raaga(),
        ));
        break;

      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const About_Page_Raaga(),
        ));
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
      trailing: Visibility(
        visible: iconButtonNeed!,
        child: Switch(
          value: isSwitched,
          onChanged: toggleSwitch,
          activeColor: const Color.fromARGB(255, 241, 230, 249),
          activeTrackColor: const Color.fromARGB(255, 193, 127, 187),
          inactiveTrackColor: const Color.fromARGB(255, 185, 88, 117),
          inactiveThumbColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
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

  void toggleSwitch(bool value) {
    if (isSwitched == true) {
      setState(() {
        isSwitched = false;
        notificationControll(context);
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  notificationControll(BuildContext context) {
    // set up the buttons
    Widget closeButton = Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color.fromARGB(255, 67, 140, 199),
      ),
      child: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          setState(() {
            isSwitched = true;
            Navigator.pop(context);
          });
        },
      ),
    );
    Widget doneButton = Container(
      margin: const EdgeInsets.only(left: 50),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color.fromARGB(255, 176, 102, 102),
      ),
      child: IconButton(
        icon: const Icon(Icons.done),
        onPressed: () {
          setState(() {
            isSwitched = false;
            Navigator.pop(context);
          });
        },
      ),
    );

    // set up the AlertDialog

    
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text(
          "Would you like to Turn Of music Nofication Bar"),
      actions: [
        closeButton,
        doneButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
