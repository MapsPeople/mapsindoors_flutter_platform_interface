part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Represents the opening hours for a location.
class MPOpeningHours extends MapsIndoorsObject {
  final MPWeeklyOpeningHours? standardOpeningHours;

  static MPOpeningHours? fromJson(json) => json != null && json != "null"
      ? MPOpeningHours._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPOpeningHours._fromJson(data)
      : standardOpeningHours =
            MPWeeklyOpeningHours.fromJson(data["standardOpeningHours"]);

  MPOpeningHours({
    this.standardOpeningHours,
  });

  @override
  String toString() {
    return standardOpeningHours?.toString() ??
        "No standard opening hours available";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "standardOpeningHours": standardOpeningHours?.toJson(),
    };
  }
}
