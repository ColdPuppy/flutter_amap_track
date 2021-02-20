import 'package:flutter/material.dart';
import 'package:flutter_amap_track_example/query_page.dart';
import 'package:flutter_amap_track_example/terminal_page.dart';
import 'package:flutter_amap_track_example/track_page.dart';

/// @author DoggieX
/// @create 2021/2/19 15:52
/// @mail coldpuppy@163.com

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AMap Track Demo'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '终端管理',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => TerminalPage()))),
              Container(height: 10),
              ElevatedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '轨迹上报',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => TrackPage()))),
              Container(height: 10),
              ElevatedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '轨迹查询',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => QueryPage())))
            ],
          ),
        ),
      ),
    );
  }
}
