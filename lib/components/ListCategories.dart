import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:harp_flutter/pages/infoharian/Index.dart';
// import '../pages/kategori/ListKategori.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListCategories extends StatefulWidget {
  @override
  _ListCategoriesState createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  List menus = [
    {
      'nama': 'Kuliner',
      'link': 'kuliner',
      'icon': 'https://officialapp.website/icon/restaurant-svgrepo-com.svg'
    },
    {
      'nama': 'Pariwisata',
      'link': 'pariwisata',
      'icon': 'https://officialapp.website/icon/mountain-svgrepo-com.svg'
    },
    {
      'nama': 'Hotel',
      'link': 'hotel',
      'icon':
          'https://officialapp.website/icon/hotel-signal-hotel-svgrepo-com.svg'
    },
    {
      'nama': 'Belanja',
      'link': 'belanja',
      'icon': 'https://officialapp.website/icon/shopping-bag-svgrepo-com.svg'
    },
    {
      'nama': 'UMKM',
      'link': 'umkm',
      'icon': 'https://officialapp.website/icon/tools-pen-svgrepo-com.svg'
    },
    {
      'nama': 'Fasilitas umum',
      'link': 'fasilias umum',
      'icon': 'https://officialapp.website/icon/bus-stop-svgrepo-com.svg'
    },
    {
      'nama': 'Kesehatan',
      'link': 'kesehatan',
      'icon':
          'https://officialapp.website/icon/health-care-accident-svgrepo-com.svg'
    },
    {
      'nama': 'Info Harian',
      'link': 'harian',
      'icon': 'https://officialapp.website/icon/news-svgrepo-com.svg'
    },
    {
      'nama': 'Pendidikan',
      'link': 'pendidikan',
      'icon': 'https://officialapp.website/icon/book-svgrepo-com.svg'
    },
    {
      'nama': 'Pemerintahan',
      'link': 'kantor pemerintahan',
      'icon': 'https://officialapp.website/icon/post-office-svgrepo-com.svg'
    },
    {
      'nama': 'Layanan Publik',
      'link': 'publik',
      'icon':
          'https://officialapp.website/icon/customer-service-svgrepo-com.svg'
    },
    {
      'nama': 'Transportasi',
      'link': 'transportasi',
      'icon': 'https://officialapp.website/icon/bus-svgrepo-com.svg'
    },
    // { 'nama':'Event/Acara', 'link':'acara', 'icon':'https://officialapp.website/icon/seventeen-svgrepo-com.svg' },
  ].obs;
  var refresh = 1.obs;
  @override
  Widget build(BuildContext context) {
    print('refresh kategoris');
    return Container(
      height: Get.height - Get.height * 0.48,
      child: RefreshIndicator(
        onRefresh: () async {
          refresh++;
        },
        child: GridView.count(
          primary: false,
          childAspectRatio: 3 / 2, //lebar dan tinggi children
          crossAxisCount: 3, // jumlah item per row
          padding: const EdgeInsets.all(5),
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          children: [
            ...menus
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      print('link nya');
                      print(e['link']);
                      if (e['link'] == 'harian') {
                        // Get.to(InfoHarianIndex(),transition: Transition.cupertino);
                      } else {
                        // Get.to(ListKategori(),
                        //     arguments: {'link': e['link']},
                        //     transition: Transition.fadeIn);
                      }
                    },
                    child: Column(
                      children: [
                        Center(
                            child: Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.network(
                              e['icon'],
                              height: 35,
                              semanticsLabel: 'Feed button',
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                      child: const CircularProgressIndicator()),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )),
                        Flexible(
                            child: Text(e['nama'],
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey))),
                      ],
                    ),
                  ),
                )
                .toList(),
            // item
          ],
        ),
      ),
    );
  }
}
