import 'package:flutter/cupertino.dart';

/// @author DoggieX
/// @create 2021/2/16 15:57
/// @mail coldpuppy@163.com

class HistoryTrackRequest {
  int? sid;
  int tid;
  int startTime;
  int endTime;
  int? correction;
  int? recoup;
  int? gap;
  int? order;
  int? page;
  int? pageSize;
  String? accuracy;

  HistoryTrackRequest(
      {this.sid,
      required this.tid,
      required this.startTime,
      required this.endTime,
      this.correction,
      this.recoup,
      this.gap = 5000,
      this.order,
      this.page,
      this.pageSize,
      this.accuracy});

  Map<String, dynamic> toMap() => {
        'sid': sid,
        'tid': tid,
        'startTime': startTime,
        'endTime': endTime,
        'correction': correction,
        'recoup': recoup,
        'gap': gap,
        'order': order,
        'page': page,
        'pageSize': pageSize,
        'accuracy': accuracy
      };
}
