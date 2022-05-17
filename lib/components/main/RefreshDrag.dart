import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harp_flutter/store/index.dart';

class RefreshDrag extends StatelessWidget {
  final StoreX storex = Get.put(StoreX());
  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                storex.reload++;
              },
              child: ListView(children: [
                Obx(
                  () => Text(
                    storex.reload.toString(),
                    style: TextStyle(fontSize: 0.1),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
