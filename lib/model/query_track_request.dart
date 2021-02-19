import 'package:flutter/cupertino.dart';

/// @author DoggieX
/// @create 2021/2/16 16:04
/// @mail coldpuppy@163.com

class QueryTrackRequest {
  int sid;
  int tid;
  int startTime;
  int endTime;
  int trid;
  int denoise;
  int mapmatch;
  int threshold;
  int drivemode;
  int recoup;
  int gap;
  int ispoint;
  int page;
  int pageSize;

  QueryTrackRequest(
      {this.sid,
      @required this.tid,
      @required this.startTime,
      @required this.endTime,
      this.trid,
      this.denoise,
      this.mapmatch,
      this.threshold,
      this.drivemode,
      this.recoup,
      this.gap,
      this.ispoint,
      this.page,
      this.pageSize});

  Map<String, dynamic> toMap() => {
        'sid': sid,
        'tid': tid,
        'startTime': startTime,
        'endTime': endTime,
        'trid': trid,
        'denoise': denoise,
        'mapmatch': mapmatch,
        'threshold': threshold,
        'drivemode': drivemode,
        'recoup': recoup,
        'gap': gap,
        'ispoint': ispoint,
        'page': page,
        'pageSize': pageSize
      };
}
