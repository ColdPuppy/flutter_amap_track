part of flutter_amap_track;

/// @author DoggieX
/// @create 2021/2/7 10:07
/// @mail coldpuppy@163.com

class AmapTrack {
  MethodChannel _methodChannel;

  static final _instance = AmapTrack._();

  factory AmapTrack.getInstance() => _instance;

  AmapTrack._() {
    _methodChannel = MethodChannel('flutter_amap_track');
    _methodChannel.setMethodCallHandler((call) async {
      var split = call.method.split('#');
      if (split.length > 1) {
        if ('OnTrackListener' == split[0]) {
          switch (split[1]) {
            case 'onQueryTerminalCallback':
              if (split.length == 2) {
                var queryTerminalResponse = QueryTerminalResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _queryTerminalCompleter?.complete(queryTerminalResponse);
              } else {
                var errorResponse = ErrorResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _queryTerminalCompleter?.completeError(errorResponse);
              }
              break;
            case 'onCreateTerminalCallback':
              if (split.length == 2) {
                var addTerminalResponse = AddTerminalResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _addTerminalCompleter?.complete(addTerminalResponse);
              } else {
                var errorResponse = ErrorResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _addTerminalCompleter?.completeError(errorResponse);
              }
              break;
            case 'onDistanceCallback':
              if (split.length == 2) {
                var distanceResponse = DistanceResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _distanceCompleter?.complete(distanceResponse);
              } else {
                var errorResponse = ErrorResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _distanceCompleter?.completeError(errorResponse);
              }
              break;
            case 'onLatestPointCallback':
              if (split.length == 2) {
                try {
                  var latestPointResponse = LatestPointResponse.parse(
                      Map<String, dynamic>.from(call.arguments));
                  _latestPointCompleter?.complete(latestPointResponse);
                } catch (e) {
                  print(e);
                }
              } else {
                var errorResponse = ErrorResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _latestPointCompleter?.completeError(errorResponse);
              }
              break;
            case 'onHistoryTrackCallback':
              if (split.length == 2) {
                var historyTrackResponse = HistoryTrackResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _historyTrackCompleter?.complete(historyTrackResponse);
              } else {
                var errorResponse = ErrorResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _historyTrackCompleter?.completeError(errorResponse);
              }
              break;
            case 'onQueryTrackCallback':
              if (split.length == 2) {
                var queryTrackResponse = QueryTrackResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _queryTrackCompleter?.complete(queryTrackResponse);
              } else {
                var errorResponse = ErrorResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _queryTrackCompleter?.completeError(errorResponse);
              }
              break;
            case 'onAddTrackCallback':
              if (split.length == 2) {
                var addTrackResponse = AddTrackResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _addTrackCompleter?.complete(addTrackResponse);
              } else {
                var errorResponse = ErrorResponse.parse(
                    Map<String, dynamic>.from(call.arguments));
                _addTrackCompleter?.completeError(errorResponse);
              }
              break;
            case 'onParamErrorCallback':
              var errorResponse = ErrorResponse.parse(
                  Map<String, dynamic>.from(call.arguments));
              if (null != _queryTrackCompleter &&
                  !_queryTerminalCompleter.isCompleted)
                _queryTerminalCompleter.completeError(errorResponse);
              if (null != _addTerminalCompleter &&
                  !_addTerminalCompleter.isCompleted)
                _addTerminalCompleter.completeError(errorResponse);
              if (null != _distanceCompleter && !_distanceCompleter.isCompleted)
                _distanceCompleter.completeError(errorResponse);
              if (null != _latestPointCompleter &&
                  !_latestPointCompleter.isCompleted)
                _latestPointCompleter.completeError(errorResponse);
              if (null != _historyTrackCompleter &&
                  !_historyTrackCompleter.isCompleted)
                _historyTrackCompleter.completeError(errorResponse);
              if (null != _queryTrackCompleter &&
                  !_queryTrackCompleter.isCompleted)
                _queryTrackCompleter.completeError(errorResponse);
              if (null != _addTrackCompleter && !_addTrackCompleter.isCompleted)
                _addTrackCompleter.completeError(errorResponse);
              break;
            default:
              break;
          }
        } else if ('OnTrackLifecycleListener' == split[0]) {
          var lifecycleResponse = LifecycleResponse.parse(
              Map<String, dynamic>.from(call.arguments));
          switch (split[1]) {
            case 'onBindServiceCallback':
              print(
                  'onBindService: ${lifecycleResponse.status} | ${lifecycleResponse.message}');
              break;
            case 'onStartGatherCallback':
              _startGatherCompleter?.complete(lifecycleResponse);
              break;
            case 'onStartTrackCallback':
              _startTrackCompleter?.complete(lifecycleResponse);
              break;
            case 'onStopTrackCallback':
              _stopTrackCompleter?.complete(lifecycleResponse);
              break;
            case 'onStopGatherCallback':
              _stopGatherCompleter?.complete(lifecycleResponse);
              break;
          }
        }
      }
    });
  }

  int sid;

  Future setServiceId(int serviceId) async {
    assert(null != serviceId && serviceId > 0);
    sid = serviceId;
  }

  /// 监听回调
  // Future addCallback(TrackCallBack callBack) async {
  //   _methodChannel.setMethodCallHandler((call) async {
  //     var split = call.method.split('#');
  //     if (split.length > 1)
  //       switch (split[0]) {
  //         case 'onQueryTerminalCallback':
  //           _queryTerminalCompleter.complete(call.arguments);
  //           break;
  //       }
  //   });
  // }

  /// 获得版本号
  Future<String> getVersion() async {
    return await _methodChannel.invokeMethod('getVersion');
  }

  /// 设置缓存大小, 单位MB。默认为50MB 该接口既可以在开启轨迹服务前调用，也可以在开启轨迹服务后调用
  /// cacheSize - 缓存大小，单位为MB
  Future setCacheSize(int cacheSize) async {
    assert(null != cacheSize && cacheSize > 0);
    await _methodChannel.invokeMethod('setCacheSize', {'cacheSize': cacheSize});
  }

  /// 设置采集和打包位置数据的时间间隔 该接口既可以在开启轨迹服务前调用，也可以在开启轨迹服务后调用
  /// gatherInterval - 采集时间间隔 , 单位为s, 范围为1s~60s , 在定位周期大于15s时，SDK会将定位周期设置为5的倍数
  /// packInterval - 打包时间间隔 , 单位为s, 范围为采集时间*5~采集时间*50，为采集时间的整数倍
  Future setInterval(
      {@required int gatherInterval, @required int packInterval}) async {
    assert(null != gatherInterval &&
        gatherInterval > 0 &&
        null != packInterval &&
        packInterval > 0);
    return await _methodChannel.invokeMethod('setInterval',
        {'gatherInterval': gatherInterval, 'packInterval': packInterval});
  }

  /// 设置定位模式。默认为高精度定位模式 高精度定位模式
  Future setLocationMode(int locationMode) async {
    assert(locationMode < 4 && locationMode > 0);
    await _methodChannel
        .invokeMethod('setLocationMode', {'locationMode': locationMode});
  }

  /// 自定义属性
  Future addOnCustomAttributeListener() async {
    // todo
    await _methodChannel.invokeMethod('addOnCustomAttributeListener');
  }

  /// 设置轨迹服务监听器 该接口必须在开启轨迹服务后调用才会生效
  Future addOnTrackListener() async {
    await _methodChannel.invokeMethod('addOnTrackListener');
  }

  /// 设置轨迹服务监听器 该接口必须在开启轨迹服务后调用才会生效
  Future setProtocolType(int protocolType) async {
    assert(0 == protocolType || 1 == protocolType);
    await _methodChannel
        .invokeMethod('setProtocolType', {'protocolType': protocolType});
  }

  Completer<LifecycleResponse> _startGatherCompleter;

  /// 开启轨迹采集
  Future<LifecycleResponse> startGather() async {
    _startGatherCompleter = Completer();
    _methodChannel.invokeMethod('startGather');
    addOnTrackListener();
    return _startGatherCompleter.future;
  }

  Completer<LifecycleResponse> _startTrackCompleter;

  /// 开启轨迹服务 在开启轨迹服务前，需要初始化Track，并在AndroidManifest.xml文件中配置API_KEY(AK)
  Future<LifecycleResponse> startTrack(TrackParam param) async {
    assert(null != param);
    if (null == param.sid) param.sid = sid;
    assert(param.isTerminalValid() && param.isServiceValid());
    _startTrackCompleter = Completer();
    _methodChannel.invokeMethod('startTrack', {'param': param.toMap()});
    addOnTrackListener();
    return _startTrackCompleter.future;
  }

  /// 设置轨迹id。如果要上报散点，则将trackId置为-1 该方法只有在已经启动轨迹服务后才会生效
  Future setTrackId(int trackId) async {
    assert(trackId > 0 || -1 == trackId);
    await _methodChannel.invokeMethod('setTrackId', {'trackId': trackId});
  }

  /// 获得当前设置的轨迹id 该方法只有在已经启动轨迹服务后才会生效
  Future<int> getTrackId() async {
    return await _methodChannel.invokeMethod('getTrackId');
  }

  Completer<LifecycleResponse> _stopGatherCompleter;

  /// 停止轨迹采集
  Future<LifecycleResponse> stopGather() async {
    _stopGatherCompleter = Completer();
    _methodChannel.invokeMethod('stopGather');
    addOnTrackListener();
    return _stopGatherCompleter.future;
  }

  Completer<LifecycleResponse> _stopTrackCompleter;

  /// 停止轨迹服务
  /// TrackParam - 和开启时传入的track参数一致
  Future<LifecycleResponse> stopTrack(TrackParam param) async {
    assert(null != param);
    if (null == param.sid) param.sid = sid;
    assert(param.isTerminalValid() && param.isServiceValid());
    _stopTrackCompleter = Completer();
    _methodChannel.invokeMethod('stopTrack', {'param': param.toMap()});
    addOnTrackListener();
    return _stopTrackCompleter.future;
  }

  Completer<QueryTerminalResponse> _queryTerminalCompleter;

  /// 查询terminal
  Future<QueryTerminalResponse> queryTerminal(
      QueryTerminalRequest request) async {
    assert(null != request);
    if (null == request.sid) request.sid = sid;
    _queryTerminalCompleter = Completer();
    _methodChannel.invokeMethod('queryTerminal', {'request': request.toMap()});
    return _queryTerminalCompleter.future;
  }

  Completer<AddTerminalResponse> _addTerminalCompleter;

  /// 创建terminal
  Future<AddTerminalResponse> addTerminal(AddTerminalRequest request) async {
    assert(null != request);
    if (null == request.sid) request.sid = sid;
    _addTerminalCompleter = Completer();
    _methodChannel.invokeMethod('addTerminal', {'request': request.toMap()});
    return _addTerminalCompleter.future;
  }

  Completer<DistanceResponse> _distanceCompleter;

  /// 查询里程
  /// sid - 服务id
  /// tid - 终端id
  /// startTime - 开始时间，unix时间戳，精确到毫秒
  /// endTime - 结束时间，unix时间戳，精确到毫秒，注意，结束时间不能大于当前时间，且距离开始时间不能超过24小时
  /// trid - 轨迹id
  /// correction - 是否纠偏，可取值参考[CorrectMode]
  /// recoup - 是否进行距离补偿，可取值参考[RecoupMode]
  /// gap - 距离补偿生效的点间距，单位为米，范围必须在50m~10km，当两点间距离超过该值时，将启用距离补偿计算两点 间距离
  Future<DistanceResponse> queryDistance(DistanceRequest request) async {
    assert(null != request);
    if (null == request.sid) request.sid = sid;
    _distanceCompleter = Completer();
    _methodChannel.invokeMethod('queryDistance', {'request': request.toMap()});
    return _distanceCompleter.future;
  }

  Completer<LatestPointResponse> _latestPointCompleter;

  /// 查询最新轨迹点
  Future<LatestPointResponse> queryLatestPoint(
      LatestPointRequest request) async {
    assert(null != request);
    if (null == request.sid) request.sid = sid;
    _latestPointCompleter = Completer();
    _methodChannel
        .invokeMethod('queryLatestPoint', {'request': request.toMap()});
    return _latestPointCompleter.future;
  }

  Completer<HistoryTrackResponse> _historyTrackCompleter;

  /// 查询历史轨迹
  Future<HistoryTrackResponse> queryHistoryTrack(
      HistoryTrackRequest request) async {
    assert(null != request);
    if (null == request.sid) request.sid = sid;
    _historyTrackCompleter = Completer();
    _methodChannel
        .invokeMethod('queryHistoryTrack', {'request': request.toMap()});
    return _historyTrackCompleter.future;
  }

  Completer<QueryTrackResponse> _queryTrackCompleter;

  /// 查询终端下的轨迹
  Future<QueryTrackResponse> queryTerminalTrack(
      QueryTrackRequest request) async {
    assert(null != request);
    if (null == request.sid) request.sid = sid;
    _queryTrackCompleter = Completer();
    _methodChannel
        .invokeMethod('queryTerminalTrack', {'request': request.toMap()});
    return _queryTrackCompleter.future;
  }

  Completer<AddTrackResponse> _addTrackCompleter;

  /// 增加轨迹
  Future<AddTrackResponse> addTrack(AddTrackRequest request) async {
    assert(null != request);
    if (null == request.sid) request.sid = sid;
    _addTrackCompleter = Completer();
    _methodChannel.invokeMethod('addTrack', {'request': request.toMap()});
    return _addTrackCompleter.future;
  }
}
