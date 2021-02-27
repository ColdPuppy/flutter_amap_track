import 'package:flutter_amap_track/model/point.dart';

/// @author DoggieX
/// @create 2021/2/20 10:59
/// @mail coldpuppy@163.com

class Track {
  int count;
  double distance;
  int trid;
  Point startPoint;
  Point endPoint;
  List<Point> points;

  /// iOS only
  int lastingTime;

  Track(this.count, this.distance, this.trid, this.startPoint, this.endPoint,
      this.points,
      {this.lastingTime});

  factory Track.parse(Map<String, dynamic> map) => Track(
      map['count'],
      map['distance'].toDouble(),
      map['trid'],
      map['startPoint'] != null
          ? Point.parse(Map<String, dynamic>.from(map['startPoint']))
          : null,
      map['endPoint'] != null
          ? Point.parse(Map<String, dynamic>.from(map['endPoint']))
          : null,
      map['points']
          .map<Point>((p) =>
              p != null ? Point.parse(Map<String, dynamic>.from(p)) : null)
          .toList(),
      lastingTime: map['lastingTime']);
}
