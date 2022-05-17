import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// ALL FCM/FIREBASE CLOUD MESSAGE PACKAGES
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ONE SIGNAL PACKAGES
import 'package:onesignal_flutter/onesignal_flutter.dart';
// GPS/GEOLOCATOR PACKAGES
import 'package:geolocator/geolocator.dart';
// HIVE PACKAGES
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_d;

class InitialApp{

  start()async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,  // ganti menjadi landscape apabila ingin mem force landscape
    ]);
    FCMInit();
    // ONESIGNALInit();
    GPSInit();
    HIVEInit();
  }


  // =============================== HIVE START ===============================
  HIVEInit() async{
    Directory document= await path_d.getApplicationDocumentsDirectory();
    Hive.init(document.path);
  }
  // =============================== HIVE END ===============================


  // =============================== GPS START ===============================
  GPSInit() async{
      // GEOLOCATOR
      gpsPermission(); // dari controller/initgeolocator
  }

  gpsPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high); // getlocation
    //   StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationOptions).listen(
    // (Position position) {
    //     print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    // });
    // return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<Position> currentGpsLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLocationStream() {
    // var homeTabPostionStream;

    // homeTabPostionStream = Geolocator.getPositionStream(
    //   desiredAccuracy: LocationAccuracy.bestForNavigation,
    //   distanceFilter: 4).listen((event) {
    //   });

    // var positionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation,
    //   distanceFilter: 4).listen(
    //   (Position position) {
    //     print(position);
    //     return position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString();
    //   });
  }

  void openGPSSetting() async {
    // await Geolocator.openAppSettings();
    await Geolocator.openLocationSettings();
  }
  // =============================== GPS END ===============================


  // =============================== ONESIGNAL START ===============================
  ONESIGNALInit() async{
    //Remove this method to stop OneSignal Debugging 
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId("272f6d52-d761-4ace-8fb4-f6e1356d8159");
    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
        print("Accepted permission: $accepted");
    });
     
    //  EVENT LISTENER
   OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
            event.complete(event.notification);                                 
    });

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
        // Will be called whenever the permission changes
        // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
        // Will be called whenever the subscription changes 
        // (ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
        // Will be called whenever then user's email subscription changes
        // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
  }
  // =============================== ONESIGNAL END ===============================


  // =========================== FCM START =====================================
  FCMInit() async {
    await Firebase.initializeApp();
    initBackground(); 
    handleFcm();
    _createNotificationChannel("channel_id_1", "test-channel", "description", "notifs"); // notifs adalah nama file mp3 di folder raw
  }
  handleFcm() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    String? token = await messaging.getToken(
      vapidKey:
          "BOyWiIWmXY2AVZ-oe7InZFiYRrJDoIGet3J4ygFUAKXMg-WFi9heoPybaX3Syoa7UryLSGUtqUAj8wAdLM0pBM8", // firebase Web Push certificates
    );
    print(token); // simpan token ke database
    FirebaseMessaging.onMessage.listen((message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}'); // cek notifikasi di foreground
      Get.snackbar('Notifikasi terbaru', 'baru',
          snackPosition: SnackPosition.BOTTOM);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    await FirebaseMessaging.instance.subscribeToTopic('weather'); // topic
  }

  initBackground() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return null;
  // }

} // end of CLASS

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> _createNotificationChannel(
    String id, String name, String description, String sound) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var androidNotificationChannel = AndroidNotificationChannel(
    id,
    name,
    sound: RawResourceAndroidNotificationSound(sound),
    playSound: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);
}
  // =========================== FCM END =====================================
