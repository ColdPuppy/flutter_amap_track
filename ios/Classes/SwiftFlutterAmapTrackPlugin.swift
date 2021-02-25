import Flutter
import AMapTrackKit

public class SwiftFlutterAmapTrackPlugin: NSObject, FlutterPlugin {
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
        if apiKey != nil {
            AMapServices.init().apiKey = apiKey!
        }
        break
        
    case "setServiceId":
        let sid = params?["sid"] as? Int
        if sid != nil{
            let option = AMapTrackManagerOptions.init()
            option.serviceID = String(sid!)
            self.trackManager = AMapTrackManager.init(options: option)
            
            let delegate =  TrackDelegate.init(channel: SwiftFlutterAmapTrackPlugin.channel!)
            self.trackManager?.delegate = delegate
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
        
        if terminal != nil {
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
}
