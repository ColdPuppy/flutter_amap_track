import 'package:flutter/material.dart';
import 'package:flutter_amap_track/flutter_amap_track.dart';
import 'package:flutter_amap_track/model/request/add_track_request.dart';
import 'package:flutter_amap_track/model/request/track_param.dart';

import 'console_panel.dart';

/// @author DoggieX
/// @create 2021/2/20 14:36
/// @mail coldpuppy@163.com

class TrackPage extends StatefulWidget {
  @override
  _TrackPageState createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  List<String> consoles = [];
  int trid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('轨迹上报')),
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
                      '开启轨迹服务（散点）',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    var response = await AmapTrack.getInstance()
                        .startTrack(TrackParam(tid: 323198284));
                    setState(() {
                      consoles.add(
                          'startTrack: status${response.status} | message:${response.message}');
                    });
                  }),
              Container(height: 5),
              RaisedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '开启定位采集',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    var response = await AmapTrack.getInstance().startGather();
                    setState(() {
                      consoles.add(
                          'startGather: status${response.status} | message:${response.message}');
                    });
                  }),
              Container(height: 5),
              RaisedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '结束定位采集',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    var response = await AmapTrack.getInstance().stopGather();
                    setState(() {
                      consoles.add(
                          'stopGather: status${response.status} | message:${response.message}');
                    });
                  }),
              Container(height: 5),
              RaisedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '结束轨迹服务（散点）',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    var response = await AmapTrack.getInstance()
                        .stopTrack(TrackParam(tid: 323198284));
                    setState(() {
                      consoles.add(
                          'stopTrack: status${response.status} | message:${response.message}');
                    });
                  }),
              Container(height: 5),
              RaisedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '创建轨迹',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    var response = await AmapTrack.getInstance()
                        .addTrack(AddTrackRequest(tid: 323198284));
                    trid = response.trid;
                    setState(() {
                      consoles.add('addTrack: trid${response.trid}');
                    });
                  }),
              Container(height: 5),
              RaisedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '开启轨迹服务（指定轨迹）',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    if (null == trid) {
                      setState(() {
                        consoles.add('请先创建轨迹');
                      });
                      return;
                    }
                    var response = await AmapTrack.getInstance()
                        .startTrack(TrackParam(tid: 323198284, trackId: trid));
                    setState(() {
                      consoles.add(
                          'startTrack: trackId:$trid | status${response.status} | message:${response.message}');
                    });
                  }),
              Container(height: 5),
              RaisedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '结束轨迹服务（指定轨迹）',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    if (null == trid) {
                      setState(() {
                        consoles.add('请先创建轨迹');
                      });
                      return;
                    }
                    var response = await AmapTrack.getInstance()
                        .stopTrack(TrackParam(tid: 323198284, trackId: trid));
                    setState(() {
                      consoles.add(
                          'stopTrack: trackId:$trid | status${response.status} | message:${response.message}');
                    });
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
