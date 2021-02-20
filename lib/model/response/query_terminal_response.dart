import 'package:flutter_amap_track/model/response/error_response.dart';

/// @author DoggieX
/// @create 2021/2/19 15:30
/// @mail coldpuppy@163.com

class QueryTerminalResponse {
  int tid;
  bool isTerminalExist;

  QueryTerminalResponse(this.tid, this.isTerminalExist);

  factory QueryTerminalResponse.parse(Map<String, dynamic> map) =>
      QueryTerminalResponse(map['tid'], map['isTerminalExist']);
}
