import 'package:flutter_amap_track/model/history_track.dart';

/// @author DoggieX
/// @create 2021/2/20 10:55
/// @mail coldpuppy@163.com

class HistoryTrackResponse {
  HistoryTrack historyTrack;

  HistoryTrackResponse(this.historyTrack);

  factory HistoryTrackResponse.parse(Map<String, dynamic> map) =>
      HistoryTrackResponse(
          HistoryTrack.parse(Map<String, dynamic>.from(map['historyTrack'])));
}
