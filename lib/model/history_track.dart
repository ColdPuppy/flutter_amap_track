import 'package:flutter_amap_track/model/point.dart';

/// @author DoggieX
/// @create 2021/2/20 10:55
/// @mail coldpuppy@163.com

class HistoryTrack {
  int count;
  double distance;
  Point startPoint;
  Point endPoint;
  List<Point> points;

  HistoryTrack(
      this.count, this.distance, this.startPoint, this.endPoint, this.points);

  factory HistoryTrack.parse(Map<String, dynamic> map) => HistoryTrack(
      map['count'],
      map['distance'].toDouble(),
      map['startPoint'] != null
          ? Point.parse(Map<String, dynamic>.from(map['startPoint']))
          : null,
      map['endPoint'] != null
          ? Point.parse(Map<String, dynamic>.from(map['endPoint']))
          : null,
      map['points'] != null
          ? map['points']
              .map<Point>((p) =>
                  p != null ? Point.parse(Map<String, dynamic>.from(p)) : null)
              .toList()
          : null);
}
