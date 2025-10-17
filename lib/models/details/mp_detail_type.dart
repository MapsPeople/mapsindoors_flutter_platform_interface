part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Enum representing the type of detail for an additional detail associated with a MapIndoors entity.
enum MPDetailType {
  /// A textual detail type.
  text("text"),

  /// A phone number detail type.
  phone("phone"),

  /// A URL detail type.
  url("url"),

  /// An email detail type.
  email("email"),

  /// The opening hours detail type.
  openingHours("openinghours");

  final String type;
  const MPDetailType(this.type);

  dynamic toJson() => type;

  /// Parses the value of the enum
  static MPDetailType fromString(String value) {
    switch (value) {
      case "text":
        return MPDetailType.text;
      case "phone":
        return MPDetailType.phone;
      case "url":
        return MPDetailType.url;
      case "email":
        return MPDetailType.email;
      case "openinghours":
        return MPDetailType.openingHours;
      default:
        throw ArgumentError(
            "A MPDetailType scheme does not exist for the value $value");
    }
  }
}
