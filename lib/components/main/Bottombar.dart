import 'package:harp_flutter/components/main/BottomBarButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar1 extends StatefulWidget {
  @override
  _BottomBar1State createState() => _BottomBar1State();
}

class _BottomBar1State extends State<BottomBar1> {
  final tabs = ['Categories', 'Favorite', 'Event', 'Settings'];
  int selectedPosition = 0;
  @override
  void initState() {
    super.initState();
    var route = Get.arguments != null ? Get.arguments['route'] : 'kosong'.obs;
    print(route);
    if (route == 'home') {
      selectedPosition = 0;
    } else if (route == 'kosong') {
      selectedPosition = 0;
    } else if (route == 'favorite') {
      selectedPosition = 1;
    } else if (route == 'event') {
      selectedPosition = 2;
    } else if (route == 'setting') {
      selectedPosition = 3;
    } else {
      selectedPosition = 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TabItem(
            text: tabs[0],
            icon: Icons.home,
            isSelected: selectedPosition == 0,
            onTap: () {
              // Get.offAll(HomePage(), transition: Transition.fadeIn, arguments: {'route': 'home'});
              setState(() {
                selectedPosition = 0;
              });
            },
          ),
          TabItem(
            text: tabs[1],
            icon: Icons.star,
            isSelected: selectedPosition == 1,
            onTap: () {
              // Get.offAll(FavoritePage(), transition: Transition.fadeIn, arguments: {'route': 'favorite'});
              setState(() {
                selectedPosition = 1;
              });
            },
          ),
          SizedBox(
            width: 48,
          ), // jarak antara button tengah yang curve
          TabItem(
            text: tabs[2],
            icon: Icons.calendar_today_outlined,
            isSelected: selectedPosition == 2,
            onTap: () {
              // Get.offAll(EventPage(), transition: Transition.fadeIn, arguments: {'route': 'event'});
              setState(() {
                selectedPosition = 2;
              });
            },
          ),
          TabItem(
            text: tabs[3],
            icon: Icons.settings,
            isSelected: selectedPosition == 3,
            onTap: () {
              // Get.offAll(SettingPage(), transition: Transition.fadeIn, arguments: {'route': 'setting'});
              setState(() {
                selectedPosition = 3;
              });
            },
          ),
        ],
      ),
    );
  }
}
