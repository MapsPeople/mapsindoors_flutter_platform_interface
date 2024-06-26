part of 'package:mapsindoors_platform_interface/platform_library.dart';

abstract class LocationPlatform extends PlatformInterface {
  /// Constructs a MapsindoorsPlatform.
  LocationPlatform() : super(token: _token);

  static final Object _token = Object();

  static LocationPlatform _instance = MethodChannelLocation();

  /// The default instance of [LocationPlatform] to use.
  ///
  /// Defaults to [MethodChannelLocation].
  static LocationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LocationPlatform] when
  /// they register themselves.
  static set instance(LocationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> setLocationSettingsSelectable(
      MPLocationId id, MPLocationSettings settings);
}
