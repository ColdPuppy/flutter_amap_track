/// @author DoggieX
/// @create 2021/2/9 10:47
/// @mail coldpuppy@163.com

class QueryTerminalRequest {
  int sid;
  String terminal;

  QueryTerminalRequest(this.sid, this.terminal);

  Map<String, dynamic> toMap() => {'sid': sid, 'terminal': terminal};
}
