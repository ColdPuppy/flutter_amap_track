import 'package:flutter/cupertino.dart';

/// @author DoggieX
/// @create 2021/2/16 16:12
/// @mail coldpuppy@163.com

class AddTrackRequest {
  int? sid;
  int tid;

  AddTrackRequest({this.sid, required this.tid});

  Map<String, dynamic> toMap() => {'sid': sid, 'tid': tid};
}
