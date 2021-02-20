/// @author DoggieX
/// @create 2021/2/20 11:04
/// @mail coldpuppy@163.com

class AddTrackResponse {
  int trid;

  AddTrackResponse(this.trid);

  factory AddTrackResponse.parse(Map<String, dynamic> map) =>
      AddTrackResponse(map['trid']);
}
