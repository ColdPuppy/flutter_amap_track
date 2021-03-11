/// @author DoggieX
/// @create 2021/2/19 15:30
/// @mail coldpuppy@163.com

class QueryTerminalResponse {
  int tid;

  /// android only
  bool? isTerminalExist;

  /// ios only
  String? name;
  String? desc;
  int? createTime;
  int? locateTime;

  QueryTerminalResponse(this.tid,
      {this.isTerminalExist,
      this.name,
      this.desc,
      this.createTime,
      this.locateTime});

  factory QueryTerminalResponse.parse(Map<String, dynamic> map) =>
      QueryTerminalResponse(map['tid'],
          isTerminalExist: map['isTerminalExist'],
          name: map['name'],
          desc: map['desc'],
          createTime: map['createTime'],
          locateTime: map['locateTime']);
}
