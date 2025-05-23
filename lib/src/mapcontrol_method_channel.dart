part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// An implementation of [MapcontrolPlatform] that uses method channels.
class MethodChannelMapControl extends MapcontrolPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final mapControlMethodChannel =
      const MethodChannel('MapControlMethodChannel');
  final listenerChannel =
      const MethodChannel('MapControlListenerMethodChannel');
  final floorSelectorChannel =
      const MethodChannel('MapControlFloorSelectorChannel');
  final List<MPCameraEventListener> _cameraEventListeners =
      List.empty(growable: true);
  final List<OnFloorUpdateListener> _floorUpdateListeners =
      List.empty(growable: true);

  OnBuildingFoundAtCameraTargetListener? _buildingFoundAtCameraTargetListener;
  OnVenueFoundAtCameraTargetListener? _venueFoundAtCameraTargetListener;
  OnMarkerInfoWindowClickListener? _infoWindowClickListener;
  OnLocationSelectedListener? _locationSelectedListener;
  OnMarkerClickListener? _markerClickListener;
  OnMapClickListener? _mapClickListener;

  OnMapReadyListener? onMapControlReady;

  final Map<String, OnLiveLocationUpdateListener> _liveUpdateListeners =
      <String, void Function(MPLocation)>{};

  MPFloorSelectorInterface? _floorSelector;

  MethodChannelMapControl() {
    listenerChannel.setMethodCallHandler((call) => _listenerHandler(call));
    floorSelectorChannel
        .setMethodCallHandler((call) => _floorSelectorHandler(call));
    mapControlMethodChannel
        .setMethodCallHandler((call) => _mapControlHandler(call));
  }

  Future<dynamic> _mapControlHandler(MethodCall call) async {
    switch (call.method) {
      case "create":
        final error = MPError.fromJson(call.arguments);
        onMapControlReady?.call(error);
        onMapControlReady = null;
        break;
      default:
        throw UnimplementedError();
    }
  }

  Future<dynamic> _listenerHandler(MethodCall call) async {
    switch (call.method) {
      case "onBuildingFoundAtCameraTarget":
        final building = MPBuilding.fromJson(call.arguments);
        _buildingFoundAtCameraTargetListener?.call(building);
        break;
      case "onVenueFoundAtCameraTarget":
        final venue = MPVenue.fromJson(call.arguments);
        _venueFoundAtCameraTargetListener?.call(venue);
        break;
      case "onInfoWindowClick":
        final String locationId = call.arguments;
        _infoWindowClickListener?.call(locationId);
        break;
      case "onLocationSelected":
        final MPLocation? location = MPLocation.fromJson(call.arguments);
        _locationSelectedListener?.call(location);
        break;

      case "onMarkerClick":
        final String locationId = call.arguments;
        _markerClickListener?.call(locationId);
        break;
      case "onCameraEvent":
        for (final listener in _cameraEventListeners) {
          listener(MPCameraEvent.values[call.arguments]);
        }
        break;
      case "onFloorUpdate":
        num floor = call.arguments as num;
        for (final listener in _floorUpdateListeners) {
          listener(floor.toInt());
        }
        break;
      case "onMapClick":
        final point = MPPoint.fromJson(call.arguments["point"]);
        if (call.arguments["locations"] != null) {
          final locations =
              (jsonDecode(call.arguments["locations"]) as List<dynamic>)
                  .map((e) => MPLocation.fromJson(e)!);
          _mapClickListener?.call(point!, locations.toList());
        } else {
          _mapClickListener?.call(point!, null);
        }
        break;
      case "onLiveLocationUpdate":
        final location = MPLocation.fromJson(call.arguments["location"]);
        if (location != null) {
          _liveUpdateListeners[call.arguments["type"] as String]
              ?.call(location);
        }
        break;
      default:
        throw UnimplementedError();
    }
  }

  Future<dynamic> _floorSelectorHandler(MethodCall call) async {
    switch (call.method) {
      case "setList":
        final floors = call.arguments == null
            ? null
            : convertMIList<MPFloor>(
                jsonDecode(call.arguments), (p0) => MPFloor.fromJson(p0));
        _floorSelector?.floors = floors;
        break;
      case "show":
        _floorSelector?.show(call.arguments["show"]);
        break;
      case "setSelectedFloor":
        _floorSelector
            ?.setSelectedFloor(MPFloor.fromJson(jsonDecode(call.arguments))!);
        break;
      case "setSelectedFloorByZIndex":
        _floorSelector?.setSelectedFloorByFloorIndex(call.arguments);
        break;
      case "zoomLevelChanged":
        _floorSelector?.zoomLevelChanged(call.arguments);
        break;
      case "setUserPositionFloor":
        _floorSelector?.userPositionFloor = call.arguments;
        break;
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> setFloorSelector(
      MPFloorSelectorInterface? floorSelector, bool internal) {
    _floorSelector = floorSelector;
    _floorSelector?.onFloorSelectionChangedListener = onFloorSelectionChanged;
    if (internal) {
      return Future(() => null);
    } else {
      return mapControlMethodChannel.invokeMethod("MPC_setFloorSelector", {
        "isAutoFloorChangeEnabled": floorSelector?.isAutoFloorChangeEnabled
      });
    }
  }

  @override
  MPFloorSelectorInterface? getFloorSelector() {
    return _floorSelector;
  }

  void onFloorSelectionChanged(MPFloor newFloor) {
    floorSelectorChannel
        .invokeMethod("FSE_onFloorChanged", {"floor": newFloor._jsonEncode()});
  }

  @override
  Future<void> selectFloor(int floorIndex) {
    return mapControlMethodChannel
        .invokeMethod("MPC_selectFloor", {"floorIndex": floorIndex});
  }

  @override
  Future<void> clearFilter() {
    return mapControlMethodChannel.invokeMethod("MPC_clearFilter");
  }

  @override
  Future<void> deSelectLocation() {
    return mapControlMethodChannel.invokeMethod("MPC_deSelectLocation");
  }

  @override
  Future<MPBuilding?> getCurrentBuilding() async {
    final buildingData =
        await mapControlMethodChannel.invokeMethod("MPC_getCurrentBuilding");
    return MPBuilding.fromJson(buildingData);
  }

  @override
  Future<MPFloor?> getCurrentBuildingFloor() async {
    final floorData = await mapControlMethodChannel
        .invokeMethod("MPC_getCurrentBuildingFloor");
    return MPFloor.fromJson(floorData);
  }

  @override
  Future<int?> getCurrentFloorIndex() {
    return mapControlMethodChannel.invokeMethod("MPC_getCurrentFloorIndex");
  }

  @override
  Future<num?> getCurrentMapsIndoorsZoom() {
    return mapControlMethodChannel
        .invokeMethod("MPC_getCurrentMapsIndoorsZoom");
  }

  @override
  Future<MPVenue?> getCurrentVenue() async {
    final venueData =
        await mapControlMethodChannel.invokeMethod("MPC_getCurrentVenue");
    return MPVenue.fromJson(venueData);
  }

  @override
  Future<MPMapStyle?> getMapStyle() async {
    final mapStyleData =
        await mapControlMethodChannel.invokeMethod("MPC_getMapStyle");
    return MPMapStyle.fromJson(mapStyleData);
  }

  @override
  Future<int?> getMapViewPaddingBottom() {
    return mapControlMethodChannel.invokeMethod("MPC_getMapViewPaddingBottom");
  }

  @override
  Future<int?> getMapViewPaddingEnd() {
    return mapControlMethodChannel.invokeMethod("MPC_getMapViewPaddingEnd");
  }

  @override
  Future<int?> getMapViewPaddingStart() {
    return mapControlMethodChannel.invokeMethod("MPC_getMapViewPaddingStart");
  }

  @override
  Future<int?> getMapViewPaddingTop() {
    return mapControlMethodChannel.invokeMethod("MPC_getMapViewPaddingTop");
  }

  @override
  Future<void> goTo(MPEntity? entity) {
    return mapControlMethodChannel.invokeMethod("MPC_goTo", {
      "entity": entity?._jsonEncode(),
      "type": entity?.runtimeType.toString()
    });
  }

  @override
  Future<void> hideFloorSelector(bool hide) {
    return mapControlMethodChannel
        .invokeMethod("MPC_hideFloorSelector", {"hide": hide});
  }

  @override
  Future<bool?> isFloorSelectorHidden() {
    return mapControlMethodChannel.invokeMethod("MPC_isFloorSelectorHidden");
  }

  @override
  Future<bool?> isUserPositionShown() {
    return mapControlMethodChannel.invokeMethod("MPC_isUserPositionShown");
  }

  @override
  Future<void> selectBuilding(MPBuilding? building, bool moveCamera) {
    return mapControlMethodChannel.invokeMethod("MPC_selectBuilding",
        {"building": building?._jsonEncode(), "moveCamera": moveCamera});
  }

  @override
  Future<void> selectLocation(
      MPLocation? location, MPSelectionBehavior behavior) {
    return mapControlMethodChannel.invokeMethod("MPC_selectLocation",
        {"location": location?.id.value, "behavior": behavior._jsonEncode()});
  }

  @override
  Future<void> selectLocationById(String id, MPSelectionBehavior behavior) {
    return mapControlMethodChannel.invokeMethod("MPC_selectLocationById",
        {"id": id, "behavior": behavior._jsonEncode()});
  }

  @override
  Future<void> selectVenue(MPVenue? venue, bool moveCamera) {
    return mapControlMethodChannel.invokeMethod("MPC_selectVenue",
        {"venue": venue?._jsonEncode(), "moveCamera": moveCamera});
  }

  @override
  Future<bool> setFilter(MPFilter filter, MPFilterBehavior behavior) async {
    final res = await mapControlMethodChannel.invokeMethod("MPC_setFilter",
        {"filter": filter._jsonEncode(), "behavior": behavior._jsonEncode()});
    return (res == "success");
  }

  @override
  Future<void> setFilterWithLocations(
      List<MPLocation?> locations, MPFilterBehavior behavior) {
    return mapControlMethodChannel.invokeMethod("MPC_setFilterWithLocations", {
      "locations": locations.map((e) => e?.id.value).toList(),
      "behavior": behavior._jsonEncode()
    });
  }

  @override
  Future<void> setMapPadding(int start, int top, int end, int bottom) {
    return mapControlMethodChannel.invokeMethod("MPC_setMapPadding",
        {"start": start, "top": top, "end": end, "bottom": bottom});
  }

  @override
  Future<void> setMapStyle(MPMapStyle mapstyle) {
    return mapControlMethodChannel
        .invokeMethod("MPC_setMapStyle", {"mapStyle": mapstyle._jsonEncode()});
  }

  @override
  Future<void> showInfoWindowOnClickedLocation(bool show) {
    return mapControlMethodChannel
        .invokeMethod("MPC_showInfoWindowOnClickedLocation", {"show": show});
  }

  @override
  Future<void> showUserPosition(bool show) {
    return mapControlMethodChannel
        .invokeMethod("MPC_showUserPosition", {"show": show});
  }

  @override
  Future<void> disableLiveData(String domainType) {
    return mapControlMethodChannel
        .invokeMethod("MPC_disableLiveData", {"domainType": domainType});
  }

  @override
  Future<void> enableLiveData(
      String domainType, OnLiveLocationUpdateListener? listener) {
    if (listener != null) {
      _liveUpdateListeners.putIfAbsent(domainType, () => listener);
    }
    return mapControlMethodChannel.invokeMethod("MPC_enableLiveData",
        {"domainType": domainType, "listener": (listener != null)});
  }

  @override
  void addOnCameraEventListner(MPCameraEventListener listener) {
    if (_cameraEventListeners.isEmpty) {
      listenerChannel
          .invokeMethod("MPL_cameraEventListener", {"setupListener": true});
    }
    _cameraEventListeners.add(listener);
  }

  @override
  void addOnFloorUpdateListener(OnFloorUpdateListener listener) {
    if (_floorUpdateListeners.isEmpty) {
      listenerChannel
          .invokeMethod("MPL_floorUpdateListener", {"setupListener": true});
    }
    _floorUpdateListeners.add(listener);
  }

  @override
  void setOnCurrentBuildingChangedListener(
      OnBuildingFoundAtCameraTargetListener? listener) {
    listenerChannel.invokeMethod("MPL_buildingFoundAtCameraTargetListener",
        {"setupListener": listener != null});
    _buildingFoundAtCameraTargetListener = listener;
  }

  @override
  void setOnCurrentVenueChangedListener(
      OnVenueFoundAtCameraTargetListener? listener) {
    listenerChannel.invokeMethod("MPL_venueFoundAtCameraTargetListener",
        {"setupListener": listener != null});
    _venueFoundAtCameraTargetListener = listener;
  }

  @override
  void removeOnCameraEventListner(MPCameraEventListener listener) {
    _cameraEventListeners.remove(listener);
    if (_cameraEventListeners.isEmpty) {
      listenerChannel
          .invokeMethod("MPL_cameraEventListener", {"setupListener": false});
    }
  }

  @override
  void removeOnFloorUpdateListener(OnFloorUpdateListener listener) {
    _floorUpdateListeners.remove(listener);
    if (_floorUpdateListeners.isEmpty) {
      listenerChannel
          .invokeMethod("MPL_floorUpdateListener", {"setupListener": false});
    }
  }

  @override
  void setOnLocationSelectedListener(
      OnLocationSelectedListener? listener, bool? consumeEvent) {
    listenerChannel.invokeMethod("MPL_locationSelectedListener",
        {"setupListener": listener != null, "consumeEvent": consumeEvent});
    _locationSelectedListener = listener;
  }

  @override
  void setOnMapClickListener(OnMapClickListener? listener, bool? consumeEvent) {
    listenerChannel.invokeMethod("MPL_mapClickListener",
        {"setupListener": listener != null, "consumeEvent": consumeEvent});
    _mapClickListener = listener;
  }

  @override
  void setOnMarkerClickListener(
      OnMarkerClickListener? listener, bool? consumeEvent) {
    listenerChannel.invokeMethod("MPL_markerClickListener",
        {"setupListener": listener != null, "consumeEvent": consumeEvent});
    _markerClickListener = listener;
  }

  @override
  void setOnMarkerInfoWindowClickListener(
      OnMarkerInfoWindowClickListener? listener) {
    listenerChannel.invokeMethod("MPL_markerInfoWindowClickListener",
        {"setupListener": listener != null});
    _infoWindowClickListener = listener;
  }

  @override
  Future<void> animateCamera(MPCameraUpdate update, [int? duration]) {
    return mapControlMethodChannel.invokeMethod("MPC_animateCamera",
        {"update": update._jsonEncode(), "duration": duration});
  }

  @override
  Future<MPCameraPosition> currentCameraPosition() async {
    final res = await mapControlMethodChannel
        .invokeMethod("MPC_getCurrentCameraPosition");
    return MPCameraPosition._fromJson(jsonDecode(res));
  }

  @override
  Future<void> moveCamera(MPCameraUpdate update) {
    return mapControlMethodChannel
        .invokeMethod("MPC_moveCamera", {"update": update._jsonEncode()});
  }

  @override
  void setOnMapControlReadyListener(OnMapReadyListener listener) {
    onMapControlReady = listener;
  }

  @override
  Future<void> setLabelOptions(num? textSize, Color? color, bool showHalo) {
    return mapControlMethodChannel.invokeMethod("MPC_setLabelOptions", {
      "textSize": textSize?.round(),
      "color": color?.toRGBString(),
      "showHalo": showHalo
    });
  }

  @override
  Future<List<MPFeatureType>> getHiddenFeatures() async {
    var ret = <MPFeatureType>[];
    final res = (await mapControlMethodChannel
        .invokeListMethod<int>("MPC_getHiddenFeatures"));
    if (res == null) {
      return [];
    }
    for (int value in res) {
      ret.add(MPFeatureType.fromValue(value));
    }
    return ret;
  }

  @override
  Future<void> setHiddenFeatures(List<MPFeatureType> features) {
    return mapControlMethodChannel.invokeMethod("MPC_setHiddenFeatures",
        {"features": features.map((e) => e.toJson()).toList()});
  }

  @override
  Future<void> clearHighlight() {
    return mapControlMethodChannel.invokeMethod("MPC_clearHighlight");
  }

  @override
  Future<void> setHighlight(
      List<MPLocation> locations, MPHighlightBehavior behavior) {
    return mapControlMethodChannel.invokeMethod("MPC_setHighlight", {
      "locations": locations.map<String>((e) => e.id.value).toList(),
      "behavior": behavior._jsonEncode()
    });
  }

  @override
  Future<MPSelectionMode> getBuildingSelectionMode() async {
    final mode = await mapControlMethodChannel
        .invokeMethod("MPC_getBuildingSelectionMode");
    return MPSelectionMode.values[mode];
  }

  @override
  Future<MPSelectionMode> getFloorSelectionMode() async {
    final mode =
        await mapControlMethodChannel.invokeMethod("MPC_getFloorSelectionMode");
    return MPSelectionMode.values[mode];
  }

  @override
  Future<void> setBuildingSelectionMode(MPSelectionMode mode) {
    return mapControlMethodChannel
        .invokeMethod("MPC_setBuildingSelectionMode", {"mode": mode.index});
  }

  @override
  Future<void> setFloorSelectionMode(MPSelectionMode mode) {
    return mapControlMethodChannel
        .invokeMethod("MPC_setFloorSelectionMode", {"mode": mode.index});
  }

  @override
  Future<void> showCompassOnRotate(bool show) {
    return mapControlMethodChannel
        .invokeMethod("MPC_showCompassOnRotate", {"show": show});
  }
}
