/// @author DoggieX
/// @create 2021/2/20 14:45
/// @mail coldpuppy@163.com

class LifecycleResponse {
  int status;
  String message;

  LifecycleResponse(this.status, this.message);

  factory LifecycleResponse.parse(Map<String, dynamic> map) =>
      LifecycleResponse(map['status'], map['message']);
}
