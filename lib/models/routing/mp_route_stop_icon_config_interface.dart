part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A class that creates a route stop icon for the Directions Renderer.
class MPRouteStopIconConfig extends MapsIndoorsObject
    implements MPRouteStopIconConfigInterface {
  /// Whether the icon should be numbered.
  final bool numbered;

  /// The label for the icon.
  final String label;

  /// The color for the icon. must be in hex format. eg. #FF0000
  final Color color;

  /// Creates a new instance of [MPRouteStopIconConfig].
  MPRouteStopIconConfig({
    required this.numbered,
    required this.label,
    required this.color,
  });

  /// INTERAL
  @override
  Uri getImage() {
    return Uri(
        scheme: "mapsindoors", host: "mapspeople", path: jsonEncode(toJson()));
  }

  /// INTERAL - This encoding should only be used to create a URI for the image.
  @override
  Map<String, dynamic> toJson() {
    return {
      "numbered": numbered,
      "label": label,
      "color": color.toRGBString(),
    };
  }
}
