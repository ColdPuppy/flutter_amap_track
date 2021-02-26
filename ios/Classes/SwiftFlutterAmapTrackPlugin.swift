import Flutter
import AMapTrackKit

public class SwiftFlutterAmapTrackPlugin: NSObject, FlutterPlugin, AMapTrackManagerDelegate {
    static var channel: FlutterMethodChannel?
  public static func register(with registrar: FlutterPluginRegistrar) {
    SwiftFlutterAmapTrackPlugin.channel = FlutterMethodChannel(name: "flutter_amap_track", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAmapTrackPlugin()
    registrar.addMethodCallDelegate(instance, channel: SwiftFlutterAmapTrackPlugin.channel!)
  }
    
    var trackManager: AMapTrackManager?

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let params = call.arguments as? Dictionary<String,Any>
    switch call.method {
    case "setIOSApiKey":
        let apiKey = params?["apiKey"] as? String
        print("setIOSApiKey")
        if apiKey != nil {
            print("apikey:\(apiKey!)")
            AMapServices.init().apiKey = apiKey!
        }
        break
        
    case "initWithServiceId":
        let sid = params?["sid"] as? Int
        if sid != nil{
            let option = AMapTrackManagerOptions.init()
            option.serviceID = String(sid!)
            print("sid:\(option.serviceID)")
            self.trackManager = AMapTrackManager.init(options: option)
//            if SwiftFlutterAmapTrackPlugin.channel == nil {
//                print("nil")
//            }else {
//                print("not nil")
//            }
            
//            let delegate =  TrackDelegate.init(channel: SwiftFlutterAmapTrackPlugin.channel!)
//            self.trackManager?.delegate = delegate
            self.trackManager?.delegate = self
        }
        break
        
    case "setCacheSize":
        let cacheSize = params?["cacheSize"] as? Int
        if cacheSize != nil {
            self.trackManager?.setLocalCacheMaxSize(cacheSize!)
        }
        break
        
    case "setInterval":
        let gatherInterval = params?["gatherInterval"] as? Int
        let packInterval = params?["packInterval"] as? Int
        if gatherInterval != nil && packInterval != nil {
            self.trackManager?.changeGatherAndPackTimeInterval(gatherInterval!, packTimeInterval: packInterval!)
        }
        break
        
    case "setIOSOption":
        let params = call.arguments as? Dictionary<String,Any>
        let allowsBackgroundLocationUpdates = params?["allowsBackgroundLocationUpdates"] as? Bool
        let pausesLocationUpdatesAutomatically = params?["pausesLocationUpdatesAutomatically"] as? Bool
        if allowsBackgroundLocationUpdates != nil {
            self.trackManager?.allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates!
        }
        
        if pausesLocationUpdatesAutomatically != nil {
            self.trackManager?.pausesLocationUpdatesAutomatically = pausesLocationUpdatesAutomatically!
        }
        
        let activityType = params?["activityType"] as? Int
        
        if activityType != nil {
            switch activityType! {
            case 0:
                self.trackManager?.activityType = CLActivityType.automotiveNavigation
                break
            case 1:
                self.trackManager?.activityType = CLActivityType.fitness
                break
            case 2:
                self.trackManager?.activityType = CLActivityType.otherNavigation
                break
            case 3:
                self.trackManager?.activityType = CLActivityType.other
                break
            default:
                break
            }
            self.trackManager?.activityType = CLActivityType.automotiveNavigation
        }
        break
        
    case "addTerminal":
        let sid = params?["sid"] as? Int
        let terminal = params?["terminal"] as? String
        let terminalDesc = params?["terminalDesc"] as? String
        
        let request = AMapTrackAddTerminalRequest()
        if sid != nil {
            request.serviceID = String(sid!)
        }
        
        if terminal != nil {
            request.terminalName = terminal
            if terminalDesc != nil {
                request.terminalDesc = terminalDesc!
            }
            self.trackManager?.aMapTrackAddTerminal(request)
        }
        break
        
    case "queryTerminal":
        let sid = params?["sid"] as? Int
        let terminal = params?["terminal"] as? String
        let terminalId = params?["terminalId"] as? Int
        
        let request = AMapTrackQueryTerminalRequest()
        if sid != nil {
            request.serviceID = String(sid!)
        }
        
        if terminal != nil {
            request.terminalName = terminal!
        }
        
        if terminalId != nil {
            request.terminalID = String(terminalId!)
        }
        
        self.trackManager?.aMapTrackQueryTerminal(request)
        break
        
    case "addTrack":
        let sid = params?["sid"] as? Int
        let tid = params?["tid"] as? Int
        
        let request = AMapTrackAddTrackRequest()
        if sid != nil {
            request.serviceID = String(sid!)
        }
        
        if tid != nil {
            request.terminalID = String(tid!)
        }
        
        self.trackManager?.aMapTrackAddTrack(request)
        break
        
    case "deleteTrack":
        let tid = params?["tid"] as? Int
        let trid = params?["trid"] as? Int
        
        let request = AMapTrackDeleteTrackRequest()
        if tid != nil && trid != nil {
            request.terminalID = String(tid!)
            request.trackID = String(trid!)
        }
        
        self.trackManager?.aMapTrackDeleteTrack(request)
        break
        
    case "startTrack":
        let tid = params?["tid"] as? Int
        let trackId = params?["trackId"] as? Int
        
        let option = AMapTrackManagerServiceOption()
        if tid != nil {
            option.terminalID = String(tid!)
        }
        
        self.trackManager?.startService(withOptions: option)
        if trackId != nil {
            self.trackManager?.trackID = String(trackId!)
        }
        break
        
    case "stopTrack":
        self.trackManager?.stopService()
        break
        
    case "startGather":
        self.trackManager?.startGatherAndPack()
        break
        
    case "stopGather":
        self.trackManager?.stopGaterAndPack()
        break
        
    case "getTrackId":
        result(self.trackManager?.trackID)
        break
        
    case "setTrackId":
        let trackId = params?["trackId"] as? Int
        
        if trackId != nil {
            self.trackManager?.trackID = String(trackId!)
        }
        break
        
    case "queryLatestPoint":
        let sid = params?["sid"] as? Int
        let tid = params?["tid"] as? Int
        let trid = params?["trid"] as? Int
        let correction = params?["correction"] as? Int
        
        let request = AMapTrackQueryLastPointRequest()
        if sid != nil {
            request.serviceID = String(sid!)
        }
        if tid != nil {
            request.terminalID = String(tid!)
        }
        if trid != nil {
            request.trackID = String(trid!)
        }
        
        var correctionMode = "n"
        if correction != nil && correction == 1 {
            correctionMode = "driving"
        }
        request.correctionMode = correctionMode
        
        self.trackManager?.aMapTrackQueryLastPoint(request)
        break
        
    case "queryDistance":
        let sid = params?["sid"] as? Int
        let tid = params?["tid"] as? Int
        let trid = params?["trid"] as? Int
        let startTime = params?["startTime"] as? Int64
        let endTime = params?["endTime"] as? Int64
        let correction = params?["correction"] as? Int
        let recoup = params?["recoup"] as? Int
        let gap = params?["gap"] as? Int
        
        let request = AMapTrackQueryTrackDistanceRequest()
        if sid != nil {
            request.serviceID = String(sid!)
        }
        if tid != nil && trid != nil && startTime != nil && endTime != nil {
            request.terminalID = String(tid!)
            request.trackID = String(trid!)
            request.startTime = startTime!
            request.endTime = endTime!
            
            var correctionMode = "n"
            if correction != nil && correction == 1 {
                correctionMode = "driving"
            }
            request.correctionMode = correctionMode
            
            if recoup != nil && recoup == 1 {
                request.recoupMode = AMapTrackRecoupMode.driving
            }else{
                request.recoupMode = AMapTrackRecoupMode.none
            }
            
            request.recoupGap = UInt(gap!)
        }
        
        self.trackManager?.aMapTrackQueryTrackDistance(request)
        break
        
    case "queryHistoryTrack":
        let sid = params?["sid"] as? Int
        let tid = params?["tid"] as? Int
        let startTime = params?["startTime"] as? Int64
        let endTime = params?["endTime"] as? Int64
        let correction = params?["correction"] as? Int
        let recoup = params?["recoup"] as? Int
        let gap = params?["gap"] as? Int
        let order = params?["order"] as? Int
        let page = params?["page"] as? Int
        let pageSize = params?["pageSize"] as? Int
        
        let request = AMapTrackQueryTrackHistoryAndDistanceRequest()
        if sid != nil {
            request.serviceID = String(sid!)
        }
        
        if tid != nil {
            request.terminalID = String(tid!)
        }
        
        if startTime != nil && endTime != nil {
            request.startTime = startTime!
            request.endTime = endTime!
        }
        
        var correctionMode = "n"
        if correction != nil && correction == 1 {
            correctionMode = "driving"
        }
        request.correctionMode = correctionMode
        
        if recoup != nil && recoup == 1 {
            request.recoupMode = AMapTrackRecoupMode.driving
        }else{
            request.recoupMode = AMapTrackRecoupMode.none
        }
        
        request.recoupGap = UInt(gap!)
        
        if order != nil {
            request.sortType = Int32(order!)
        }
        
        if page != nil && pageSize != nil {
            request.pageIndex = UInt(page!)
            request.pageSize = UInt(pageSize!)
        }
        
        self.trackManager?.aMapTrackQueryTrackHistoryAndDistance(request)
        break
        
    case "queryTerminalTrack":
        let sid = params?["sid"] as? Int
        let tid = params?["tid"] as? Int
        let startTime = params?["startTime"] as? Int64
        let endTime = params?["endTime"] as? Int64
        let correction = params?["correction"] as? Int
        let recoup = params?["recoup"] as? Int
        let gap = params?["gap"] as? Int
        let ispoint = params?["ispoint"] as? Bool
        let page = params?["page"] as? Int
        let pageSize = params?["pageSize"] as? Int
        
        let request = AMapTrackQueryTrackInfoRequest()
        if sid != nil {
            request.serviceID = String(sid!)
        }
        
        if tid != nil {
            request.terminalID = String(tid!)
        }
        
        if startTime != nil && endTime != nil {
            request.startTime = startTime!
            request.endTime = endTime!
        }
        
        var correctionMode = "n"
        if correction != nil && correction == 1 {
            correctionMode = "driving"
        }
        request.correctionMode = correctionMode
        
        if recoup != nil && recoup == 1 {
            request.recoupMode = AMapTrackRecoupMode.driving
        }else{
            request.recoupMode = AMapTrackRecoupMode.none
        }
        
        request.recoupGap = UInt(gap!)
        
        if ispoint != nil {
            request.containPoints = ispoint!
        }
        
        if page != nil && pageSize != nil {
            request.pageIndex = UInt(page!)
            request.pageSize = UInt(pageSize!)
        }
        
        self.trackManager?.aMapTrackQueryTrackInfo(request)
        break
        
    case "cancelAllRequests":
        self.trackManager?.cancelAllRequests()
        break
        
    default:
        result(FlutterMethodNotImplemented)
    }
  }
    
    // delegate
    
    let trackTag = "OnTrackListener"
    let lifecycleTag = "OnTrackLifecycleListener"
    
    public func amapTrackManager(_ manager: AMapTrackManager, doRequireTemporaryFullAccuracyAuth locationManager: CLLocationManager, completion: @escaping (Error) -> Void) {
        print("amapTrackManager")
        locationManager.requestAlwaysAuthorization()
    }
    
    //    track
    
    public func didFailWithError(_ error: Error, associatedRequest request: Any) {
        var resultData = [String: Any]()
        resultData["errorMsg"] = "didFailWithError -- \(error) || associatedRequest -- \(request)"
        print("didFailWithError -- \(error) || associatedRequest -- \(request)")
        SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onParamErrorCallback#error", arguments: resultData)
    }
    
    public func onAddTerminalDone(_ request: AMapTrackAddTerminalRequest, response: AMapTrackAddTerminalResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            resultData["tid"] = Int(response.terminalID)
            resultData["isServiceNonExist"] = false
            resultData["terminalName"] = response.terminalName
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onCreateTerminalCallback", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onCreateTerminalCallback#error", arguments: resultData)
        }
    }
    
    public func onQueryTerminalDone(_ request: AMapTrackQueryTerminalRequest, response: AMapTrackQueryTerminalResponse) {
        print("onQueryTerminalDone")
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            var list = [[String:Any]]()
            if response.terminals != nil {
                for terminal in response.terminals {
                    var t = [String:Any]()
                    t["tid"] = Int(terminal.tid)
                    t["name"] = terminal.name
                    t["desc"] = terminal.desc
                    t["createTime"] = terminal.createTime
                    t["locateTime"] = terminal.locateTime
                    list.append(t)
                }
            }
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onQueryTerminalCallback", arguments: list)
        }else {
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onQueryTerminalCallback#error", arguments: resultData)
        }
    }
    
    public func onAddTrackDone(_ request: AMapTrackAddTrackRequest, response: AMapTrackAddTrackResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            resultData["trid"] = Int(response.trackID)
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onAddTrackCallback", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onAddTrackCallback#error", arguments: resultData)
        }
    }
    
    public func onDeleteTrackDone(_ request: AMapTrackDeleteTrackRequest, response: AMapTrackBaseResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onDeleteTrackDone", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onDeleteTrackDone#error", arguments: resultData)
        }
    }
    
    public func onQueryLastPointDone(_ request: AMapTrackQueryLastPointRequest, response: AMapTrackQueryLastPointResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            resultData["latestPoint"] = convertPoint(point: response.lastPoint)
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onLatestPointCallback", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onLatestPointCallback#error", arguments: resultData)
        }
    }
    
    public func onQueryTrackDistanceDone(_ request: AMapTrackQueryTrackDistanceRequest, response: AMapTrackQueryTrackDistanceResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            resultData["distance"] = response.distance
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onDistanceCallback", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onLatestPointCallback#error", arguments: resultData)
        }
    }
    
    public func onQueryTrackHistoryAndDistanceDone(_ request: AMapTrackQueryTrackHistoryAndDistanceRequest, response: AMapTrackQueryTrackHistoryAndDistanceResponse) {
        var resultData = [String: Any]()
        if response.code == AMapTrackErrorCode.OK {
            resultData["historyTrack"] = convertHistoryTrack(track: response)
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onHistoryTrackCallback", arguments: resultData)
        }else{
            resultData["errorCode"] = response.code
            resultData["errorMsg"] = response.info
            resultData["errorDetail"] = response.detail
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onHistoryTrackCallback#error", arguments: resultData)
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
                SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onQueryTrackCallback", arguments: resultData)
            }else{
                resultData["errorCode"] = response.code
                resultData["errorMsg"] = response.info
                resultData["errorDetail"] = response.detail
                SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onQueryTrackCallback#error", arguments: resultData)
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
        var resultData = [String: Any]()
        if errorCode == AMapTrackErrorCode.OK {
            resultData["status"] = errorCode
            resultData["message"] = "轨迹同步 启动成功"
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(lifecycleTag + "#onStartTrackCallback", arguments: nil)
        }else {
            resultData["errorCode"] = errorCode.rawValue
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onParamErrorCallback#error", arguments: resultData)
        }
    }
    
    public func onStopService(_ errorCode: AMapTrackErrorCode) {
        var resultData = [String: Any]()
        if errorCode == AMapTrackErrorCode.OK {
            resultData["status"] = errorCode
            resultData["message"] = "轨迹同步 停止成功"
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(lifecycleTag + "#onStopTrackCallback", arguments: nil)
        }else {
            resultData["errorCode"] = errorCode
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onParamErrorCallback#error", arguments: resultData)
        }
    }
    
    public func onStartGatherAndPack(_ errorCode: AMapTrackErrorCode) {
        var resultData = [String: Any]()
        if errorCode == AMapTrackErrorCode.OK {
            resultData["status"] = errorCode
            resultData["message"] = "定位采集 启动成功"
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(lifecycleTag + "#onStartGatherCallback", arguments: nil)
        }else {
            resultData["errorCode"] = errorCode
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onParamErrorCallback#error", arguments: resultData)
        }
    }
    
    public func onStopGatherAndPack(_ errorCode: AMapTrackErrorCode, errorMessage: String?) {
        var resultData = [String: Any]()
        if errorCode == AMapTrackErrorCode.OK {
            resultData["status"] = errorCode
            resultData["message"] = "定位采集 停止成功"
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(lifecycleTag + "#onStopGatherCallback", arguments: nil)
        }else {
            resultData["errorCode"] = errorCode
            resultData["errorMsg"] = errorMessage
            SwiftFlutterAmapTrackPlugin.channel?.invokeMethod(trackTag + "#onParamErrorCallback#error", arguments: resultData)
        }
    }
}
