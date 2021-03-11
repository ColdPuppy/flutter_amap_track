import 'package:flutter/cupertino.dart';

/// @author DoggieX
/// @create 2021/2/16 16:12
/// @mail coldpuppy@163.com

class DeleteTrackRequest {
  int tid;
  int trid;

  DeleteTrackRequest({required this.tid, required this.trid});

  Map<String, dynamic> toMap() => {'tid': tid, 'trid': trid};
}
