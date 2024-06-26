part of 'package:mapsindoors_platform_interface/platform_library.dart';

class MPPOIType extends MapsIndoorsObject {
  final String name;
  final String translatedName;
  late MPLocationSettings? _locationSettings;

  /// Attempts to build a [MPPOIType] from a JSON object, this method will decode the object if needed
  static MPPOIType? fromJson(json) => json != null && json != "null"
      ? MPPOIType._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPPOIType._fromJson(data)
      : name = data["name"],
        translatedName = data["translatedName"],
        _locationSettings =
            MPLocationSettings.fromJson(data["locationSettings"]);

  /// Get the location's settings object
  bool? get selectable => _locationSettings?.selectable;

  /// Set whether the location is selectable
  set selectable(bool? selectable) {
    _locationSettings?.selectable = selectable;
    _locationSettings ??= MPLocationSettings(selectable: selectable);
    UtilPlatform.instance
        .setTypeLocationSettingsSelectable(name, _locationSettings!);
  }

  /// Converts the [MPPOIType] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "translatedName": translatedName,
      "locationSettings": _locationSettings?.toJson(),
    };
  }
}
