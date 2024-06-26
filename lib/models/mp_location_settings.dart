part of 'package:mapsindoors_platform_interface/platform_library.dart';

class MPLocationSettings extends MapsIndoorsObject {
  bool? selectable;

  MPLocationSettings({required this.selectable});

  static MPLocationSettings? fromJson(json) => json != null && json != "null"
      ? MPLocationSettings._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPLocationSettings._fromJson(data) : selectable = data["selectable"];

  @override
  Map<String, dynamic> toJson() {
    return {
      'selectable': selectable,
    };
  }
}
