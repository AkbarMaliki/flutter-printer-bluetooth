import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Main Components
import 'package:harp_flutter/components/main/AppHeader.dart';
import 'package:harp_flutter/components/main/RefreshDrag.dart';
import 'package:harp_flutter/components/main/BottomBar.dart';
import 'package:harp_flutter/store/index.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StoreX storex = Get.put(StoreX()); 
    var vdata ={}; // new Map.from(vdata); <- apabila mengambil vdata untuk memutus object reference
    return Scaffold(
      // ================ body
      body: SafeArea(
        child: Builder(
          builder: (context) => Stack(children: [
            // Positioned() disini
            Column(
              children: [
                // atau ListView
                AppHeader(),
                // CONTENT=======================================
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                       Obx(
                          () => Text(
                            storex.reload.toString(),
                            style: TextStyle(fontSize: 0.1),
                          ),
                        ),
                      Text(
                        'CONTENT broh',
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // CONTENT=======================================
              ],
            ),
            RefreshDrag(), // SCROLL TO REFRESH
          ]),
        ),
      ),
      // drawer
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(TerdekatPage());
        },
        backgroundColor: Colors.blue.withOpacity(0.5),
        child: Icon(Icons.pin_drop),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar1(), // import dari Components BottomBar
    );
  }
}
