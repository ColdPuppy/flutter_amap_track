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

  Track(this.count, this.distance, this.trid, this.startPoint, this.endPoint,
      this.points);

  factory Track.parse(Map<String, dynamic> map) => Track(
      map['count'],
      map['distance'],
      map['trid'],
      Point.parse(Map<String, dynamic>.from(map['startPoint'])),
      Point.parse(Map<String, dynamic>.from(map['endPoint'])),
      map['points']
          .map<Point>((p) => Point.parse(Map<String, dynamic>.from(p)))
          .toList());
}
