part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// A route from a origin to a destination broken up into [MPRouteLeg] [legs]
class MPRoute extends MapsIndoorsObject {
  /// The [legs] the route consists of
  final List<MPRouteLeg>? legs;

  /// The [copyrights] for this route, if any
  final String? copyrights;

  /// A [summary] of the route
  final String? summary;

  /// Any [warnings] issued for any paths on the route
  final List<String>? warnings;

  /// All [restrictions] in place for the route
  final List<String>? restrictions;

  /// The outer [bounds] of the route
  final MPBounds? bounds;

  final List<int>? orderedStopIndexes;

  /// Converts the [MPRoute] to a JSON representation that can be parsed by the MapsIndoors Platform SDK
  @override
  Map<String, dynamic> toJson() {
    var jsonLegs = legs?.map((e) => e.toJson()).toList();
    return {
      "legs": jsonLegs,
      "copyrights": copyrights,
      "summary": summary,
      "warnings": warnings,
      "restrictions": restrictions,
      "bounds": bounds?.toJson(),
      "ordered_stop_indexes": orderedStopIndexes,
    };
  }

  /// Attempts to build a [MPRoute] from a JSON object, this method will decode the object if needed
  static MPRoute? fromJson(json) => json != null && json != "null"
      ? MPRoute._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPRoute._fromJson(data)
      : copyrights = data["copyrights"],
        summary = data["summary"],
        warnings = convertJsonArray<String>(data["warnings"]),
        restrictions = convertJsonArray<String>(data["restrictions"]),
        bounds = null,
        orderedStopIndexes =
            convertJsonArray<int>(data["ordered_stop_indexes"] ?? []),
        legs = _convertLegs(data["legs"]);

  static List<MPRouteLeg>? _convertLegs(dynamic data) {
    if (data != null) {
      var jsonRouteLegs = convertJsonArray(data);
      var routeLegs = List<MPRouteLeg?>.generate(jsonRouteLegs.length,
          (index) => MPRouteLeg.fromJson(jsonRouteLegs[index]));
      routeLegs.removeWhere((element) => element == null);
      return routeLegs.cast<MPRouteLeg>();
    }
    return null;
  }
}
