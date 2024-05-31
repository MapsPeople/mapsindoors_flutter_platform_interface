part of 'package:mapsindoors_platform_interface/platform_library.dart';

enum MPBadgePosition {
  bottomRight("BOTTOM_RIGHT"),
  bottomLeft("BOTTOM_LEFT"),
  topRight("TOP_RIGHT"),
  topLeft("TOP_LEFT");

  final String position;
  const MPBadgePosition(this.position);

  dynamic toJson() => position;

  /// Parses the value of the enum
  static MPBadgePosition fromValue(String value) {
    switch (value) {
      case "BOTTOM_RIGHT":
        return MPBadgePosition.bottomRight;
      case "BOTTOM_LEFT":
        return MPBadgePosition.bottomLeft;
      case "TOP_RIGHT":
        return MPBadgePosition.topRight;
      case "TOP_LEFT":
        return MPBadgePosition.topLeft;
      default:
        throw ArgumentError(
            "A MPBadgePosition scheme does not exist for the value $value");
    }
  }
}
