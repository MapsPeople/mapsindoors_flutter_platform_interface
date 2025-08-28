part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// An object that governs solution level settings such as:
/// <ul>
///     <li>Marker clustering</li>
///     <li>Marker collision handling</li>
///     <li>Main Display Rule</li>
///     <li>[MPSettings3D]</li>
/// </ul>
class MPSolutionConfig {
  /// Settings related to 3D rendering
  final MPSettings3D settings3D;
  late MPCollisionHandling? _collisionHandling;
  late bool? _enableClustering;
  late MPLocationSettings? _locationSettings;
  late num? _automatedZoomLimit;

  /// Attempts to build a [MPSolutionConfig] from a JSON object, this method will decode the object if needed
  static MPSolutionConfig? fromJson(json) => json != null && json != "null"
      ? MPSolutionConfig._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPSolutionConfig._fromJson(data)
      : settings3D = MPSettings3D.fromJson(data["settings3D"])!,
        _enableClustering = data["enableClustering"],
        _locationSettings =
            MPLocationSettings.fromJson(data["locationSettings"]),
        _automatedZoomLimit = data["automatedZoomLimit"] {
    if (data["collisionHandling"] is int) {
      _collisionHandling =
          MPCollisionHandling.fromValue(data["collisionHandling"]);
    } else {
      _collisionHandling =
          MPCollisionHandling.fromValue(int.parse(data["collisionHandling"]));
    }
  }

  /// Get whether clustering is enabled
  bool? get enableClustering => _enableClustering;

  /// Set whether clustering is enabled
  set enableClustering(bool? enable) {
    if (enable != null) {
      _enableClustering = enable;
      UtilPlatform.instance.setEnableClustering(enable);
    }
  }

  /// Get the type of [collisionHandling] that is enabled
  MPCollisionHandling? get collisionHandling => _collisionHandling;

  /// Set the type of [collisionHandling] that is enabled
  set collisionHandling(MPCollisionHandling? handling) {
    if (handling != null) {
      _collisionHandling = handling;
      UtilPlatform.instance.setCollisionHandling(handling);
    }
  }

  bool? get selectable => _locationSettings?.selectable;

  set selectable(bool? selectable) {
    _locationSettings?.selectable = selectable;
    _locationSettings ??= MPLocationSettings(selectable: selectable);
    UtilPlatform.instance.setLocationSettings(_locationSettings!);
  }

  /// Get the automated zoom limit
  num? get automatedZoomLimit => _automatedZoomLimit;

  /// Set the automated zoom limit
  set automatedZoomLimit(num? limit) {
    _automatedZoomLimit = limit;
    UtilPlatform.instance.setAutomatedZoomLimit(limit);
  }
}
