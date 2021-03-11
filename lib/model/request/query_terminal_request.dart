import 'package:flutter/cupertino.dart';

/// @author DoggieX
/// @create 2021/2/9 10:47
/// @mail coldpuppy@163.com

class QueryTerminalRequest {
  int? sid;
  String terminal;

  /// iOS only
  int? terminalId;

  QueryTerminalRequest({this.sid, required this.terminal, this.terminalId});

  Map<String, dynamic> toMap() =>
      {'sid': sid, 'terminal': terminal, 'terminalId': terminalId};
}
