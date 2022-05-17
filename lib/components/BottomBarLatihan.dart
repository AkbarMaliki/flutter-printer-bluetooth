import 'package:harp_flutter/components/main/BottomBarButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar1 extends StatefulWidget {
  @override
  _BottomBar1State createState() => _BottomBar1State();
}

class _BottomBar1State extends State<BottomBar1> {
  final tabs = ['Categories', 'Favorite', 'Help', 'Settings'];
  int selectedPosition = 0;
  @override
  void initState() {
    super.initState();
    var route = Get.arguments != null ? Get.arguments['route'] : 'kosong'.obs;
    if (route == 'home') {
      selectedPosition = 0;
    } else if (route == 'kosong') {
      selectedPosition = 0;
    } else {
      selectedPosition = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.red,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TabItem(
            text: tabs[0],
            icon: Icons.home,
            isSelected: selectedPosition == 0,
            onTap: () {
             
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
              // Get.offAll(FavoritePage(),
              //     transition: Transition.rightToLeft,
              //     arguments: {'route': 'favorite'});
              setState(() {
                selectedPosition = 1;
              });
            },
          ),
          // SizedBox(width: 48,), // jarak antara button tengah yang curve
          // TabItem(text: tabs[2], icon: Icons.help, isSelected: selectedPosition == 2, onTap: () {
          //   setState(() {
          //     selectedPosition = 2;
          //   });
          // },),
          // TabItem(text: tabs[3], icon: Icons.settings, isSelected: selectedPosition == 3, onTap: () {
          //   setState(() {
          //     selectedPosition = 3;
          //   });
          // },),
        ],
      ),
    );
  }
}
