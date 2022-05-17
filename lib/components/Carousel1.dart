import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../plugins/autophp.dart';

var sdb = new autophp();

class Carousel1 extends StatefulWidget {
  @override
  _Carousel1State createState() => _Carousel1State();
}

class _Carousel1State extends State<Carousel1> {
  var _currentIndex = 0;

  var listItem = [
    'https://upload.wikimedia.org/wikipedia/en/5/5f/TomandJerryTitleCardc.jpg',
    'https://blue.kumparan.com/image/upload/c_fill,f_jpg,h_900,q_auto,w_1200/g_south,l_og_media_partner_oxmuq0/co_rgb:ffffff,g_south_west,l_text:Heebo_20_bold:Konten%20Media%20Partner%0DKarja,x_140,y_26/go4c2dvipmmt0b93gdxi.jpg',
    'https://cdn.antaranews.com/cache/800x533/2020/11/19/tom-and-jerry.jpg'
  ].obs; // list item

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Future getData() async {
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.27,
      child: SingleChildScrollView(child:Column(
        children: [
          Obx(
            () => CarouselSlider(
              items: [
                ...listItem
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.all(6.0),
                        child: SingleChildScrollView(child:Column(
                          children: [
                            Image.network(
                              e, fit: BoxFit.cover,
                              // loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                              // if (loadingProgress == null) return child;
                              //   return Center(
                              //     child: CircularProgressIndicator(
                              //     value: loadingProgress.expectedTotalBytes != null ?
                              //           loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                              //           : null,
                              //     ),
                              //   );
                              // },
                            ),
                            Text('Text')
                          ],
                        )
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    )
                    .toList()
              ],
              options: CarouselOptions(
                height: Get.height * 0.26,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
          // INDICATOR CIRCLE
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: map<Widget>(listItem, (index, url) {
          //       return Container(
          //         width: 10.0,
          //         height: 10.0,
          //         margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
          //         ),
          //       );
          //     }),
          //   ),
        ],
      ),
    )
    );
  }
}
