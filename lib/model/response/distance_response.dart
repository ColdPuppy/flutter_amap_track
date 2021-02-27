/// @author DoggieX
/// @create 2021/2/20 10:48
/// @mail coldpuppy@163.com

class DistanceResponse {
  double distance;

  DistanceResponse(this.distance);

  factory DistanceResponse.parse(Map<String, dynamic> map) =>
      DistanceResponse(map['distance'].toDouble());
}
