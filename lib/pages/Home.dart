import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:harp_flutter/components/main/BottomBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var refresh = 1.obs;
    return Scaffold(
      // ================ body
      body: SafeArea(
        child: Builder(
          builder: (context) => Stack(children: [
            // Positioned() disini
            Column(
              children: [
                // atau ListView
                Container(
                  // appbar / HEADER
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.greenAccent,
                      Colors.green,
                    ],
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black87,
                            elevation: 5,
                            primary: Colors.grey[300],
                            padding: EdgeInsets.all(5),
                            shape: CircleBorder(),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Image(
                          //width,height
                          image: NetworkImage(
                              'https://upload.egov.balangankab.go.id/files/kopbalangan.png'), // NetworkImage(url), AssetImage()
                          fit: BoxFit.fill, //fill,cover , etc
                        ),
                      ),
                      Text('        '),
                    ],
                  ),
                ),
                // CONTENT=======================================
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                       Obx(
                          () => Text(
                            refresh.toString(),
                            style: TextStyle(fontSize: 0.1),
                          ),
                        ),
                      Text(
                        'INFO HARIAN',
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // CONTENT=======================================
              ],
            ),
            // SCROLL TO REFRESH
            Positioned(
              top: -40,
              left: Get.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // posisi element harus jadi paling atas , stack paling bawah
                children: [
                  Container(
                    width: 150,
                    height: 130,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        refresh++;
                      },
                      child: ListView(children: [
                        Obx(
                          () => Text(
                            refresh.toString(),
                            style: TextStyle(fontSize: 0.1),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            )
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
