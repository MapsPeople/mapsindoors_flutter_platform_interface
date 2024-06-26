part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A leg of a [MPRoute] is defined as all steps between any context shifts (entering/exiting buildings, changing floors)
/// A leg is comprised of a list of [steps] as well as a [startLocation] and an [endLocation]
class MPRouteLeg extends MapsIndoorsObject {
  /// The start address of the leg
  final String? startAddress;

  /// The end address of the leg
  final String? endAddress;

  /// The start coordinate of the leg
  final MPRouteCoordinate? startLocation;

  /// The end coordinate of the lg
  final MPRouteCoordinate? endLocation;

  /// The [steps] the leg consists of
  final List<MPRouteStep>? steps;

  /// The distance of the leg
  final MPRouteProperty? distance;

  /// The expected time it takes to traverse
  final MPRouteProperty? duration;

  /// The reason for the start of the leg
  final String? legStartReason;

  /// The reason for the end of the leg
  final String? legEndReason;

  /// The stop index of the leg
  final num? stopIndex;

  /// Converts the [MPRouteLeg] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    var jsonMPRouteSteps = steps?.map((e) => e.toJson()).toList();
    return {
      "start_address": startAddress,
      "end_address": endAddress,
      "start_location": startLocation?.toJson(),
      "end_location": endLocation?.toJson(),
      "steps": jsonMPRouteSteps,
      "distance": distance?.toJson(),
      "duration": duration?.toJson(),
      "leg_start_reason": legStartReason,
      "leg_end_reason": legEndReason,
      "stop_index": stopIndex,
    };
  }

  /// Attempts to build a [MPRouteLeg] from a JSON object, this method will decode the object if needed
  static MPRouteLeg? fromJson(json) => json != null && json != "null"
      ? MPRouteLeg._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPRouteLeg._fromJson(data)
      : startAddress = data["start_address"],
        endAddress = data["end_address"],
        startLocation = MPRouteCoordinate.fromJson(data["start_location"]),
        endLocation = MPRouteCoordinate.fromJson(data["end_location"]),
        steps = _convertSteps(data["steps"]),
        distance = MPRouteProperty.fromJson(data["distance"]),
        duration = MPRouteProperty.fromJson(data["duration"]),
        legStartReason = data["leg_start_reason"],
        legEndReason = data["leg_end_reason"],
        stopIndex = data["stop_index"];

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
}
