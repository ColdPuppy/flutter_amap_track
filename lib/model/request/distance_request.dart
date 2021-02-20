import 'package:flutter/cupertino.dart';

/// @author DoggieX
/// @create 2021/2/9 19:43
/// @mail coldpuppy@163.com

class DistanceRequest {
  int sid;
  int tid;
  int startTime;
  int endTime;
  int trid;
  int correction;
  int recoup;
  int gap;

  DistanceRequest(
      {this.sid,
      @required this.tid,
      @required this.startTime,
      @required this.endTime,
      @required this.trid,
      this.correction,
      this.recoup,
      this.gap});

  Map<String, dynamic> toMap() => {
        'sid': sid,
        'tid': tid,
        'startTime': startTime,
        'endTime': endTime,
        'trid': trid,
        'correction': correction,
        'recoup': recoup,
        'gap': gap
      };
}
