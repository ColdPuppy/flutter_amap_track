import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_amap_track/flutter_amap_track.dart';
import 'package:flutter_amap_track/model/request/add_terminal_request.dart';
import 'package:flutter_amap_track/model/request/query_terminal_request.dart';
import 'package:flutter_amap_track/model/response/error_response.dart';
import 'package:flutter_amap_track_example/console_panel.dart';

/// @author DoggieX
/// @create 2021/2/19 16:07
/// @mail coldpuppy@163.com

class TerminalPage extends StatefulWidget {
  @override
  _TerminalPageState createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  TextEditingController _controller = new TextEditingController();

  List<String> consoles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('终端管理')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: '终端名称')),
              Container(height: 5),
              ElevatedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '查询终端',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    if (_controller.text.isNotEmpty) {
                      try {
                        var response = await AmapTrack.getInstance()
                            .queryTerminal(QueryTerminalRequest(
                                terminal: _controller.text));
                        if (response.length > 0)
                          consoles.add(
                              'tid:${response[0].tid} | isTerminalExist:${response[0].isTerminalExist}');
                        else
                          consoles.add('no result');

                        setState(() {});
                      } on ErrorResponse catch (e) {
                        setState(() {
                          consoles.add(
                              '${e.errorCode} | ${e.errorMsg} | ${e.errorDetail}');
                        });
                      }
                    }
                  }),
              Container(height: 5),
              ElevatedButton(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '增加终端',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    if (_controller.text.isNotEmpty) {
                      try {
                        var response = await AmapTrack.getInstance()
                            .addTerminal(
                                AddTerminalRequest(terminal: _controller.text));
                        setState(() {
                          consoles.add(
                              'tid:${response.tid} | isServiceNonExist:${response.isServiceNonExist}');
                        });
                      } on ErrorResponse catch (e) {
                        setState(() {
                          consoles.add(
                              '${e.errorCode} | ${e.errorMsg} | ${e.errorDetail}');
                        });
                      }
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
