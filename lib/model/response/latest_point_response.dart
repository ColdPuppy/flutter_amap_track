import 'package:flutter_amap_track/model/point.dart';

/// @author DoggieX
/// @create 2021/2/20 10:49
/// @mail coldpuppy@163.com

class LatestPointResponse {
  Point latestPoint;

  LatestPointResponse(this.latestPoint);

  // factory LatestPointResponse.parse(Map<String, dynamic> map) =>
  //     LatestPointResponse(
  //         Point.parse(Map<String, dynamic>.from(map['latestPoint'])));

  factory LatestPointResponse.parse(Map<String, dynamic> map) {
    var map2 = map['latestPoint'];
    var map3 = Map<String, dynamic>.from(map2);
    var point = Point.parse(map3);
    return LatestPointResponse(point);
  }
}
