part of 'package:mapsindoors_platform_interface/platform_library.dart';

abstract class DirectionsServicePlatform extends PlatformInterface {
  DirectionsServicePlatform() : super(token: _token);

  static final Object _token = Object();

  static DirectionsServicePlatform _instance = MethodChannelDirectionsService();

  static DirectionsServicePlatform get instance => _instance;

  static set instance(DirectionsServicePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> create();

  Future<void> addAvoidWayType(String wayType);

  Future<void> clearAvoidWayType();

  Future<void> addExcludeWayType(String wayType);

  Future<void> clearExcludeWayType();

  Future<void> setIsDeparture(bool isDeparture);

  Future<MPRoute> getRoute(MPPoint origin, MPPoint destination,
      List<MPPoint>? stops, bool? optimize);

  Future<void> setTravelMode(String travelMode);

  Future<void> setTime(int time);
}
