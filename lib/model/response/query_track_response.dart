import 'package:flutter_amap_track/model/track.dart';

/// @author DoggieX
/// @create 2021/2/20 10:59
/// @mail coldpuppy@163.com

class QueryTrackResponse {
  int count;
  List<Track> tracks;

  QueryTrackResponse(this.count, this.tracks);

  factory QueryTrackResponse.parse(Map<String, dynamic> map) =>
      QueryTrackResponse(
          map['count'],
          map['tracks']
              .map<Track>((t) => Track.parse(Map<String, dynamic>.from(t)))
              .toList());
}
