/// @author DoggieX
/// @create 2021/2/19 22:18
/// @mail coldpuppy@163.com

class ErrorResponse {
  int errorCode;
  String errorMsg;
  String errorDetail;

  ErrorResponse(this.errorCode, this.errorMsg, this.errorDetail);

  factory ErrorResponse.parse(Map<String, dynamic> map) =>
      ErrorResponse(map['errorCode'], map['errorMsg'], map['errorDetail']);
}
