part of 'package:mapsindoors_platform_interface/platform_library.dart';

abstract class UtilPlatform extends PlatformInterface {
  /// Constructs a UtilPlatform.
  UtilPlatform() : super(token: _token);

  static final Object _token = Object();

  static UtilPlatform _instance = MethodChannelUtil();

  /// The default instance of [UtilPlatform] to use.
  ///
  /// Defaults to [MethodChannelUtil].
  static UtilPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UtilPlatform] when
  /// they register themselves.
  static set instance(UtilPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  //region Util
  Future<String?> getPlatformVersion();
  Future<bool?> venueHasGraph(String venueId);
  //endregion
  //region geometry
  Future<num?> pointAngleBetween(MPPoint it, MPPoint other);
  Future<num?> pointDistanceTo(MPPoint it, MPPoint other);
  Future<bool?> geometryIsInside(MPGeometry it, MPPoint point);
  Future<num?> geometryArea(MPGeometry it);
  Future<num?> geometryGetSquaredDistanceToClosestEdge(
      MPGeometry it, MPPoint point);
  //endregion

  //region solution
  Future<String?> parseMapClientUrl(String venueId, String locationId);
  Future<void> setEnableClustering(bool enable);
  Future<void> setCollisionHandling(MPCollisionHandling handling);
  Future<void> setLocationSettings(MPLocationSettings settings);
  Future<void> setExtrusionOpacity(num opacity);
  Future<void> setWallOpacity(num opacity);
  Future<void> setAutomatedZoomLimit(num? limit);
  //endregion

  //region type
  Future<void> setTypeLocationSettingsSelectable(
      String name, MPLocationSettings settings);
  //endregion
}
