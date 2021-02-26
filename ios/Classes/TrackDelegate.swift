import Flutter
import AMapLocationKit
import AMapTrackKit

public class TrackDelegate: NSObject, AMapTrackManagerDelegate{
    let trackTag = "OnTrackListener"
    let lifecycleTag = "OnTrackLifecycleListener"
    var channel: FlutterMethodChannel
    
    init(channel:FlutterMethodChannel) {
        print("TrackDelegate init()")
        self.channel = channel
    }
    
    public func amapTrackManager(_ manager: AMapTrackManager, doRequireTemporaryFullAccuracyAuth locationManager: CLLocationManager, completion: @escaping (Error) -> Void) {
        print("amapTrackManager")
        locationManager.requestAlwaysAuthorization()
    }
    
    //    track
    
    public func didFailWithError(_ error: Error, associatedRequest request: Any) {
        var resultData = [String: Any]()
        resultData["errorMsg"] = "didFailWithError -- \(error) || associatedRequest -- \(request)"
        print("didFailWithError -- \(error) || associatedRequest -- \(request)")
        self.channel.invokeMethod(trackTag + "#onParamErrorCallback#error", arguments: resultData)
    }
    
    public func onAddTerminalDone(_ request: AMapTrackAddTerminalRequest, response: AMapTrackAddTerminalResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            resultData["tid"] = Int(response.terminalID)
            resultData["isServiceNonExist"] = false
            resultData["terminalName"] = response.terminalName
            self.channel.invokeMethod(trackTag + "#onCreateTerminalCallback", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            self.channel.invokeMethod(trackTag + "#onCreateTerminalCallback#error", arguments: resultData)
        }
    }
    
    public func onQueryTerminalDone(_ request: AMapTrackQueryTerminalRequest, response: AMapTrackQueryTerminalResponse) {
        print("onQueryTerminalDone")
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            var list = [[String:Any]]()
            for terminal in response.terminals {
                var t = [String:Any]()
                t["tid"] = Int(terminal.tid)
                t["name"] = terminal.name
                t["desc"] = terminal.desc
                t["createTime"] = terminal.createTime
                t["locateTime"] = terminal.locateTime
                list.append(t)
            }
            self.channel.invokeMethod(trackTag + "#onQueryTerminalCallback", arguments: list)
        }else {
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            self.channel.invokeMethod(trackTag + "#onQueryTerminalCallback#error", arguments: resultData)
        }
    }
    
    public func onAddTrackDone(_ request: AMapTrackAddTrackRequest, response: AMapTrackAddTrackResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            resultData["trid"] = Int(response.trackID)
            self.channel.invokeMethod(trackTag + "#onAddTrackCallback", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            self.channel.invokeMethod(trackTag + "#onAddTrackCallback#error", arguments: resultData)
        }
    }
    
    public func onDeleteTrackDone(_ request: AMapTrackDeleteTrackRequest, response: AMapTrackBaseResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            self.channel.invokeMethod(trackTag + "#onDeleteTrackDone", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            self.channel.invokeMethod(trackTag + "#onDeleteTrackDone#error", arguments: resultData)
        }
    }
    
    public func onQueryLastPointDone(_ request: AMapTrackQueryLastPointRequest, response: AMapTrackQueryLastPointResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            resultData["latestPoint"] = convertPoint(point: response.lastPoint)
            self.channel.invokeMethod(trackTag + "#onLatestPointCallback", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            self.channel.invokeMethod(trackTag + "#onLatestPointCallback#error", arguments: resultData)
        }
    }
    
    public func onQueryTrackDistanceDone(_ request: AMapTrackQueryTrackDistanceRequest, response: AMapTrackQueryTrackDistanceResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            resultData["distance"] = response.distance
            self.channel.invokeMethod(trackTag + "#onDistanceCallback", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            self.channel.invokeMethod(trackTag + "#onLatestPointCallback#error", arguments: resultData)
        }
    }
    
    public func onQueryTrackHistoryAndDistanceDone(_ request: AMapTrackQueryTrackHistoryAndDistanceRequest, response: AMapTrackQueryTrackHistoryAndDistanceResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            resultData["historyTrack"] = convertHistoryTrack(track: response)
            self.channel.invokeMethod(trackTag + "#onHistoryTrackCallback", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            self.channel.invokeMethod(trackTag + "#onHistoryTrackCallback#error", arguments: resultData)
        }
    }
    
    public func onQueryTrackInfoDone(_ request: AMapTrackQueryTrackInfoRequest, response: AMapTrackQueryTrackInfoResponse) {
            var resultData = [String: Any]()
            if response.code == AMapTrackErrorCode.OK {
                resultData["count"] = response.counts
                var trackList = [[String: Any?]]()
                for track in response.tracks {
                    trackList.append(convertTrack(track: track))
                }
                resultData["tracks"] = trackList
                self.channel.invokeMethod(trackTag + "#onQueryTrackCallback", arguments: resultData)
            }else{
                resultData["errorCode"] = response.code
                resultData["errorMsg"] = response.info
                resultData["errorDetail"] = response.detail
                self.channel.invokeMethod(trackTag + "#onQueryTrackCallback#error", arguments: resultData)
            }
    }
    
    func convertTrack(track: AMapTrackBasicTrack) -> [String: Any?] {
        var dict = [String: Any?]()
        dict["count"] = track.counts
        dict["distance"] = track.distance
        dict["trid"] = Int(track.trackID)
        dict["startPoint"] = convertPoint(point: track.startPoint)
        dict["endPoint"] = convertPoint(point: track.endPoint)
        var pList = [[String: Any?]]()
        for p in track.points {
            pList.append(convertPoint(point: p))
        }
        dict["points"] = pList
        dict["lastingTime"] = track.lastingTime
        
        return dict
    }
    
    func convertHistoryTrack(track: AMapTrackQueryTrackHistoryAndDistanceResponse) -> [String:Any?] {
        var dict = [String: Any?]()
        dict["count"] = track.count
        dict["distance"] = track.distance
        dict["startPoint"] = convertPoint(point: track.startPoint)
        dict["endPoint"] = convertPoint(point: track.endPoint)
        var pList = [[String: Any?]]()
        for p in track.points {
            pList.append(convertPoint(point: p))
        }
        dict["points"] = pList
        
        return dict
    }
    
    func convertPoint(point: AMapTrackPoint) -> [String: Any?] {
        var dict = [String: Any?]()
        dict["lat"] = point.coordinate.latitude
        dict["lng"] = point.coordinate.longitude
        dict["time"] = point.locateTime
        dict["accuracy"] = point.accuracy
        dict["direction"] = point.direction
        dict["height"] = point.height
        return dict
    }
    
    // lifecycle
    
    public func onStartService(_ errorCode: AMapTrackErrorCode) {
        if errorCode == AMapTrackErrorCode.OK {
            self.channel.invokeMethod(lifecycleTag + "#onStartTrackCallback", arguments: nil)
        }else {
            var resultData = [String: Any]()
            resultData["errorCode"] = errorCode
            self.channel.invokeMethod(trackTag + "#onParamErrorCallback#error", arguments: resultData)
        }
    }
    
    public func onStopService(_ errorCode: AMapTrackErrorCode) {
        if errorCode == AMapTrackErrorCode.OK {
            self.channel.invokeMethod(lifecycleTag + "#onStopTrackCallback", arguments: nil)
        }else {
            var resultData = [String: Any]()
            resultData["errorCode"] = errorCode
            self.channel.invokeMethod(trackTag + "#onParamErrorCallback#error", arguments: resultData)
        }
    }
    
    public func onStartGatherAndPack(_ errorCode: AMapTrackErrorCode) {
        if errorCode == AMapTrackErrorCode.OK {
            self.channel.invokeMethod(lifecycleTag + "#onStartGatherCallback", arguments: nil)
        }else {
            var resultData = [String: Any]()
            resultData["errorCode"] = errorCode
            self.channel.invokeMethod(trackTag + "#onParamErrorCallback#error", arguments: resultData)
        }
    }
    
    public func onStopGatherAndPack(_ errorCode: AMapTrackErrorCode, errorMessage: String?) {
        if errorCode == AMapTrackErrorCode.OK {
            self.channel.invokeMethod(lifecycleTag + "#onStopGatherCallback", arguments: nil)
        }else {
            var resultData = [String: Any]()
            resultData["errorCode"] = errorCode
            resultData["errorMsg"] = errorMessage
            self.channel.invokeMethod(trackTag + "#onParamErrorCallback#error", arguments: resultData)
        }
    }
}
