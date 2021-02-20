package com.doggiex.flutter_amap_track;

import com.amap.api.track.TrackParam;
import com.amap.api.track.query.model.AddTerminalRequest;
import com.amap.api.track.query.model.AddTrackRequest;
import com.amap.api.track.query.model.DistanceRequest;
import com.amap.api.track.query.model.HistoryTrackRequest;
import com.amap.api.track.query.model.LatestPointRequest;
import com.amap.api.track.query.model.QueryTerminalRequest;
import com.amap.api.track.query.model.QueryTrackRequest;

import java.util.Map;

/**
 * @author DoggieX
 * @create 2021/2/9 10:06
 * @mail coldpuppy@163.com
 */
public class ParseHelper {
    public static TrackParam parseTrackParam(Map<String, Integer> map) {
        Integer sid = map.get("sid");
        Integer tid = map.get("tid");
        Integer trackId = map.get("trackId");
        TrackParam trackParam = null;
        if (null != sid && null != tid) {
            trackParam = new TrackParam(sid, tid);
            if (null != trackId)
                trackParam.setTrackId(trackId);
        }
        return trackParam;
    }

    public static QueryTerminalRequest parseQueryTerminalRequest(Map<String, Object> map) {
        Integer sid = (Integer) map.get("sid");
        String terminal = (String) map.get("terminal");
        QueryTerminalRequest request = null;
        if (null != sid && null != terminal) {
            request = new QueryTerminalRequest(sid, terminal);
        }
        return request;
    }

    public static AddTerminalRequest parseAddTerminalRequest(Map<String, Object> map) {
        Integer sid = (Integer) map.get("sid");
        String terminal = (String) map.get("terminal");
        AddTerminalRequest request = null;
        if (null != sid && null != terminal) {
            request = new AddTerminalRequest(terminal, sid);
        }
        return request;
    }

    public static DistanceRequest parseDistanceRequest(Map<String, Object> map) {
        Integer sid = (Integer) map.get("sid");
        Integer tid = (Integer) map.get("tid");
        Long startTime = (Long) map.get("startTime");
        Long endTime = (Long) map.get("endTime");
        Integer trid = (Integer) map.get("trid");
        Integer correction = (Integer) map.get("correction");
        Integer recoup = (Integer) map.get("recoup");
        Integer gap = (Integer) map.get("gap");
        DistanceRequest request = null;
        if (null != sid && null != tid && null != startTime && null != endTime && null != trid) {
            if (null != correction && null != recoup && null != gap)
                request = new DistanceRequest(sid, tid, startTime, endTime, trid, correction, recoup, gap);
            else
                request = new DistanceRequest(sid, tid, startTime, endTime, trid);
        }
        return request;
    }

    public static LatestPointRequest parseLatestPointRequest(Map<String, Object> map) {
        Integer sid = (Integer) map.get("sid");
        Integer tid = (Integer) map.get("tid");
        Integer trid = (Integer) map.get("trid");
        Integer correction = (Integer) map.get("correction");
        String accuracy = (String) map.get("accuracy");
        LatestPointRequest request = null;
        if (null != sid && null != tid) {
            if (null != trid)
                if (null != correction)
                    request = new LatestPointRequest(sid, tid, trid, correction, accuracy);
                else
                    request = new LatestPointRequest(sid, tid, trid);
            else
                request = new LatestPointRequest(sid, tid);
        }
        return request;
    }

    public static HistoryTrackRequest parseHistoryTrackRequest(Map<String, Object> map) {
        Integer sid = (Integer) map.get("sid");
        Integer tid = (Integer) map.get("tid");
        Long startTime = (Long) map.get("startTime");
        Long endTime = (Long) map.get("endTime");
        Integer order = (Integer) map.get("order");
        Integer correction = (Integer) map.get("correction");
        Integer recoup = (Integer) map.get("recoup");
        Integer gap = (Integer) map.get("gap");
        Integer page = (Integer) map.get("page");
        Integer pageSize = (Integer) map.get("pageSize");
        String accuracy = (String) map.get("accuracy");
        HistoryTrackRequest request = null;
        if (null != sid && null != tid && null != startTime && null != endTime) {
            if (null != order && correction != null && null != recoup && null != gap && null != page && null != pageSize)
                request = new HistoryTrackRequest(sid, tid, startTime, endTime, correction, recoup, gap, order, page, pageSize, accuracy);
            else
                request = new HistoryTrackRequest(sid,tid,startTime,endTime);
        }
        return request;
    }

    public static QueryTrackRequest parseQueryTrackRequest(Map<String, Object> map) {
        Integer sid = (Integer) map.get("sid");
        Integer tid = (Integer) map.get("tid");
        Long startTime = (Long) map.get("startTime");
        Long endTime = (Long) map.get("endTime");
        Integer trid = (Integer) map.get("trid");
        Integer denoise = (Integer) map.get("denoise");
        Integer mapmatch = (Integer) map.get("mapmatch");
        Integer threshold = (Integer) map.get("threshold");
        Integer drivemode = (Integer) map.get("drivemode");
        Integer recoup = (Integer) map.get("recoup");
        Integer gap = (Integer) map.get("gap");
        Integer ispoint = (Integer) map.get("ispoint");
        Integer page = (Integer) map.get("page");
        Integer pageSize = (Integer) map.get("pageSize");
        QueryTrackRequest request = null;
        if (null != sid && null != tid && null != startTime && null != endTime) {
            if (null != trid)
                if (null != denoise && null != mapmatch && null != threshold && null != drivemode && null != recoup && null != gap && null != ispoint && null != page && null != pageSize)
                    request = new QueryTrackRequest(sid, tid, trid, startTime, endTime, denoise, mapmatch, threshold, drivemode, recoup, gap, ispoint, page, pageSize);
                else
                    request = new QueryTrackRequest(sid, tid, trid, startTime, endTime);
            else
                request = new QueryTrackRequest(sid, tid, startTime, endTime);
        }
        return request;
    }

    public static AddTrackRequest parseAddTrackRequest(Map<String, Object> map) {
        Integer sid = (Integer) map.get("sid");
        Integer tid = (Integer) map.get("tid");
        AddTrackRequest request = null;
        if (null != sid && null != tid) {
            request = new AddTrackRequest(sid, tid);
        }
        return request;
    }
}
