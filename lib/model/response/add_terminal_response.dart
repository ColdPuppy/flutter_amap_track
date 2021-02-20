import 'package:flutter_amap_track/model/response/error_response.dart';

/// @author DoggieX
/// @create 2021/2/19 15:30
/// @mail coldpuppy@163.com

class AddTerminalResponse {
  int tid;
  bool isServiceNonExist;

  AddTerminalResponse(this.tid, this.isServiceNonExist);

  factory AddTerminalResponse.parse(Map<String, dynamic> map) =>
      AddTerminalResponse(map['tid'], map['isServiceNonExist']);
}
