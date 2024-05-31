part of 'package:mapsindoors_platform_interface/platform_library.dart';

enum MPIconPlacement {
  center("CENTER"),
  above("ABOVE"),
  below("BELOW"),
  left("LEFT"),
  right("RIGHT");

  final String value;
  const MPIconPlacement(this.value);

  dynamic toJson() => value;

  /// Parses the value of the enum
  static MPIconPlacement fromValue(String value) {
    switch (value) {
      case "CENTER":
        return MPIconPlacement.center;
      case "ABOVE":
        return MPIconPlacement.above;
      case "BELOW":
        return MPIconPlacement.below;
      case "LEFT":
        return MPIconPlacement.left;
      case "RIGHT":
        return MPIconPlacement.right;
      default:
        throw ArgumentError(
            "A MPIconPlacement scheme does not exist for the value $value");
    }
  }
}
