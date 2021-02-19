import 'package:flutter/cupertino.dart';

/// @author DoggieX
/// @create 2021/2/16 15:52
/// @mail coldpuppy@163.com

class LatestPointRequest {
  int sid;
  int tid;
  int trid;
  int correction;
  String accuracy;

  LatestPointRequest(
      {@required this.sid,
      @required this.tid,
      this.trid,
      this.correction,
      this.accuracy});

  Map<String, dynamic> toMap() =>
      {'sid': sid, 'tid': tid, 'correction': correction, 'accuracy': accuracy};
}