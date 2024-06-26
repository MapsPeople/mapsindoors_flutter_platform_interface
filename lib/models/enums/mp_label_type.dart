part of 'package:mapsindoors_platform_interface/platform_library.dart';

enum MPLabelType {
  flat("FLAT"),
  graphic("GRAPHIC"),
  floating("FLOATING");

  final String value;
  const MPLabelType(this.value);

  dynamic toJson() => value;

  /// Parses MPLabelType value of the enum
  static MPLabelType fromValue(String value) {
    switch (value) {
      case "FLAT":
        return MPLabelType.flat;
      case "GRAPHIC":
        return MPLabelType.graphic;
      case "FLOATING":
        return MPLabelType.floating;
      default:
        throw ArgumentError(
            "A MPLabelType scheme does not exist for the value $value");
    }
  }
}
