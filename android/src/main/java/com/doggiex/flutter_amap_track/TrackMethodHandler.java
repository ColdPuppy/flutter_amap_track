package com.doggiex.flutter_amap_track;

import android.content.Context;

import androidx.annotation.NonNull;

import com.amap.api.track.AMapTrackClient;
import com.amap.api.track.OnCustomAttributeListener;
import com.amap.api.track.OnTrackLifecycleListener;
import com.amap.api.track.TrackParam;
import com.amap.api.track.query.entity.Track;
import com.amap.api.track.query.model.AddTerminalRequest;
import com.amap.api.track.query.model.AddTerminalResponse;
import com.amap.api.track.query.model.AddTrackRequest;
import com.amap.api.track.query.model.AddTrackResponse;
import com.amap.api.track.query.model.DistanceRequest;
import com.amap.api.track.query.model.DistanceResponse;
import com.amap.api.track.query.model.HistoryTrackRequest;
import com.amap.api.track.query.model.HistoryTrackResponse;
import com.amap.api.track.query.model.LatestPointRequest;
import com.amap.api.track.query.model.LatestPointResponse;
import com.amap.api.track.query.model.OnTrackListener;
import com.amap.api.track.query.model.ParamErrorResponse;
import com.amap.api.track.query.model.QueryTerminalRequest;
import com.amap.api.track.query.model.QueryTerminalResponse;
import com.amap.api.track.query.model.QueryTrackRequest;
import com.amap.api.track.query.model.QueryTrackResponse;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author DoggieX
 * @create 2021/2/8 9:06
 * @mail coldpuppy@163.com
 */
public class TrackMethodHandler implements MethodChannel.MethodCallHandler {
    private static String TAG = "TrackMethodHandler";
    private Context context;
    private final MethodChannel methodChannel;
    private final AMapTrackClient aMapTrackClient;

    public TrackMethodHandler(Context context, MethodChannel methodChannel, AMapTrackClient aMapTrackClient) {
        this.context = context;
        this.methodChannel = methodChannel;
        this.aMapTrackClient = aMapTrackClient;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "getVersion":
                getVersion(result);
                break;
            case "setCacheSize":
                setCacheSize(call);
                break;
            case "setInterval":
                setInterval(call);
                break;
            case "setLocationMode":
                setLocationMode(call);
                break;
            case "addOnCustomAttributeListener":
                addOnCustomAttributeListener();
                break;
            case "addOnTrackListener":
                addOnTrackListener();
                break;
            case "setProtocolType":
                setProtocolType(call, result);
            case "startGather":
                startGather();
                break;
            case "startTrack":
                startTrack(call, result);
                break;
            case "setTrackId":
                setTrackId(call);
                break;
            case "getTrackId":
                getTrackId(result);
                break;
            case "stopGather":
                stopGather();
                break;
            case "stopTrack":
                stopTrack(call, result);
                break;
            case "queryTerminal":
                queryTerminal(call);
                break;
            case "addTerminal":
                addTerminal(call);
                break;
            case "queryDistance":
                queryDistance(call);
                break;
            case "queryLatestPoint":
                queryLatestPoint(call);
                break;
            case "queryHistoryTrack":
                queryHistoryTrack(call);
                break;
            case "queryTerminalTrack":
                queryTerminalTrack(call);
                break;
            case "addTrack":
                addTrack(call);
                break;
            default:
                result.notImplemented();
        }
    }

    private void addTrack(MethodCall call) {
        Map<String, Object> request = call.argument("request");
        if (null != request) {
            AddTrackRequest req = ParseHelper.parseAddTrackRequest(request);
            aMapTrackClient.addTrack(req, getOnTrackListener());
        }
    }

    private void queryTerminalTrack(MethodCall call) {
        Map<String, Object> request = call.argument("request");
        if (null != request) {
            QueryTrackRequest req = ParseHelper.parseQueryTrackRequest(request);
            aMapTrackClient.queryTerminalTrack(req, getOnTrackListener());
        }
    }

    private void queryHistoryTrack(MethodCall call) {
        Map<String, Object> request = call.argument("request");
        if (null != request) {
            HistoryTrackRequest req = ParseHelper.parseHistoryTrackRequest(request);
            aMapTrackClient.queryHistoryTrack(req, getOnTrackListener());
        }
    }

    private void queryLatestPoint(MethodCall call) {
        Map<String, Object> request = call.argument("request");
        if (null != request) {
            LatestPointRequest req = ParseHelper.parseLatestPointRequest(request);
            aMapTrackClient.queryLatestPoint(req, getOnTrackListener());
        }
    }

    private void queryDistance(MethodCall call) {
        Map<String, Object> request = call.argument("request");
        if (null != request) {
            DistanceRequest req = ParseHelper.parseDistanceRequest(request);
            aMapTrackClient.queryDistance(req, getOnTrackListener());
        }
    }

    private void addTerminal(MethodCall call) {
        Map<String, Object> request = call.argument("request");
        if (null != request) {
            AddTerminalRequest req = ParseHelper.parseAddTerminalRequest(request);
            aMapTrackClient.addTerminal(req, getOnTrackListener());
        }
    }

    private void queryTerminal(MethodCall call) {
        Map<String, Object> request = call.argument("request");
        if (null != request) {
            QueryTerminalRequest req = ParseHelper.parseQueryTerminalRequest(request);
            aMapTrackClient.queryTerminal(req, getOnTrackListener());
        }
    }

    private OnTrackListener onTrackListener;

    private OnTrackListener getOnTrackListener() {
        if (null == onTrackListener) {
            final String className = "OnTrackListener";
            final Map<String, Object> params = new HashMap<>();
            onTrackListener = new OnTrackListener() {
                @Override
                public void onQueryTerminalCallback(QueryTerminalResponse queryTerminalResponse) {
                    params.put("tid", queryTerminalResponse.getTid());
                    params.put("isTerminalExist", queryTerminalResponse.isTerminalExist());
                    methodChannel.invokeMethod(className + "#onQueryTerminalCallback", params);
                }

                @Override
                public void onCreateTerminalCallback(AddTerminalResponse addTerminalResponse) {
                    params.put("tid", addTerminalResponse.getTid());
                    params.put("isServiceNonExist", addTerminalResponse.isServiceNonExist());
                    methodChannel.invokeMethod(className + "#onCreateTerminalCallback", params);
                }

                @Override
                public void onDistanceCallback(DistanceResponse distanceResponse) {
                    params.put("distance", distanceResponse.getDistance());
                    methodChannel.invokeMethod(className + "#onDistanceCallback", params);
                }

                @Override
                public void onLatestPointCallback(LatestPointResponse latestPointResponse) {
                    params.put("latestPoint", latestPointResponse.getLatestPoint().getPoint());
                    methodChannel.invokeMethod(className + "#onLatestPointCallback", params);
                }

                @Override
                public void onHistoryTrackCallback(HistoryTrackResponse historyTrackResponse) {
                    params.put("historyTrack", ConvertHelper.convertHistoryTrack(historyTrackResponse.getHistoryTrack()));
                    methodChannel.invokeMethod(className + "#onHistoryTrackCallback", params);
                }

                @Override
                public void onQueryTrackCallback(QueryTrackResponse queryTrackResponse) {
                    params.put("count", queryTrackResponse.getCount());
                    List<Map<String, Object>> tracks = new ArrayList<>();
                    for (Track track : queryTrackResponse.getTracks()) {
                        tracks.add(ConvertHelper.convertTrack(track));
                    }
                    params.put("tracks", tracks);
                    methodChannel.invokeMethod(className + "#onQueryTrackCallback", params);
                }

                @Override
                public void onAddTrackCallback(AddTrackResponse addTrackResponse) {
                    params.put("trid", addTrackResponse.getTrid());
                    methodChannel.invokeMethod(className + "#onAddTrackCallback", params);
                }

                @Override
                public void onParamErrorCallback(ParamErrorResponse paramErrorResponse) {
                    params.put("errorCode", paramErrorResponse.getErrorCode());
                    params.put("errorMsg", paramErrorResponse.getErrorMsg());
                    params.put("isSuccess", paramErrorResponse.isSuccess());
                    params.put("errorDetail", paramErrorResponse.getErrorDetail());
                    params.put("data", paramErrorResponse.getData());
                    methodChannel.invokeMethod(className + "#onParamErrorCallback", params);
                }
            };
        }
        return onTrackListener;
    }

    private void stopTrack(MethodCall call, MethodChannel.Result result) {
        Map<String, Integer> param = call.argument("param");
        if (null != param) {
            TrackParam trackParam = ParseHelper.parseTrackParam(param);
            aMapTrackClient.startTrack(trackParam, getOnTrackLifecycleListener());
        } else {
            paramError(result);
        }
    }

    private void stopGather() {
        aMapTrackClient.stopGather(getOnTrackLifecycleListener());
    }

    private void getTrackId(MethodChannel.Result result) {
        long trackId = aMapTrackClient.getTrackId();
        result.success(trackId);
    }

    private void setTrackId(MethodCall call) {
        Integer trackId = call.argument("trackId");
        if (null != trackId) aMapTrackClient.setTrackId(trackId);
    }

    private void startTrack(MethodCall call, MethodChannel.Result result) {
        Map<String, Integer> param = call.argument("param");
        if (null != param) {
            TrackParam trackParam = ParseHelper.parseTrackParam(param);
            aMapTrackClient.startTrack(trackParam, getOnTrackLifecycleListener());
        } else {
            paramError(result);
        }
    }

    private void startGather() {
        aMapTrackClient.startGather(getOnTrackLifecycleListener());
    }

    private void setProtocolType(MethodCall call, MethodChannel.Result result) {
        Integer protocolType = call.argument("protocolType");
        if (null != protocolType) aMapTrackClient.setProtocolType(protocolType);
        else
            paramError(result);
    }

    private OnTrackLifecycleListener onTrackLifecycleListener;

    private void addOnTrackListener() {
        OnTrackLifecycleListener onTrackListener = getOnTrackLifecycleListener();
        aMapTrackClient.setOnTrackListener(onTrackListener);
    }

    OnTrackLifecycleListener getOnTrackLifecycleListener() {
        if (null == onTrackLifecycleListener) {
            final String className = "OnTrackLifecycleListener";
            final Map<String, Object> params = new HashMap<>();
            onTrackLifecycleListener = new OnTrackLifecycleListener() {
                @Override
                public void onBindServiceCallback(int i, String s) {
                    params.put("status", i);
                    params.put("message", s);
                    methodChannel.invokeMethod(className + "#onBindServiceCallback", params);
                }

                @Override
                public void onStartGatherCallback(int i, String s) {
                    params.put("status", i);
                    params.put("message", s);
                    methodChannel.invokeMethod(className + "#onStartGatherCallback", params);
                }

                @Override
                public void onStartTrackCallback(int i, String s) {
                    params.put("status", i);
                    params.put("message", s);
                    methodChannel.invokeMethod(className + "#onStartTrackCallback", params);
                }

                @Override
                public void onStopGatherCallback(int i, String s) {
                    params.put("status", i);
                    params.put("message", s);
                    methodChannel.invokeMethod(className + "#onStopGatherCallback", params);
                }

                @Override
                public void onStopTrackCallback(int i, String s) {
                    params.put("status", i);
                    params.put("message", s);
                    methodChannel.invokeMethod(className + "#onStopTrackCallback", params);
                }
            };
        }
        return onTrackLifecycleListener;
    }

    private void addOnCustomAttributeListener() {
        // todo
        aMapTrackClient.setOnCustomAttributeListener(new OnCustomAttributeListener() {
            @Override
            public Map<String, String> onTrackAttributeCallback() {
                return null;
            }
        });
    }

    private void setLocationMode(MethodCall call) {
        Integer locationMode = call.argument("locationMode");
        if (null != locationMode)
            aMapTrackClient.setLocationMode(locationMode);
    }

    private void setInterval(MethodCall call) {
        Integer gatherInterval = call.argument("gatherInterval");
        Integer packInterval = call.argument("packInterval");
        if (null != gatherInterval && null != packInterval)
            aMapTrackClient.setInterval(gatherInterval, packInterval);
    }

    private void setCacheSize(MethodCall call) {
        Integer cacheSize = call.argument("cacheSize");
        if (null != cacheSize) aMapTrackClient.setCacheSize(cacheSize);
    }

    private void getVersion(MethodChannel.Result result) {
        String version = AMapTrackClient.getVersion();
        result.success(version);
    }

    private void paramError(MethodChannel.Result result) {
        result.error(TrackError.PARAM_ERROR, TrackError.ERROR_MAP.get(TrackError.PARAM_ERROR), null);
    }
}
