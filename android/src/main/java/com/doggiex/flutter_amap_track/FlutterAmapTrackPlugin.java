package com.doggiex.flutter_amap_track;

import android.content.Context;

import androidx.annotation.NonNull;

import com.amap.api.track.AMapTrackClient;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterAmapTrackPlugin
 */
public class FlutterAmapTrackPlugin implements FlutterPlugin {
    private MethodChannel channel;
    private Context context;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        context = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_amap_track");
        channel.setMethodCallHandler(new TrackMethodHandler(context, channel, new AMapTrackClient(context)));
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
