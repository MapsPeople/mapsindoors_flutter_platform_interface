part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A step of a [MPRoute], the step is usually contained in a [MPRouteLeg]
class MPRouteStep extends MapsIndoorsObject {
  /// The [distance] of the step
  final MPRouteProperty? distance;

  /// The estimated [duration] of the step
  final MPRouteProperty? duration;

  /// The origin of the step
  final MPRouteCoordinate? startLocation;

  /// The destination of the step
  final MPRouteCoordinate? endLocation;

  /// The coordinates the step is made up of
  final List<MPRouteCoordinate>? geometry;

  /// The type of [MPHighway] of the step
  final String? highway;

  /// Some [abutters] set on the step
  final String? abutters;

  /// The step [maneuver] embedded in HTML
  final String? htmlInstructions;

  /// The steps' [maneuver], eg. "Straight", "Turn lef"
  final String? maneuver;

  /// How the step is traversed
  final String? travelMode;

  /// A list of substeps if any
  final List<MPRouteStep>? steps;

  /// A list of modes it is possible to travel the step with (eg. a bike path can both be walked on, as well as biked on)
  final List<String>? availableTravelModes;

  /// Converts the [MPRouteStep] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    var jsonRouteSteps = steps?.map((e) => e.toJson()).toList();
    var jsonGeometry = geometry?.map((e) => e.toJson()).toList();
    return {
      "distance": distance?.toJson(),
      "duration": duration?.toJson(),
      "start_location": startLocation?.toJson(),
      "end_location": endLocation?.toJson(),
      "geometry": jsonGeometry,
      "highway": highway,
      "abutters": abutters,
      "html_instructions": htmlInstructions,
      "maneuver": maneuver,
      "travel_mode": travelMode,
      "steps": jsonRouteSteps,
      "available_travel_modes": availableTravelModes,
    };
  }

  /// Attempts to build a [MPRouteStep] from a JSON object, this method will decode the object if needed
  static MPRouteStep? fromJson(json) => json != null && json != "null"
      ? MPRouteStep._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPRouteStep._fromJson(data)
      : distance = MPRouteProperty.fromJson(data["distance"]),
        duration = MPRouteProperty.fromJson(data["duration"]),
        startLocation = MPRouteCoordinate.fromJson(data["start_location"]),
        endLocation = MPRouteCoordinate.fromJson(data["end_location"]),
        highway = (data["highway"] == null)
            ? null
            : (data["highway"] is String)
                ? data["highway"]
                : data["highway"]["value"],
        abutters = data["abutters"],
        htmlInstructions = data["html_instructions"],
        maneuver = data["maneuver"],
        travelMode = data["travel_mode"],
        availableTravelModes =
            convertJsonArray<String>(data["available_travel_modes"] ?? []),
        steps = _convertSteps(data["steps"]),
        geometry = _convertGeometry(data["geometry"]);

  static List<MPRouteStep>? _convertSteps(dynamic data) {
    if (data != null) {
      var jsonRouteSteps = convertJsonArray(data);
      var routeSteps = List<MPRouteStep?>.generate(jsonRouteSteps.length,
          (index) => MPRouteStep.fromJson(jsonRouteSteps[index]));
      routeSteps.removeWhere((element) => element == null);
      return routeSteps.cast<MPRouteStep>();
    }
    return null;
  }

  static List<MPRouteCoordinate>? _convertGeometry(dynamic data) {
    if (data != null) {
      var jsonGeometry = convertJsonArray(data);
      var routeGeometry = List<MPRouteCoordinate?>.generate(jsonGeometry.length,
          (index) => MPRouteCoordinate.fromJson(jsonGeometry[index]));
      routeGeometry.removeWhere((element) => element == null);
      return routeGeometry.cast<MPRouteCoordinate>();
    }
    return null;
  }
}
