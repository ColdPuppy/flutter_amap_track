import 'package:flutter/cupertino.dart';

/// @author DoggieX
/// @create 2021/2/9 10:47
/// @mail coldpuppy@163.com

class AddTerminalRequest {
  int sid;
  String terminal;

  /// iOS only
  String terminalDesc;

  AddTerminalRequest({this.sid, @required this.terminal, this.terminalDesc});

  Map<String, dynamic> toMap() =>
      {'sid': sid, 'terminal': terminal, 'terminalDesc': terminalDesc};
}
