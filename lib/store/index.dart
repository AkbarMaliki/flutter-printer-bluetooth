import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class StoreX extends GetxController{
  // reactive update
  var reload=0.obs;
  var count=0.obs;
  updateCount(){
    count++;
  }
  var themes={'type':false}.obs;
  var buttonDipilih='1'.obs;
  var list_item={'item':[]}.obs;
  // update saat diperlukan
  // theme
  var index=0;
  updateIndex(){
    index++;
    update();
  }
}