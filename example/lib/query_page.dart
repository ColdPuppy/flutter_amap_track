import 'package:flutter/material.dart';
import 'package:flutter_amap_track/flutter_amap_track.dart';
import 'package:flutter_amap_track/model/enum/correct_mode.dart';
import 'package:flutter_amap_track/model/enum/order_mode.dart';
import 'package:flutter_amap_track/model/enum/recoup_mode.dart';
import 'package:flutter_amap_track/model/request/distance_request.dart';
import 'package:flutter_amap_track/model/request/history_track_request.dart';
import 'package:flutter_amap_track/model/request/latest_point_request.dart';
import 'package:flutter_amap_track/model/request/query_track_request.dart';
import 'package:flutter_amap_track/model/response/error_response.dart';

import 'console_panel.dart';

/// @author DoggieX
/// @create 2021/2/20 17:58
/// @mail coldpuppy@163.com

class QueryPage extends StatefulWidget {
  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  List<String> consoles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('轨迹查询')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RaisedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '查询终端实时位置',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    var latestPoint = await AmapTrack.getInstance()
                        .queryLatestPoint(LatestPointRequest(tid: 323198284));
                    setState(() {
                      consoles.add(
                          'queryLatestPoint: lat:${latestPoint.latestPoint.lat} | lng:${latestPoint.latestPoint.lng} | time:${latestPoint.latestPoint.time}');
                    });
                  }),
              Container(height: 5),
              RaisedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '查询终端行驶里程',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    var distanceResponse = await AmapTrack.getInstance()
                        .queryDistance(DistanceRequest(
                            tid: 323198284,
                            startTime: 1613830564217,
                            endTime: 1613830574217,
                            trid: 29520));
                    setState(() {
                      consoles.add(
                          'queryDistance: distance:${distanceResponse.distance}');
                    });
                  }),
              Container(height: 5),
              RaisedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '查询终端所有轨迹点',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      var historyTrackResponse = await AmapTrack.getInstance()
                          .queryHistoryTrack(HistoryTrackRequest(
                              tid: 323198284,
                              startTime: 1613830564217,
                              endTime: 1613830574217,
                              correction: CorrectMode.DRIVING,
                              recoup: RecoupMode.DRIVING,
                              gap: 1000,
                              order: OrderMode.OLD_FIRST,
                              page: 1,
                              pageSize: 100));
                      setState(() {
                        consoles.add(
                            'queryDistance: distance:${historyTrackResponse.historyTrack.distance} | count:${historyTrackResponse.historyTrack.count}');
                      });
                    } on ErrorResponse catch (e) {
                      setState(() {
                        consoles.add(
                            '${e.errorCode} | ${e.errorMsg} | ${e.errorDetail}');
                      });
                    }
                  }),
              Container(height: 5),
              RaisedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '查询终端某个轨迹的轨迹点',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      var queryTrackResponse = await AmapTrack.getInstance()
                          .queryTerminalTrack(QueryTrackRequest(
                              tid: 323198284,
                              startTime: 1613830564217,
                              endTime: 1613830574217,
                              trid: 29520));
                      setState(() {
                        consoles.add(
                            'queryDistance: count:${queryTrackResponse.count} | tracks:${queryTrackResponse.tracks.length}');
                      });
                    } on ErrorResponse catch (e) {
                      setState(() {
                        consoles.add(
                            '${e.errorCode} | ${e.errorMsg} | ${e.errorDetail}');
                      });
                    }
                  }),
              Container(height: 10),
              ConsolePanel(consoles)
            ],
          ),
        ),
      ),
    );
  }
}
