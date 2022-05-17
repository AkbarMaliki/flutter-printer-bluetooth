import 'package:flutter/material.dart';
import 'package:harp_flutter/pages/Index.dart';
import 'package:harp_flutter/pages/About.dart';
import 'package:harp_flutter/pages/Print.dart';

Map<String, Widget Function(BuildContext)> routers(){
  return {
    '/':(context)=>IndexPage(),
    '/about':(context)=>AboutPage(),
    '/print':(context)=>PrintPage(),
  };
}