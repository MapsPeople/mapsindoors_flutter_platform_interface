part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// An implementation of [LocationPlatform] that uses method channels.
class MethodChannelLocation extends LocationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final locationMethodChannel = const MethodChannel('LocationMethodChannel');

  @override
  Future<void> setLocationSettingsSelectable(
      MPLocationId id, MPLocationSettings settings) {
    return locationMethodChannel.invokeMethod(
        "LOC_setLocationSettingsSelectable",
        {"id": id.value, "settings": jsonEncode(settings.toJson())});
  }
}
