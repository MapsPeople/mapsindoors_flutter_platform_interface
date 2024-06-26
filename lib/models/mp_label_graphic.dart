part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Represents a label graphic in the MapsIndoors platform.
/// A label graphic is used to display text on top of an image.
class MPLabelGraphic extends MapsIndoorsObject {
  /// The background image of the label graphic.
  final String backgroundImage;

  /// The content area of the label graphic, this is where the text can be drawn.
  final List<int> content;

  /// The stretchX values of the label graphic. These define where the graphic can be stretched horizontally.
  final List<List<int>> stretchX;

  /// The stretchY values of the label graphic. These define where the graphic can be stretched vertically.
  final List<List<int>> stretchY;

  /// Creates a new instance of [MPLabelGraphic].
  /// All parameters are required in order to create a cohesive graphic label.
  MPLabelGraphic(
      {required this.backgroundImage,
      required this.content,
      required this.stretchX,
      required this.stretchY});

  /// Attempts to parse an instance of [MPLabelGraphic] from a JSON object.
  static MPLabelGraphic? fromJson(json) => json != null && json != "null"
      ? MPLabelGraphic._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  /// Creates a new instance of [MPLabelGraphic] from a JSON object.
  MPLabelGraphic._fromJson(data)
      : backgroundImage = data["backgroundImage"],
        content = convertJsonArray<int>(data["content"]),
        stretchX = convertJson2dArray<int>(data["stretchX"]),
        stretchY = convertJson2dArray<int>(data["stretchY"]);

  /// Converts this instance of [MPLabelGraphic] to a JSON parseable object.
  @override
  Map<String, dynamic> toJson() {
    return {
      'backgroundImage': backgroundImage,
      'content': content,
      'stretchX': stretchX,
      'stretchY': stretchY,
    };
  }
}
