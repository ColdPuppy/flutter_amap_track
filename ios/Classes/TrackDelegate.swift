import Flutter
import AMapLocationKit
import AMapTrackKit

class TrackDelegate: NSObject, AMapTrackManagerDelegate{
    let className = "AMapTrackManagerDelegate"
    var channel: FlutterMethodChannel
    
    init(channel:FlutterMethodChannel) {
        self.channel = channel
    }
    
    func amapTrackManager(_ manager: AMapTrackManager, doRequireTemporaryFullAccuracyAuth locationManager: CLLocationManager, completion: @escaping (Error) -> Void) {
        locationManager.requestAlwaysAuthorization()
    }
    
    func didFailWithError(_ error: Error, associatedRequest request: Any) {
        var resultData = [String: Any]()
        resultData["errorMsg"] = "didFailWithError -- \(error) || associatedRequest -- \(request)"
        self.channel.invokeMethod(className + "#onParamErrorCallback#error", arguments: resultData)
    }
    
    func onAddTerminalDone(_ request: AMapTrackAddTerminalRequest, response: AMapTrackAddTerminalResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            resultData["tid"] = response.terminalID
            resultData["isServiceNonExist"] = false
            self.channel.invokeMethod(className + "#onCreateTerminalCallback", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            self.channel.invokeMethod(className + "#onCreateTerminalCallback#error", arguments: resultData)
        }
    }
}
