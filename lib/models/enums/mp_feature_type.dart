part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Features that can be disabled through MapControl
enum MPFeatureType {
  model2D(0),
  walls2D(1),
  model3D(2),
  walls3D(3),
  extrusion3D(4),
  extrudedBuildings(5);

  /// The integer representation of this handling preset
  final int value;
  const MPFeatureType(this.value);

  int toJson() => value;

  /// Parses the integer value of the enum
  static MPFeatureType fromValue(int value) {
    switch (value) {
      case 0:
        return MPFeatureType.model2D;
      case 1:
        return MPFeatureType.walls2D;
      case 2:
        return MPFeatureType.model3D;
      case 3:
        return MPFeatureType.walls3D;
      case 4:
        return MPFeatureType.extrusion3D;
      case 5:
        return MPFeatureType.extrudedBuildings;
      default:
        throw ArgumentError(
            "A MPFeatureType scheme does not exist for the value $value");
    }
  }
}
