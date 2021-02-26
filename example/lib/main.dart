import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_amap_track/flutter_amap_track.dart';
import 'package:flutter_amap_track_example/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS)
    AmapTrack.getInstance().setIOSApiKey('eab5e521bbac37284af152434927a9a3');
  AmapTrack.getInstance().initWithServiceId(25337);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        'home': (_) => HomePage(),
      },
    );
  }
}
