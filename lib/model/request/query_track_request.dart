import 'package:flutter/cupertino.dart';

/// @author DoggieX
/// @create 2021/2/16 16:04
/// @mail coldpuppy@163.com

class QueryTrackRequest {
  int? sid;
  int tid;
  int startTime;
  int endTime;
  int? trid;
  int? recoup;
  int? gap;
  int? ispoint;
  int? page;
  int? pageSize;

  /// android only
  int? denoise;
  int? mapmatch;
  int? threshold;
  int? drivemode;

  /// ios only
  int? correction;

  QueryTrackRequest(
      {this.sid,
      required this.tid,
      required this.startTime,
      required this.endTime,
      this.trid,
      this.denoise,
      this.mapmatch,
      this.threshold,
      this.drivemode,
      this.correction,
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
        'correction': correction,
        'recoup': recoup,
        'gap': gap,
        'ispoint': ispoint,
        'page': page,
        'pageSize': pageSize
      };
}
