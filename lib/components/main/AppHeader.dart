import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // appbar / HEADER
      width: double.infinity,
      height: Get.height * 0.08,
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
    );
    ;
  }
}
