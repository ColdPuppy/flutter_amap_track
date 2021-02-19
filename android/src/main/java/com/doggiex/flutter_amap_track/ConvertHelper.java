package com.doggiex.flutter_amap_track;

import com.amap.api.track.query.entity.HistoryTrack;
import com.amap.api.track.query.entity.Point;
import com.amap.api.track.query.entity.Track;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author DoggieX
 * @create 2021/2/9 16:33
 * @mail coldpuppy@163.com
 */
public class ConvertHelper {
    public static Map<String, Object> convertPoint(Point point) {
        Map<String, Object> map = new HashMap<>();
        map.put("lat", point.getLat());
        map.put("lng", point.getLng());
        map.put("time", point.getTime());
        map.put("accuracy", point.getAccuracy());
        map.put("direction", point.getDirection());
        map.put("height", point.getHeight());
        map.put("props", point.getProps());
        return map;
    }

    public static Map<String, Object> convertTrack(Track track) {
        Map<String, Object> map = new HashMap<>();
        map.put("count", track.getCount());
        map.put("distance", track.getDistance());
        map.put("time",track.getTime());
        map.put("trid",track.getTrid());
        map.put("startPoint", convertPoint(track.getStartPoint().getLocation()));
        map.put("endPoint", convertPoint(track.getEndPoint().getLocation()));
        List<Map<String, Object>> points = new ArrayList<>();
        for (Point point : track.getPoints()) {
            points.add(convertPoint(point));
        }
        map.put("points", points);
        return map;
    }

    public static Map<String, Object> convertHistoryTrack(HistoryTrack track) {
        Map<String, Object> map = new HashMap<>();
        map.put("count", track.getCount());
        map.put("distance", track.getDistance());
        map.put("startPoint", convertPoint(track.getStartPoint().getLocation()));
        map.put("endPoint", convertPoint(track.getEndPoint().getLocation()));
        List<Map<String, Object>> points = new ArrayList<>();
        for (Point point : track.getPoints()) {
            points.add(convertPoint(point));
        }
        map.put("points", points);
        return map;
    }
}
