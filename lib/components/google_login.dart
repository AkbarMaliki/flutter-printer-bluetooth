//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harp_flutter/store/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';
// import 'package:intl/intl.dart';
// import 'dart:async';

import '../plugins/autophp.dart';

var sdb = new autophp();

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<UserCredential> signInWithGoogle() async {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print(googleAuth.accessToken);
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    final StoreX storex =
        Get.put(StoreX()); // buat file ./controller/StoreX.dart
    var vdata =
        {}; // new Map.from(vdata); <- apabila mengambil vdata untuk memutus object reference
    return Scaffold(
      appBar: AppBar(
        title: Text('TestPage'),
      ),
      // ================ body
      body: Builder(
          builder: (context) => SafeArea(
                child: Stack(children: [
                  // Positioned() disini
                  ListView(children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black87,
                        elevation: 5,
                        primary: Colors.blue[300],
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                      onPressed: () async {
                        var res = await signInWithGoogle();
                        print(res);
                      },
                      child: Text('login google'),
                    ),
                  ])
                ]),
              )),
      // drawer
      drawer: Drawer(
        // onPressed: () {Scaffold.of(context).openDrawer();}, // body harus pake Builder()
        child: Column(
          children: [
            Text("drawer"),
          ],
        ),
      ),
      // floatingActionButtonLocation:FloatingActionButtonLocation.miniEndDocked,
      // floatingActionButton: Builder(
      //   builder: (context) => FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {},
      //   ),
      // ),
    );
  }
}
