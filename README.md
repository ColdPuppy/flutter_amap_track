## flutter_amap_track

[![pub 
package](https://img.shields.io/pub/v/flutter_amap_track.svg)](https://pub.dartlang.org/packages/flutter_amap_track)

本插件为高德猎鹰Api的搬运和实现

[Android猎鹰文档](https://developer.amap.com/api/android-track/summary)

[iOS猎鹰文档](https://developer.amap.com/api/ios-track/summary/)

### Android

#### 配置高德key

为了保证高德 Android SDK 的功能正常使用，您需要申请高德 Key 并且配置到项目中。在项目的 “AndroidManifest.xml” 文件中，添加如下代码：
``` xml
<application 
    android:icon="@drawable/icon" 
    android:label="@string/app_name" > 
    <meta-data 
        android:name="com.amap.api.v2.apikey" 
        android:value="请输入您的用户Key"/> 
        …… 
</application>
```

### iOS

#### 更改info.plist 及 配置后台定位
在info.plist的字段添加定位权限的申请及配置后台定位能力，配置方式请参考[iOS 猎鹰SDK 手动部署](https://developer.amap.com/api/ios-track/guide/create-project/manual-configuration)部分说明

#### 设置apikey
```
AmapTrack.getInstance().setIOSApiKey('xxx');
```

### 使用
#### 全局设置serviceId并初始化猎鹰组件
``` dart
    AmapTrack.getInstance().initWithServiceId(xxx);
```

#### 终端管理
1. 查询终端
``` dart
try {
	var response = await AmapTrack.getInstance()
		.queryTerminal(QueryTerminalRequest(
			terminal: terminalName));
	...
  } on ErrorResponse catch (e) {
	print('${e.errorCode} | ${e.errorMsg} | ${e.errorDetail}');
  }
```

2. 创建终端
``` dart
try {
	var response = await AmapTrack.getInstance()
		.addTerminal(
			AddTerminalRequest(terminal: terminalName));
	...
  } on ErrorResponse catch (e) {
	...
  }
```

#### 轨迹上报
1. 开启轨迹服务
``` dart
await AmapTrack.getInstance().startTrack(TrackParam(tid:  tid,trid: trid));
```
2. 开启定位采集
``` dart
await AmapTrack.getInstance().startGather();
```
3. 结束定位采集
``` dart
await AmapTrack.getInstance().stopGather();
```
4. 结束轨迹服务
``` dart
await AmapTrack.getInstance().stopTrack(TrackParam(tid: tid,trid: trid));
```

#### 轨迹查询
1. 查询终端实时位置
``` dart
var latestPoint = await AmapTrack.getInstance().queryLatestPoint(LatestPointRequest(tid: tid));
```

2. 查询终端行驶里程
``` dart
var distanceResponse = await AmapTrack.getInstance().queryDistance(DistanceRequest(...));
```

3. 查询终端所有轨迹点
``` dart
var historyTrackResponse = await AmapTrack.getInstance().queryHistoryTrack(HistoryTrackRequest(...));
```

4. 查询终端某个轨迹的轨迹点
``` dart
var queryTrackResponse = await AmapTrack.getInstance().queryTerminalTrack(QueryTrackRequest(...));
```


* * *

## 本插件API更多参考的是官方Android猎鹰API，兼容了iOS部分，更多api及参数可前往官网查询