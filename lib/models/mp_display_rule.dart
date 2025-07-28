part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A unique identifier for display rules
@immutable
class MPDisplayRuleId extends DynamicObjectId {
  const MPDisplayRuleId(super.value);
}

/// A collection of settings that dictate how MapsIndoors objects are displayed on the map
@immutable
class MPDisplayRule implements DynamicObject<MPDisplayRuleId> {
  const MPDisplayRule._(this._id);

  final MPDisplayRuleId _id;

  /// Get the display rule's [id]
  @override
  MPDisplayRuleId get id => _id;

  /// The name of the display rule
  String get displayRuleName => _id.value;

  /// Get the general visibility value
  Future<bool?> isVisible() => DisplayRulePlatform.instance.isVisible(id);

  /// Set the general visibility value
  Future<void> setVisible(bool visible) =>
      DisplayRulePlatform.instance.setVisible(id, visible);

  /// Get the icon's visibility value
  Future<bool?> isIconVisible() =>
      DisplayRulePlatform.instance.isIconVisible(id);

  /// Set the icon's visibility value
  Future<void> setIconVisible(bool visible) =>
      DisplayRulePlatform.instance.setIconVisible(id, visible);

  /// Get the general zoom from value
  Future<num?> getZoomFrom() => DisplayRulePlatform.instance.getZoomFrom(id);

  /// Set the general zoom from value
  Future<void> setZoomFrom(num from) =>
      DisplayRulePlatform.instance.setZoomFrom(id, from);

  /// Get the general zoom to value
  Future<num?> getZoomTo() => DisplayRulePlatform.instance.getZoomTo(id);

  /// Set the general zoom to value
  Future<void> setZoomTo(num to) =>
      DisplayRulePlatform.instance.setZoomTo(id, to);

  /// Get the icon's URL
  Future<String?> getIconUrl() => DisplayRulePlatform.instance.getIconUrl(id);

  /// Set the icon's URL
  Future<void> setIcon(String url) =>
      DisplayRulePlatform.instance.setIcon(id, url);

  /// Get the icon's size
  Future<MPIconSize?> getIconSize() =>
      DisplayRulePlatform.instance.getIconSize(id);

  /// Set the icon's size
  Future<void> setIconSize(MPIconSize size) =>
      DisplayRulePlatform.instance.setIconSize(id, size);

  /// Get the icon's placement relative to the anchor point
  Future<MPIconPlacement?> getIconPlacement() =>
      DisplayRulePlatform.instance.getIconPlacement(id);

  /// Set the icon's placement realtive to the anchor point
  Future<void> setIconPlacement(MPIconPlacement placement) =>
      DisplayRulePlatform.instance.setIconPlacement(id, placement);

  /// Get the label's visibility value
  Future<bool?> isLabelVisible() =>
      DisplayRulePlatform.instance.isLabelVisible(id);

  /// Set the label's visibility value
  Future<void> setLabelVisible(bool visible) =>
      DisplayRulePlatform.instance.setLabelVisible(id, visible);

  /// Get the label string
  Future<String?> getLabel() => DisplayRulePlatform.instance.getLabel(id);

  /// Set the label string
  Future<void> setLabel(String label) =>
      DisplayRulePlatform.instance.setLabel(id, label);

  /// Get the label's type
  Future<MPLabelType?> getLabelType() =>
      DisplayRulePlatform.instance.getLabelType(id);

  /// Set the label's type
  Future<void> setLabelType(MPLabelType type) =>
      DisplayRulePlatform.instance.setLabelType(id, type);

  /// Get the label's zoom from value
  Future<num?> getLabelZoomFrom() =>
      DisplayRulePlatform.instance.getLabelZoomFrom(id);

  /// Set the label's zoom from value
  Future<void> setLabelZoomFrom(num from) =>
      DisplayRulePlatform.instance.setLabelZoomFrom(id, from);

  /// Get the label's zoom to value
  Future<num?> getLabelZoomTo() =>
      DisplayRulePlatform.instance.getLabelZoomTo(id);

  /// Set the label's zoom to value
  Future<void> setLabelZoomTo(num to) =>
      DisplayRulePlatform.instance.setLabelZoomTo(id, to);

  /// Get the label's max width value
  Future<int?> getLabelMaxWidth() =>
      DisplayRulePlatform.instance.getLabelMaxWidth(id);

  /// Set the label's max width value
  Future<void> setLabelMaxWidth(int max) =>
      DisplayRulePlatform.instance.setLabelMaxWidth(id, max);

  // labelStyle
  /// Get the labelStyle's text size
  Future<num?> getLabelStyleTextSize() =>
      DisplayRulePlatform.instance.getLabelStyleTextSize(id);

  /// Set the labelStyle's text size
  Future<void> setLabelStyleTextSize(num max) =>
      DisplayRulePlatform.instance.setLabelStyleTextSize(id, max);

  /// Get the labelStyle's text color
  Future<Color?> getLabelStyleTextColor() =>
      DisplayRulePlatform.instance.getLabelStyleTextColor(id);

  /// Set the labelStyle's text color
  Future<void> setLabelStyleTextColor(Color color) =>
      DisplayRulePlatform.instance.setLabelStyleTextColor(id, color);

  /// Get the labelStyle's text opacity
  Future<num?> getLabelStyleTextOpacity() =>
      DisplayRulePlatform.instance.getLabelStyleTextOpacity(id);

  /// Set the labelStyle's text opacity
  Future<void> setLabelStyleTextOpacity(num opacity) =>
      DisplayRulePlatform.instance.setLabelStyleTextOpacity(id, opacity);

  /// Get the labelStyle's halo color
  Future<Color?> getLabelStyleHaloColor() =>
      DisplayRulePlatform.instance.getLabelStyleHaloColor(id);

  /// Set the labelStyle's halo color
  Future<void> setLabelStyleHaloColor(Color color) =>
      DisplayRulePlatform.instance.setLabelStyleHaloColor(id, color);

  /// Get the labelStyle's halo width
  Future<num?> getLabelStyleHaloWidth() =>
      DisplayRulePlatform.instance.getLabelStyleHaloWidth(id);

  /// Set the labelStyle's halo width
  Future<void> setLabelStyleHaloWidth(num width) =>
      DisplayRulePlatform.instance.setLabelStyleHaloWidth(id, width);

  /// Get the labelStyle's halo blur
  Future<num?> getLabelStyleHaloBlur() =>
      DisplayRulePlatform.instance.getLabelStyleHaloBlur(id);

  /// Set the labelStyle's halo blur
  Future<void> setLabelStyleHaloBlur(num blur) =>
      DisplayRulePlatform.instance.setLabelStyleHaloBlur(id, blur);

  /// Get the labelStyle's bearing
  Future<num?> getLabelStyleBearing() =>
      DisplayRulePlatform.instance.getLabelStyleBearing(id);

  /// Set the labelStyle's bearing
  Future<void> setLabelStyleBearing(num bearing) =>
      DisplayRulePlatform.instance.setLabelStyleBearing(id, bearing);

  /// Get the labelStyle's graphic label
  Future<MPLabelGraphic?> getLabelStyleGraphic() =>
      DisplayRulePlatform.instance.getLabelStyleGraphic(id);

  /// Set the labelStyle's graphic label
  Future<void> setLabelStyleGraphic(MPLabelGraphic graphic) =>
      DisplayRulePlatform.instance.setLabelStyleGraphic(id, graphic);

  // polygon
  /// Get the polygon's visibility value
  Future<bool?> isPolygonVisible() =>
      DisplayRulePlatform.instance.isPolygonVisible(id);

  /// Set the polygon's visibility value
  Future<void> setPolygonVisible(bool visible) =>
      DisplayRulePlatform.instance.setPolygonVisible(id, visible);

  /// Get the polygon's zoom from value
  Future<num?> getPolygonZoomFrom() =>
      DisplayRulePlatform.instance.getPolygonZoomFrom(id);

  /// Set the polygon's zoom from value
  Future<void> setPolygonZoomFrom(num from) =>
      DisplayRulePlatform.instance.setPolygonZoomFrom(id, from);

  /// Get the polygon's zoom to value
  Future<num?> getPolygonZoomTo() =>
      DisplayRulePlatform.instance.getPolygonZoomTo(id);

  /// Set the polygon's zoom to value
  Future<void> setPolygonZoomTo(num to) =>
      DisplayRulePlatform.instance.setPolygonZoomTo(id, to);

  /// Get the polygon's stroke width value
  Future<num?> getPolygonStrokeWidth() =>
      DisplayRulePlatform.instance.getPolygonStrokeWidth(id);

  /// Set the polygon's stroke width value
  Future<void> setPolygonStrokeWidth(num width) =>
      DisplayRulePlatform.instance.setPolygonStrokeWidth(id, width);

  /// Get the polygon's stroke color value
  Future<Color?> getPolygonStrokeColor() =>
      DisplayRulePlatform.instance.getPolygonStrokeColor(id);

  /// Set the polygon's stroke color value
  Future<void> setPolygonStrokeColor(Color color) =>
      DisplayRulePlatform.instance.setPolygonStrokeColor(id, color);

  /// Get the polygon's stroke opacity value
  Future<num?> getPolygonStrokeOpacity() =>
      DisplayRulePlatform.instance.getPolygonStrokeOpacity(id);

  /// Set the polygon's stroke opacity value
  Future<void> setPolygonStrokeOpacity(num opacity) =>
      DisplayRulePlatform.instance.setPolygonStrokeOpacity(id, opacity);

  /// Get the polygon's fill color value
  Future<Color?> getPolygonFillColor() =>
      DisplayRulePlatform.instance.getPolygonFillColor(id);

  /// Set the polygon's fill color value
  Future<void> setPolygonFillColor(Color color) =>
      DisplayRulePlatform.instance.setPolygonFillColor(id, color);

  /// Get the polygon's fill opacity value
  Future<num?> getPolygonFillOpacity() =>
      DisplayRulePlatform.instance.getPolygonFillOpacity(id);

  /// Set the polygon's fill opacity value
  Future<void> setPolygonFillOpacity(num opacity) =>
      DisplayRulePlatform.instance.setPolygonFillOpacity(id, opacity);

  /// Get the polygon's lightness factor
  Future<num?> getPolygonLightnessFactor() =>
      DisplayRulePlatform.instance.getPolygonLightnessFactor(id);

  /// Set the polygon's lightness factor
  Future<void> setPolygonLightnessFactor(num factor) =>
      DisplayRulePlatform.instance.setPolygonLightnessFactor(id, factor);

  // wall
  /// Get the wall's visibility value
  Future<bool?> isWallVisible() =>
      DisplayRulePlatform.instance.isWallVisible(id);

  /// Set the wall's visibility value
  Future<void> setWallVisible(bool visible) =>
      DisplayRulePlatform.instance.setWallVisible(id, visible);

  /// Get the wall's color value
  Future<Color?> getWallColor() =>
      DisplayRulePlatform.instance.getWallColor(id);

  /// Set the wall's color value
  Future<void> setWallColor(Color color) =>
      DisplayRulePlatform.instance.setWallColor(id, color);

  /// Get the wall's height value
  Future<num?> getWallHeight() =>
      DisplayRulePlatform.instance.getWallHeight(id);

  /// Set the wall's height value
  Future<void> setWallHeight(num height) =>
      DisplayRulePlatform.instance.setWallHeight(id, height);

  /// Get the wall's zoom from value
  Future<num?> getWallZoomFrom() =>
      DisplayRulePlatform.instance.getWallZoomFrom(id);

  /// Set the wall's zoom from value
  Future<void> setWallZoomFrom(num from) =>
      DisplayRulePlatform.instance.setWallZoomFrom(id, from);

  /// Get the wall's zoom to value
  Future<num?> getWallZoomTo() =>
      DisplayRulePlatform.instance.getWallZoomTo(id);

  /// Set the wall's zoom to value
  Future<void> setWallZoomTo(num to) =>
      DisplayRulePlatform.instance.setWallZoomTo(id, to);

  /// Get the wall's lightness factor
  Future<num?> getWallLightnessFactor() =>
      DisplayRulePlatform.instance.getWallLightnessFactor(id);

  /// Set the wall's lightness factor
  Future<void> setWallLightnessFactor(num factor) =>
      DisplayRulePlatform.instance.setWallLightnessFactor(id, factor);

  //extrusion
  /// Get the extrusion's visibility value
  Future<bool?> isExtrusionVisible() =>
      DisplayRulePlatform.instance.isExtrusionVisible(id);

  /// Set the extrusion's visibility value
  Future<void> setExtrusionVisible(bool visible) =>
      DisplayRulePlatform.instance.setExtrusionVisible(id, visible);

  /// Get the extrusion's color value
  Future<Color?> getExtrusionColor() =>
      DisplayRulePlatform.instance.getExtrusionColor(id);

  /// Set the extrusion's color value
  Future<void> setExtrusionColor(Color color) =>
      DisplayRulePlatform.instance.setExtrusionColor(id, color);

  /// Get the extrusion's height value
  Future<num?> getExtrusionHeight() =>
      DisplayRulePlatform.instance.getExtrusionHeight(id);

  /// Set the extrusion's height value
  Future<void> setExtrusionHeight(num height) =>
      DisplayRulePlatform.instance.setExtrusionHeight(id, height);

  /// Get the extrusion's zoom from value
  Future<num?> getExtrusionZoomFrom() =>
      DisplayRulePlatform.instance.getExtrusionZoomFrom(id);

  /// Set the extrusion's zoom from value
  Future<void> setExtrusionZoomFrom(num from) =>
      DisplayRulePlatform.instance.setExtrusionZoomFrom(id, from);

  /// Get the extrusion's zoom to value
  Future<num?> getExtrusionZoomTo() =>
      DisplayRulePlatform.instance.getExtrusionZoomTo(id);

  /// Set the extrusion's zoom to value
  Future<void> setExtrusionZoomTo(num to) =>
      DisplayRulePlatform.instance.setExtrusionZoomTo(id, to);

  /// Get the extrusion's lightness factor
  Future<num?> getExtrusionLightnessFactor() =>
      DisplayRulePlatform.instance.getExtrusionLightnessFactor(id);

  /// Set the extrusion's lightness factor
  Future<void> setExtrusionLightnessFactor(num factor) =>
      DisplayRulePlatform.instance.setExtrusionLightnessFactor(id, factor);

  //2d models
  /// Get the 2D model's visibility value
  Future<bool?> isModel2DVisible() =>
      DisplayRulePlatform.instance.isModel2DVisible(id);

  /// Set the 2D model's visibility value
  Future<void> setModel2DVisible(bool visible) =>
      DisplayRulePlatform.instance.setModel2DVisible(id, visible);

  /// Get the 2D model's zoom from value
  Future<num?> getModel2DZoomFrom() =>
      DisplayRulePlatform.instance.getModel2DZoomFrom(id);

  /// Set the 2D model's zoom from value
  Future<void> setModel2DZoomFrom(num from) =>
      DisplayRulePlatform.instance.setModel2DZoomFrom(id, from);

  /// Get the 2D model's zoom to value
  Future<num?> getModel2DZoomTo() =>
      DisplayRulePlatform.instance.getModel2DZoomTo(id);

  /// Set the 2D model's zoom to value
  Future<void> setModel2DZoomTo(num to) =>
      DisplayRulePlatform.instance.setModel2DZoomTo(id, to);

  /// Get the 2D model's URL
  Future<String?> getModel2DModel() =>
      DisplayRulePlatform.instance.getModel2DModel(id);

  /// Set the 2D model's URL
  Future<void> setModel2DModel(String url) =>
      DisplayRulePlatform.instance.setModel2DModel(id, url);

  /// Get the 2D model's width in meters
  Future<num?> getModel2DWidthMeters() =>
      DisplayRulePlatform.instance.getModel2DWidthMeters(id);

  /// Set the 2D model's width in meters
  Future<void> setModel2DWidthMeters(num width) =>
      DisplayRulePlatform.instance.setModel2DWidthMeters(id, width);

  /// Get the 2D model's height in meters
  Future<num?> getModel2DHeightMeters() =>
      DisplayRulePlatform.instance.getModel2DHeightMeters(id);

  /// Set the 2D model's height in meters
  Future<void> setModel2DHeightMeters(num height) =>
      DisplayRulePlatform.instance.setModel2DHeightMeters(id, height);

  /// Get the 2D model's bearing value
  Future<num?> getModel2DBearing() =>
      DisplayRulePlatform.instance.getModel2DBearing(id);

  /// Get the 2D model's bearing value
  Future<void> setModel2DBearing(num bearing) =>
      DisplayRulePlatform.instance.setModel2DBearing(id, bearing);

  /// Set the 3D model's visibility
  Future<void> setModel3DVisible(bool visible) =>
      DisplayRulePlatform.instance.setModel3DVisible(id, visible);

  /// Get whether the 3D model is visible
  Future<bool?> isModel3DVisible() =>
      DisplayRulePlatform.instance.isModel3DVisible(id);

  /// Set the 3D model's zoom from value
  Future<void> setModel3DZoomFrom(num from) =>
      DisplayRulePlatform.instance.setModel3DZoomFrom(id, from);

  /// Get the 3D model's zoom from value
  Future<num?> getModel3DZoomFrom() =>
      DisplayRulePlatform.instance.getModel3DZoomFrom(id);

  /// Set the 3D model's zoom to value
  Future<void> setModel3DZoomTo(num to) =>
      DisplayRulePlatform.instance.setModel3DZoomTo(id, to);

  /// Get the 3D model's zoom to value
  Future<num?> getModel3DZoomTo() =>
      DisplayRulePlatform.instance.getModel3DZoomTo(id);

  /// Set the 3D model's URI to a specific model, valid URI schemes are: https, file, asset
  Future<void> setModel3DModel(String model) =>
      DisplayRulePlatform.instance.setModel3DModel(id, model);

  /// Get the 3D model's URI
  Future<String?> getModel3DModel() =>
      DisplayRulePlatform.instance.getModel3DModel(id);

  /// Set the 3D model's rotation value on the X-axis in degrees
  Future<void> setModel3DRotationX(num rotation) =>
      DisplayRulePlatform.instance.setModel3DRotationX(id, rotation);

  /// Get the 3D model's rotation value on the X-axis in degrees
  Future<num?> getModel3DRotationX() =>
      DisplayRulePlatform.instance.getModel3DRotationX(id);

  /// Set the 3D model's rotation value on the Y-axis in degrees
  Future<void> setModel3DRotationY(num rotation) =>
      DisplayRulePlatform.instance.setModel3DRotationY(id, rotation);

  /// Get the 3D model's rotation value on the Y-axis in degrees
  Future<num?> getModel3DRotationY() =>
      DisplayRulePlatform.instance.getModel3DRotationY(id);

  /// Set the 3D model's rotation value on the Z-axis in degrees
  Future<void> setModel3DRotationZ(num rotation) =>
      DisplayRulePlatform.instance.setModel3DRotationZ(id, rotation);

  /// Get the 3D model's rotation value on the Z-axis in degrees
  Future<num?> getModel3DRotationZ() =>
      DisplayRulePlatform.instance.getModel3DRotationZ(id);

  /// Set the 3D model's scale
  Future<void> setModel3DScale(num scale) =>
      DisplayRulePlatform.instance.setModel3DScale(id, scale);

  /// Get the 3D model's scale
  Future<num?> getModel3DScale() =>
      DisplayRulePlatform.instance.getModel3DScale(id);

// badge
  /// Get the badge's visibility
  Future<bool?> isBadgeVisible() =>
      DisplayRulePlatform.instance.isBadgeVisible(id);

  /// Set the badge's visibility
  Future<void> setBadgeVisible(bool visible) =>
      DisplayRulePlatform.instance.setBadgeVisible(id, visible);

  /// Get the badge's zoom from value
  Future<num?> getBadgeZoomFrom() =>
      DisplayRulePlatform.instance.getBadgeZoomFrom(id);

  /// Set the badge's zoom from vale
  Future<void> setBadgeZoomFrom(num from) =>
      DisplayRulePlatform.instance.setBadgeZoomFrom(id, from);

  /// Get the badge's zoom to value
  Future<num?> getBadgeZoomTo() =>
      DisplayRulePlatform.instance.getBadgeZoomTo(id);

  /// Set the badge's zoom to value
  Future<void> setBadgeZoomTo(num to) =>
      DisplayRulePlatform.instance.setBadgeZoomTo(id, to);

  /// Get the badge's stroke width
  Future<num?> getBadgeStrokeWidth() =>
      DisplayRulePlatform.instance.getBadgeStrokeWidth(id);

  /// Set the badge's stroke width
  Future<void> setBadgeStrokeWidth(num width) =>
      DisplayRulePlatform.instance.setBadgeStrokeWidth(id, width);

  /// Get the badge's stroke color
  Future<Color?> getBadgeStrokeColor() =>
      DisplayRulePlatform.instance.getBadgeStrokeColor(id);

  /// Set the badge's stroke color
  Future<void> setBadgeStrokeColor(Color color) =>
      DisplayRulePlatform.instance.setBadgeStrokeColor(id, color);

  /// Get the badge's fill color
  Future<Color?> getBadgeFillColor() =>
      DisplayRulePlatform.instance.getBadgeFillColor(id);

  /// Set the badge's fill color
  Future<void> setBadgeFillColor(Color color) =>
      DisplayRulePlatform.instance.setBadgeFillColor(id, color);

  /// Get the badge's scale
  Future<num?> getBadgeScale() =>
      DisplayRulePlatform.instance.getBadgeScale(id);

  /// Set the badge's scale
  Future<void> setBadgeScale(num scale) =>
      DisplayRulePlatform.instance.setBadgeScale(id, scale);

  /// Get the badge's radius
  Future<num?> getBadgeRadius() =>
      DisplayRulePlatform.instance.getBadgeRadius(id);

  /// Set the badge's radius
  Future<void> setBadgeRadius(num radius) =>
      DisplayRulePlatform.instance.setBadgeRadius(id, radius);

  /// Get the badge's visibility
  Future<MPBadgePosition?> getBadgePosition() =>
      DisplayRulePlatform.instance.getBadgePosition(id);

  /// Set the badge's visibility
  Future<void> setBadgePosition(MPBadgePosition position) =>
      DisplayRulePlatform.instance.setBadgePosition(id, position);

  Future<MPLabelPosition?> getLabelStylePosition() =>
      DisplayRulePlatform.instance.getLabelStylePosition(id);

  Future<void> setLabelStylePosition(MPLabelPosition position) =>
      DisplayRulePlatform.instance.setLabelStylePosition(id, position);

  Future<void> reset() => DisplayRulePlatform.instance.reset(id);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MPDisplayRule && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
