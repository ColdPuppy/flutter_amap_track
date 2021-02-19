/// @author DoggieX
/// @create 2021/2/9 9:23
/// @mail coldpuppy@163.com

class TrackParam {
  int sid;
  int tid;
  int trackId;

  bool isServiceValid() => sid > 0;

  bool isTerminalValid() => tid > 0;

  Map<String, int> toMap() => {'sid': sid, 'tid': tid, 'trackId': trackId};
}
