part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// An implementation of [MapsindoorsPlatform] that uses method channels.
class MethodChannelDisplayRule extends DisplayRulePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final displayRuleMethodChannel =
      const MethodChannel('DisplayRuleMethodChannel');

  @override
  Future<bool?> isVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isVisible", {"id": id.value});
  }

  @override
  Future<void> setVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<MPIconSize?> getIconSize(MPDisplayRuleId id) async {
    final ret = await displayRuleMethodChannel
        .invokeMethod("DRU_getIconSize", {"id": id.value});
    return MPIconSize.fromJson(ret);
  }

  @override
  Future<String?> getIconUrl(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getIconUrl", {"id": id.value});
  }

  @override
  Future<String?> getLabel(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabel", {"id": id.value});
  }

  @override
  Future<int?> getLabelMaxWidth(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabelMaxWidth", {"id": id.value});
  }

  @override
  Future<num?> getLabelZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabelZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getLabelZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabelZoomTo", {"id": id.value});
  }

  @override
  Future<num?> getModel2DBearing(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DBearing", {"id": id.value});
  }

  @override
  Future<num?> getModel2DHeightMeters(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DHeightMeters", {"id": id.value});
  }

  @override
  Future<String?> getModel2DModel(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DModel", {"id": id.value});
  }

  @override
  Future<num?> getModel2DZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DZoomTo", {"id": id.value});
  }

  @override
  Future<num?> getModel2DWidthMeters(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DWidthMeters", {"id": id.value});
  }

  @override
  Future<num?> getModel2DZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel2DZoomFrom", {"id": id.value});
  }

  @override
  Future<Color?> getPolygonFillColor(MPDisplayRuleId id) async {
    return (await displayRuleMethodChannel
            .invokeMethod<String>("DRU_getPolygonFillColor", {"id": id.value}))
        ?.toColor();
  }

  @override
  Future<num?> getPolygonFillOpacity(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonFillOpacity", {"id": id.value});
  }

  @override
  Future<num?> getPolygonZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonZoomTo", {"id": id.value});
  }

  @override
  Future<Color?> getPolygonStrokeColor(MPDisplayRuleId id) async {
    return (await displayRuleMethodChannel.invokeMethod<String>(
            "DRU_getPolygonStrokeColor", {"id": id.value}))
        ?.toColor();
  }

  @override
  Future<num?> getPolygonStrokeOpacity(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonStrokeOpacity", {"id": id.value});
  }

  @override
  Future<num?> getPolygonStrokeWidth(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonStrokeWidth", {"id": id.value});
  }

  @override
  Future<num?> getPolygonZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getZoomTo", {"id": id.value});
  }

  @override
  Future<bool?> isIconVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isIconVisible", {"id": id.value});
  }

  @override
  Future<bool?> isLabelVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isLabelVisible", {"id": id.value});
  }

  @override
  Future<bool?> isModel2DVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isModel2DVisible", {"id": id.value});
  }

  @override
  Future<bool?> isPolygonVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isPolygonVisible", {"id": id.value});
  }

  @override
  Future<void> setIcon(MPDisplayRuleId id, String url) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setIcon", {"id": id.value, "url": url});
  }

  @override
  Future<void> setIconSize(MPDisplayRuleId id, MPIconSize size) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setIconSize", {"id": id.value, "size": size._jsonEncode()});
  }

  @override
  Future<void> setIconVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setIconVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setLabel(MPDisplayRuleId id, String label) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setLabel", {"id": id.value, "label": label});
  }

  @override
  Future<void> setLabelMaxWidth(MPDisplayRuleId id, int max) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setLabelMaxWidth", {"id": id.value, "maxWidth": max});
  }

  @override
  Future<void> setLabelVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setLabelVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setLabelZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setLabelZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setLabelZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setLabelZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<void> setModel2DBearing(MPDisplayRuleId id, num bearing) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel2DBearing", {"id": id.value, "bearing": bearing});
  }

  @override
  Future<void> setModel2DModel(MPDisplayRuleId id, String model) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setModel2DModel", {"id": id.value, "model": model});
  }

  @override
  Future<void> setModel2DHeightMeters(MPDisplayRuleId id, num height) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel2DHeightMeters", {"id": id.value, "height": height});
  }

  @override
  Future<void> setModel2DVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel2DVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setModel2DWidthMeters(MPDisplayRuleId id, num width) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel2DWidthMeters", {"id": id.value, "width": width});
  }

  @override
  Future<void> setModel2DZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel2DZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setModel2DZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setModel2DZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<void> setPolygonFillColor(MPDisplayRuleId id, Color color) {
    return displayRuleMethodChannel.invokeMethod("DRU_setPolygonFillColor",
        {"id": id.value, "color": color.toRGBString()});
  }

  @override
  Future<void> setPolygonFillOpacity(MPDisplayRuleId id, num opacity) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setPolygonFillOpacity", {"id": id.value, "opacity": opacity});
  }

  @override
  Future<void> setPolygonStrokeColor(MPDisplayRuleId id, Color color) {
    return displayRuleMethodChannel.invokeMethod("DRU_setPolygonStrokeColor",
        {"id": id.value, "color": color.toRGBString()});
  }

  @override
  Future<void> setPolygonStrokeOpacity(MPDisplayRuleId id, num opacity) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setPolygonStrokeOpacity", {"id": id.value, "opacity": opacity});
  }

  @override
  Future<void> setPolygonStrokeWidth(MPDisplayRuleId id, num width) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setPolygonStrokeWidth", {"id": id.value, "width": width});
  }

  @override
  Future<void> setPolygonVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setPolygonVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setPolygonZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setPolygonZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setPolygonZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setPolygonZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<void> setZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<Color?> getExtrusionColor(MPDisplayRuleId id) async {
    return (await displayRuleMethodChannel
            .invokeMethod<String>("DRU_getExtrusionColor", {"id": id.value}))
        ?.toColor();
  }

  @override
  Future<num?> getExtrusionHeight(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getExtrusionHeight", {"id": id.value});
  }

  @override
  Future<num?> getExtrusionZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getExtrusionZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getExtrusionZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getExtrusionZoomTo", {"id": id.value});
  }

  @override
  Future<Color?> getWallColor(MPDisplayRuleId id) async {
    return (await displayRuleMethodChannel
            .invokeMethod<String>("DRU_getWallColor", {"id": id.value}))
        ?.toColor();
  }

  @override
  Future<num?> getWallHeight(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getWallHeight", {"id": id.value});
  }

  @override
  Future<num?> getWallZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getWallZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getWallZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getWallZoomTo", {"id": id.value});
  }

  @override
  Future<bool?> isExtrusionVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isExtrusionVisible", {"id": id.value});
  }

  @override
  Future<bool?> isWallVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isWallVisible", {"id": id.value});
  }

  @override
  Future<void> setExtrusionColor(MPDisplayRuleId id, Color color) {
    return displayRuleMethodChannel.invokeMethod("DRU_setExtrusionColor",
        {"id": id.value, "color": color.toRGBString()});
  }

  @override
  Future<void> setExtrusionHeight(MPDisplayRuleId id, num height) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setExtrusionHeight", {"id": id.value, "height": height});
  }

  @override
  Future<void> setExtrusionVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setExtrusionVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setExtrusionZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setExtrusionZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setExtrusionZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setExtrusionZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<void> setWallColor(MPDisplayRuleId id, Color color) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setWallColor", {"id": id.value, "color": color.toRGBString()});
  }

  @override
  Future<void> setWallHeight(MPDisplayRuleId id, num height) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setWallHeight", {"id": id.value, "height": height});
  }

  @override
  Future<void> setWallVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setWallVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setWallZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setWallZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setWallZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setWallZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<void> reset(MPDisplayRuleId id) {
    return displayRuleMethodChannel.invokeMethod("DRU_reset", {"id": id.value});
  }

  @override
  Future<String?> getModel3DModel(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel3DModel", {"id": id.value});
  }

  @override
  Future<num?> getModel3DRotationX(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel3DRotationX", {"id": id.value});
  }

  @override
  Future<num?> getModel3DRotationY(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel3DRotationY", {"id": id.value});
  }

  @override
  Future<num?> getModel3DRotationZ(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel3DRotationZ", {"id": id.value});
  }

  @override
  Future<num?> getModel3DScale(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel3DScale", {"id": id.value});
  }

  @override
  Future<bool?> isModel3DVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isModel3DVisible", {"id": id.value});
  }

  @override
  Future<num?> getModel3DZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel3DZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getModel3DZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getModel3DZoomTo", {"id": id.value});
  }

  @override
  Future<void> setModel3DModel(MPDisplayRuleId id, String model) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setModel3DModel", {"id": id.value, "model": model});
  }

  @override
  Future<void> setModel3DRotationX(MPDisplayRuleId id, num rotation) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel3DRotationX", {"id": id.value, "rotation": rotation});
  }

  @override
  Future<void> setModel3DRotationY(MPDisplayRuleId id, num rotation) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel3DRotationY", {"id": id.value, "rotation": rotation});
  }

  @override
  Future<void> setModel3DRotationZ(MPDisplayRuleId id, num rotation) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel3DRotationZ", {"id": id.value, "rotation": rotation});
  }

  @override
  Future<void> setModel3DScale(MPDisplayRuleId id, num scale) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setModel3DScale", {"id": id.value, "scale": scale});
  }

  @override
  Future<void> setModel3DVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel3DVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setModel3DZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setModel3DZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setModel3DZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setModel3DZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<Color?> getBadgeFillColor(MPDisplayRuleId id) async {
    return (await displayRuleMethodChannel
            .invokeMethod<String>("DRU_getBadgeFillColor", {"id": id.value}))
        ?.toColor();
  }

  @override
  Future<MPBadgePosition?> getBadgePosition(MPDisplayRuleId id) async {
    final ret = await displayRuleMethodChannel
        .invokeMethod("DRU_getBadgePosition", {"id": id.value});
    return MPBadgePosition.fromValue(ret);
  }

  @override
  Future<num?> getBadgeRadius(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getBadgeRadius", {"id": id.value});
  }

  @override
  Future<num?> getBadgeScale(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getBadgeScale", {"id": id.value});
  }

  @override
  Future<Color?> getBadgeStrokeColor(MPDisplayRuleId id) async {
    return (await displayRuleMethodChannel
            .invokeMethod<String>("DRU_getBadgeStrokeColor", {"id": id.value}))
        ?.toColor();
  }

  @override
  Future<num?> getBadgeStrokeWidth(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getBadgeStrokeWidth", {"id": id.value});
  }

  @override
  Future<num?> getBadgeZoomFrom(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getBadgeZoomFrom", {"id": id.value});
  }

  @override
  Future<num?> getBadgeZoomTo(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getBadgeZoomTo", {"id": id.value});
  }

  @override
  Future<num?> getExtrusionLightnessFactor(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getExtrusionLightnessFactor", {"id": id.value});
  }

  @override
  Future<MPIconPlacement?> getIconPlacement(MPDisplayRuleId id) async {
    final ret = await displayRuleMethodChannel
        .invokeMethod("DRU_getIconPlacement", {"id": id.value});
    return MPIconPlacement.fromValue(ret);
  }

  @override
  Future<num?> getLabelStyleBearing(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabelStyleBearing", {"id": id.value});
  }

  @override
  Future<num?> getLabelStyleHaloBlur(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabelStyleHaloBlur", {"id": id.value});
  }

  @override
  Future<Color?> getLabelStyleHaloColor(MPDisplayRuleId id) async {
    return (await displayRuleMethodChannel.invokeMethod<String>(
            "DRU_getLabelStyleHaloColor", {"id": id.value}))
        ?.toColor();
  }

  @override
  Future<num?> getLabelStyleHaloWidth(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabelStyleHaloWidth", {"id": id.value});
  }

  @override
  Future<Color?> getLabelStyleTextColor(MPDisplayRuleId id) async {
    return (await displayRuleMethodChannel.invokeMethod<String>(
            "DRU_getLabelStyleTextColor", {"id": id.value}))
        ?.toColor();
  }

  @override
  Future<num?> getLabelStyleTextOpacity(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabelStyleTextOpacity", {"id": id.value});
  }

  @override
  Future<num?> getLabelStyleTextSize(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getLabelStyleTextSize", {"id": id.value});
  }

  @override
  Future<MPLabelType?> getLabelType(MPDisplayRuleId id) async {
    final ret = await displayRuleMethodChannel
        .invokeMethod("DRU_getLabelType", {"id": id.value});
    return MPLabelType.fromValue(ret);
  }

  @override
  Future<num?> getPolygonLightnessFactor(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getPolygonLightnessFactor", {"id": id.value});
  }

  @override
  Future<num?> getWallLightnessFactor(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_getWallLightnessFactor", {"id": id.value});
  }

  @override
  Future<bool?> isBadgeVisible(MPDisplayRuleId id) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_isBadgeVisible", {"id": id.value});
  }

  @override
  Future<void> setBadgeFillColor(MPDisplayRuleId id, Color color) {
    return displayRuleMethodChannel.invokeMethod("DRU_setBadgeFillColor",
        {"id": id.value, "color": color.toRGBString()});
  }

  @override
  Future<void> setBadgePosition(MPDisplayRuleId id, MPBadgePosition position) {
    return displayRuleMethodChannel.invokeMethod("DRU_setBadgePosition",
        {"id": id.value, "position": position.toJson()});
  }

  @override
  Future<void> setBadgeRadius(MPDisplayRuleId id, num radius) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setBadgeRadius", {"id": id.value, "radius": radius});
  }

  @override
  Future<void> setBadgeScale(MPDisplayRuleId id, num scale) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setBadgeScale", {"id": id.value, "scale": scale});
  }

  @override
  Future<void> setBadgeStrokeColor(MPDisplayRuleId id, Color color) {
    return displayRuleMethodChannel.invokeMethod("DRU_setBadgeStrokeColor",
        {"id": id.value, "color": color.toRGBString()});
  }

  @override
  Future<void> setBadgeStrokeWidth(MPDisplayRuleId id, num width) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setBadgeStrokeWidth", {"id": id.value, "width": width});
  }

  @override
  Future<void> setBadgeVisible(MPDisplayRuleId id, bool visible) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setBadgeVisible", {"id": id.value, "visible": visible});
  }

  @override
  Future<void> setBadgeZoomFrom(MPDisplayRuleId id, num from) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setBadgeZoomFrom", {"id": id.value, "zoomFrom": from});
  }

  @override
  Future<void> setBadgeZoomTo(MPDisplayRuleId id, num to) {
    return displayRuleMethodChannel
        .invokeMethod("DRU_setBadgeZoomTo", {"id": id.value, "zoomTo": to});
  }

  @override
  Future<void> setExtrusionLightnessFactor(MPDisplayRuleId id, num factor) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setExtrusionLightnessFactor", {"id": id.value, "factor": factor});
  }

  @override
  Future<void> setIconPlacement(MPDisplayRuleId id, MPIconPlacement placement) {
    return displayRuleMethodChannel.invokeMethod("DRU_setIconPlacement",
        {"id": id.value, "placement": placement.toJson()});
  }

  @override
  Future<void> setLabelStyleBearing(MPDisplayRuleId id, num bearing) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setLabelStyleBearing", {"id": id.value, "bearing": bearing});
  }

  @override
  Future<void> setLabelStyleHaloBlur(MPDisplayRuleId id, num blur) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setLabelStyleHaloBlur", {"id": id.value, "blur": blur});
  }

  @override
  Future<void> setLabelStyleHaloColor(MPDisplayRuleId id, Color color) {
    return displayRuleMethodChannel.invokeMethod("DRU_setLabelStyleHaloColor",
        {"id": id.value, "color": color.toRGBString()});
  }

  @override
  Future<void> setLabelStyleHaloWidth(MPDisplayRuleId id, num width) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setLabelStyleHaloWidth", {"id": id.value, "width": width});
  }

  @override
  Future<void> setLabelStyleTextColor(MPDisplayRuleId id, Color color) {
    return displayRuleMethodChannel.invokeMethod("DRU_setLabelStyleTextColor",
        {"id": id.value, "color": color.toRGBString()});
  }

  @override
  Future<void> setLabelStyleTextOpacity(MPDisplayRuleId id, num opacity) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setLabelStyleTextOpacity", {"id": id.value, "opacity": opacity});
  }

  @override
  Future<void> setLabelStyleTextSize(MPDisplayRuleId id, num size) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setLabelStyleTextSize", {"id": id.value, "size": size});
  }

  @override
  Future<void> setLabelType(MPDisplayRuleId id, MPLabelType type) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setLabelType", {"id": id.value, "type": type.toJson()});
  }

  @override
  Future<void> setPolygonLightnessFactor(MPDisplayRuleId id, num factor) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setPolygonLightnessFactor", {"id": id.value, "factor": factor});
  }

  @override
  Future<void> setWallLightnessFactor(MPDisplayRuleId id, num factor) {
    return displayRuleMethodChannel.invokeMethod(
        "DRU_setWallLightnessFactor", {"id": id.value, "factor": factor});
  }

  @override
  Future<MPLabelGraphic?> getLabelStyleGraphic(MPDisplayRuleId id) async {
    final ret = await displayRuleMethodChannel
        .invokeMethod("DRU_getLabelStyleGraphic", {"id": id.value});
    return MPLabelGraphic.fromJson(ret);
  }

  @override
  Future<void> setLabelStyleGraphic(
      MPDisplayRuleId id, MPLabelGraphic graphic) {
    return displayRuleMethodChannel.invokeMethod("DRU_setLabelStyleGraphic",
        {"id": id.value, "graphic": graphic._jsonEncode()});
  }

  @override
  Future<MPLabelPosition?> getLabelStylePosition(MPDisplayRuleId id) async {
    final ret = await displayRuleMethodChannel
        .invokeMethod("DRU_getLabelStylePosition", {"id": id.value});
    return MPLabelPosition.values[ret];
  }

  @override
  Future<void> setLabelStylePosition(
      MPDisplayRuleId id, MPLabelPosition position) {
    return displayRuleMethodChannel.invokeMethod("DRU_setLabelStylePosition",
        {"id": id.value, "position": position.index});
  }
}
