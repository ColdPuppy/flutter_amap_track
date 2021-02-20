import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_amap_track/flutter_amap_track.dart';
import 'package:flutter_amap_track_example/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AmapTrack.getInstance().setServiceId(25337);
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
