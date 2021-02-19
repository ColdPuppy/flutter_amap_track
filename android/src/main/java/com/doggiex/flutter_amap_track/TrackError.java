package com.doggiex.flutter_amap_track;

import java.util.HashMap;
import java.util.Map;

/**
 * @author DoggieX
 * @create 2021/2/8 23:32
 * @mail coldpuppy@163.com
 */
public class TrackError {
    public static String PARAM_ERROR = "3001";

    public static Map<String,String> ERROR_MAP;

    static {
        ERROR_MAP = new HashMap<>();
        ERROR_MAP.put(PARAM_ERROR,"参数错误");
    }
}
