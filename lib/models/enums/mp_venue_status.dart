part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Base type of a [MPLocation]
enum MPVenueStatus {
  loading,
  unavailable,
  loaded,
  failed,
  noVenue;

  static MPVenueStatus fromStringValue(String value) {
    switch (value) {
      case "LOADING":
        return loading;
      case "UNAVAILABLE":
        return unavailable;
      case "LOADED":
        return loaded;
      case "FAILED":
        return failed;
      case "NO_VENUE":
        return noVenue;
      default:
        throw ArgumentError(
            "A MPVenueStatus scheme does not exist for the value $value");
    }
  }
}
