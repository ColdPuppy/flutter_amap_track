/// @author DoggieX
/// @create 2021/2/20 10:51
/// @mail coldpuppy@163.com

class Point {
  double lat;
  double lng;
  int time;
  double accuracy;
  double direction;
  double height;
  Map<String, String>? props;

  Point(this.lat, this.lng, this.time, this.accuracy, this.direction,
      this.height, this.props);

  factory Point.parse(Map<String, dynamic> map) => Point(
      map['lat'],
      map['lng'],
      map['time'],
      map['accuracy'],
      map['direction'],
      map['height'],
      map['props'] != null ? Map<String, String>.from(map['props']) : null);
}
