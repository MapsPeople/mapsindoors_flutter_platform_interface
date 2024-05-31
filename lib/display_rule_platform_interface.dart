part of 'package:mapsindoors_platform_interface/platform_library.dart';

abstract class DisplayRulePlatform extends PlatformInterface {
  /// Constructs a MapsindoorsPlatform.
  DisplayRulePlatform() : super(token: _token);

  static final Object _token = Object();

  static DisplayRulePlatform _instance = MethodChannelDisplayRule();

  /// The default instance of [DisplayRulePlatform] to use.
  ///
  /// Defaults to [MethodChannelDisplayRule].
  static DisplayRulePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DisplayRulePlatform] when
  /// they register themselves.
  static set instance(DisplayRulePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // poi
  Future<bool?> isVisible(MPDisplayRuleId id);
  Future<void> setVisible(MPDisplayRuleId id, bool visible);
  Future<bool?> isIconVisible(MPDisplayRuleId id);
  Future<void> setIconVisible(MPDisplayRuleId id, bool visible);
  Future<num?> getZoomFrom(MPDisplayRuleId id);
  Future<void> setZoomFrom(MPDisplayRuleId id, num from);
  Future<num?> getZoomTo(MPDisplayRuleId id);
  Future<void> setZoomTo(MPDisplayRuleId id, num to);
  Future<String?> getIconUrl(MPDisplayRuleId id);
  Future<void> setIcon(MPDisplayRuleId id, String url);
  Future<MPIconSize?> getIconSize(MPDisplayRuleId id);
  Future<void> setIconSize(MPDisplayRuleId id, MPIconSize size);
  Future<MPIconPlacement?> getIconPlacement(MPDisplayRuleId id);
  Future<void> setIconPlacement(MPDisplayRuleId id, MPIconPlacement placement);
  Future<bool?> isLabelVisible(MPDisplayRuleId id);
  Future<void> setLabelVisible(MPDisplayRuleId id, bool visible);
  Future<String?> getLabel(MPDisplayRuleId id);
  Future<void> setLabel(MPDisplayRuleId id, String label);
  Future<MPLabelType?> getLabelType(MPDisplayRuleId id);
  Future<void> setLabelType(MPDisplayRuleId id, MPLabelType type);
  Future<num?> getLabelZoomFrom(MPDisplayRuleId id);
  Future<void> setLabelZoomFrom(MPDisplayRuleId id, num from);
  Future<num?> getLabelZoomTo(MPDisplayRuleId id);
  Future<void> setLabelZoomTo(MPDisplayRuleId id, num to);
  Future<int?> getLabelMaxWidth(MPDisplayRuleId id);
  Future<void> setLabelMaxWidth(MPDisplayRuleId id, int max);
  // labelStyle
  Future<num?> getLabelStyleTextSize(MPDisplayRuleId id);
  Future<void> setLabelStyleTextSize(MPDisplayRuleId id, num size);
  Future<String?> getLabelStyleTextColor(MPDisplayRuleId id);
  Future<void> setLabelStyleTextColor(MPDisplayRuleId id, String color);
  Future<num?> getLabelStyleTextOpacity(MPDisplayRuleId id);
  Future<void> setLabelStyleTextOpacity(MPDisplayRuleId id, num opacity);
  Future<String?> getLabelStyleHaloColor(MPDisplayRuleId id);
  Future<void> setLabelStyleHaloColor(MPDisplayRuleId id, String color);
  Future<num?> getLabelStyleHaloWidth(MPDisplayRuleId id);
  Future<void> setLabelStyleHaloWidth(MPDisplayRuleId id, num width);
  Future<num?> getLabelStyleHaloBlur(MPDisplayRuleId id);
  Future<void> setLabelStyleHaloBlur(MPDisplayRuleId id, num blur);
  Future<num?> getLabelStyleBearing(MPDisplayRuleId id);
  Future<void> setLabelStyleBearing(MPDisplayRuleId id, num bearing);
  // polygon
  Future<bool?> isPolygonVisible(MPDisplayRuleId id);
  Future<void> setPolygonVisible(MPDisplayRuleId id, bool visible);
  Future<num?> getPolygonZoomFrom(MPDisplayRuleId id);
  Future<void> setPolygonZoomFrom(MPDisplayRuleId id, num from);
  Future<num?> getPolygonZoomTo(MPDisplayRuleId id);
  Future<void> setPolygonZoomTo(MPDisplayRuleId id, num to);
  Future<num?> getPolygonStrokeWidth(MPDisplayRuleId id);
  Future<void> setPolygonStrokeWidth(MPDisplayRuleId id, num width);
  Future<String?> getPolygonStrokeColor(MPDisplayRuleId id);
  Future<void> setPolygonStrokeColor(MPDisplayRuleId id, String color);
  Future<num?> getPolygonStrokeOpacity(MPDisplayRuleId id);
  Future<void> setPolygonStrokeOpacity(MPDisplayRuleId id, num opacity);
  Future<String?> getPolygonFillColor(MPDisplayRuleId id);
  Future<void> setPolygonFillColor(MPDisplayRuleId id, String color);
  Future<num?> getPolygonFillOpacity(MPDisplayRuleId id);
  Future<void> setPolygonFillOpacity(MPDisplayRuleId id, num opacity);
  Future<num?> getPolygonLightnessFactor(MPDisplayRuleId id);
  Future<void> setPolygonLightnessFactor(MPDisplayRuleId id, num factor);
  // wall
  Future<bool?> isWallVisible(MPDisplayRuleId id);
  Future<void> setWallVisible(MPDisplayRuleId id, bool visible);
  Future<String?> getWallColor(MPDisplayRuleId id);
  Future<void> setWallColor(MPDisplayRuleId id, String color);
  Future<num?> getWallHeight(MPDisplayRuleId id);
  Future<void> setWallHeight(MPDisplayRuleId id, num height);
  Future<num?> getWallZoomFrom(MPDisplayRuleId id);
  Future<void> setWallZoomFrom(MPDisplayRuleId id, num from);
  Future<num?> getWallZoomTo(MPDisplayRuleId id);
  Future<void> setWallZoomTo(MPDisplayRuleId id, num to);
  Future<num?> getWallLightnessFactor(MPDisplayRuleId id);
  Future<void> setWallLightnessFactor(MPDisplayRuleId id, num factor);
  //extrusion
  Future<bool?> isExtrusionVisible(MPDisplayRuleId id);
  Future<void> setExtrusionVisible(MPDisplayRuleId id, bool visible);
  Future<String?> getExtrusionColor(MPDisplayRuleId id);
  Future<void> setExtrusionColor(MPDisplayRuleId id, String color);
  Future<num?> getExtrusionHeight(MPDisplayRuleId id);
  Future<void> setExtrusionHeight(MPDisplayRuleId id, num height);
  Future<num?> getExtrusionZoomFrom(MPDisplayRuleId id);
  Future<void> setExtrusionZoomFrom(MPDisplayRuleId id, num from);
  Future<num?> getExtrusionZoomTo(MPDisplayRuleId id);
  Future<void> setExtrusionZoomTo(MPDisplayRuleId id, num to);
  Future<num?> getExtrusionLightnessFactor(MPDisplayRuleId id);
  Future<void> setExtrusionLightnessFactor(MPDisplayRuleId id, num factor);
  //2d models
  Future<bool?> isModel2DVisible(MPDisplayRuleId id);
  Future<void> setModel2DVisible(MPDisplayRuleId id, bool visible);
  Future<num?> getModel2DZoomFrom(MPDisplayRuleId id);
  Future<void> setModel2DZoomFrom(MPDisplayRuleId id, num from);
  Future<num?> getModel2DZoomTo(MPDisplayRuleId id);
  Future<void> setModel2DZoomTo(MPDisplayRuleId id, num to);
  Future<String?> getModel2DModel(MPDisplayRuleId id);
  Future<void> setModel2DModel(MPDisplayRuleId id, String model);
  Future<num?> getModel2DWidthMeters(MPDisplayRuleId id);
  Future<void> setModel2DWidthMeters(MPDisplayRuleId id, num width);
  Future<num?> getModel2DHeightMeters(MPDisplayRuleId id);
  Future<void> setModel2DHeightMeters(MPDisplayRuleId id, num height);
  Future<num?> getModel2DBearing(MPDisplayRuleId id);
  Future<void> setModel2DBearing(MPDisplayRuleId id, num bearing);
  //3d models
  Future<void> setModel3DVisible(MPDisplayRuleId id, bool visible);
  Future<bool?> isModel3DVisible(MPDisplayRuleId id);
  Future<void> setModel3DZoomFrom(MPDisplayRuleId id, num from);
  Future<num?> getModel3DZoomFrom(MPDisplayRuleId id);
  Future<void> setModel3DZoomTo(MPDisplayRuleId id, num to);
  Future<num?> getModel3DZoomTo(MPDisplayRuleId id);
  Future<void> setModel3DModel(MPDisplayRuleId id, String model);
  Future<String?> getModel3DModel(MPDisplayRuleId id);
  Future<void> setModel3DRotationX(MPDisplayRuleId id, num rotation);
  Future<num?> getModel3DRotationX(MPDisplayRuleId id);
  Future<void> setModel3DRotationY(MPDisplayRuleId id, num rotation);
  Future<num?> getModel3DRotationY(MPDisplayRuleId id);
  Future<void> setModel3DRotationZ(MPDisplayRuleId id, num rotation);
  Future<num?> getModel3DRotationZ(MPDisplayRuleId id);
  Future<void> setModel3DScale(MPDisplayRuleId id, num scale);
  Future<num?> getModel3DScale(MPDisplayRuleId id);
  //badge
  Future<bool?> isBadgeVisible(MPDisplayRuleId id);
  Future<void> setBadgeVisible(MPDisplayRuleId id, bool visible);
  Future<num?> getBadgeZoomFrom(MPDisplayRuleId id);
  Future<void> setBadgeZoomFrom(MPDisplayRuleId id, num from);
  Future<num?> getBadgeZoomTo(MPDisplayRuleId id);
  Future<void> setBadgeZoomTo(MPDisplayRuleId id, num to);
  Future<num?> getBadgeStrokeWidth(MPDisplayRuleId id);
  Future<void> setBadgeStrokeWidth(MPDisplayRuleId id, num width);
  Future<String?> getBadgeStrokeColor(MPDisplayRuleId id);
  Future<void> setBadgeStrokeColor(MPDisplayRuleId id, String color);
  Future<String?> getBadgeFillColor(MPDisplayRuleId id);
  Future<void> setBadgeFillColor(MPDisplayRuleId id, String color);
  Future<num?> getBadgeScale(MPDisplayRuleId id);
  Future<void> setBadgeScale(MPDisplayRuleId id, num scale);
  Future<num?> getBadgeRadius(MPDisplayRuleId id);
  Future<void> setBadgeRadius(MPDisplayRuleId id, num radius);
  Future<MPBadgePosition?> getBadgePosition(MPDisplayRuleId id);
  Future<void> setBadgePosition(MPDisplayRuleId id, MPBadgePosition position);

  Future<void> reset(MPDisplayRuleId id);
}
