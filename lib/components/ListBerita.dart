// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:get/get.dart';
// import '../plugins/autophp.dart';
// import 'package:html/parser.dart';
// import 'package:url_launcher/url_launcher.dart';

// var sdb = new autophp();

// class ListBerita extends StatefulWidget {
//   @override
//   _ListBeritaState createState() => _ListBeritaState();
// }

// class _ListBeritaState extends State<ListBerita> {
//   Future getData() async {
//     // List res = jsonDecode(await sdb.collection("test").doc('false').get("*","order by id"));
//     List res = jsonDecode(await sdb
//         .collection("artikel")
//         .doc('false')
//         .get("*", "order by ditulis desc limit 10"));
//     return res;
//   }

//   String _parseHtmlString(String htmlString) {
//     final document = parse(htmlString);
//     final String parsedString = parse(document.body.text).documentElement.text;

//     return parsedString;
//   }

//   var refreshs = 0.obs;
//   refreshPage() {
//     refreshs++;
//     print(refreshs);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Container(
//         padding: EdgeInsets.only(left: 10, right: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Divider(
//               height: 3,
//               thickness: 1,
//               color: Colors.grey,
//               indent: Get.width * 0.55,
//               endIndent: 0,
//             ),
//             Text.rich(
//               TextSpan(
//                 text: 'Berita Terbaru', // default text style
//                 children: <TextSpan>[
//                   TextSpan(
//                       text: '$refreshs',
//                       style: TextStyle(
//                           fontSize: 1, color: Colors.white.withOpacity(0.0))),
//                 ],
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             FutureBuilder(
//               future: getData(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     children: [
//                       ...snapshot.data
//                           .map((e) => GestureDetector(
//                                 onTap: () async {
//                                   var _url =
//                                       "https://mediacenter.balangankab.go.id/artikel/detail/" +
//                                           e['slug_berita'];
//                                   await canLaunch(_url)
//                                       ? await launch(_url)
//                                       : throw 'Could not launch $_url';
//                                   print('ok');
//                                 },
//                                 child: Stack(children: [
//                                   Container(
//                                     margin: EdgeInsets.only(bottom: 1),
//                                     child: Card(
//                                       child: Container(
//                                         padding: EdgeInsets.all(10),
//                                         width: Get.width,
//                                         child: Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Flexible(
//                                               flex:
//                                                   2, // ini akan menjadi ukuran dengan widget flex lain
//                                               fit: FlexFit.tight,
//                                               child: Container(
//                                                 height: 70,
//                                                 child: Image.network(
//                                                   'https://mediacenter.balangankab.go.id/upload/artikel/' +
//                                                       e['gambar'],
//                                                   fit: BoxFit.fill,
//                                                   loadingBuilder:
//                                                       (BuildContext context,
//                                                           Widget child,
//                                                           ImageChunkEvent
//                                                               loadingProgress) {
//                                                     if (loadingProgress == null)
//                                                       return child;
//                                                     return Center(
//                                                       child:
//                                                           CircularProgressIndicator(
//                                                         value: loadingProgress
//                                                                     .expectedTotalBytes !=
//                                                                 null
//                                                             ? loadingProgress
//                                                                     .cumulativeBytesLoaded /
//                                                                 loadingProgress
//                                                                     .expectedTotalBytes
//                                                             : null,
//                                                       ),
//                                                     );
//                                                   },
//                                                 ),
//                                               ),
//                                             ),
//                                             Flexible(
//                                               flex:
//                                                   6, // ini akan menjadi ukuran dengan widget flex lain
//                                               fit: FlexFit.tight,
//                                               child: Container(
//                                                   padding:
//                                                       EdgeInsets.only(left: 5),
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Flexible(
//                                                             child: Text(
//                                                               e['judul'],
//                                                               style: TextStyle(
//                                                                   fontSize: 13,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Text.rich(
//                                                             TextSpan(
//                                                               text:
//                                                                   'source : ', // default text style
//                                                               children: <
//                                                                   TextSpan>[
//                                                                 TextSpan(
//                                                                     text:
//                                                                         ' Media Center',
//                                                                     style: TextStyle(
//                                                                         fontStyle:
//                                                                             FontStyle
//                                                                                 .italic,
//                                                                         color: Colors
//                                                                             .grey)),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Flexible(
//                                                               child: Text(
//                                                             _parseHtmlString(e[
//                                                                     'content'])
//                                                                 .substring(
//                                                                     0, 70),
//                                                             style: TextStyle(
//                                                                 fontSize: 12),
//                                                           )),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   )),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 10,
//                                     right: 10,
//                                     child: Icon(
//                                       //https://fonts.google.com/icons?selected=Material+Icons
//                                       Icons.fiber_new,
//                                       color: Colors.red,
//                                       size: 30.0,
//                                     ),
//                                   ),
//                                 ]),
//                               ))
//                           .toList()
//                     ],
//                   );
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(' '),
//                 Text('Selengkapnya ... ',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
