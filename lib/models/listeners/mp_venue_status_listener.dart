part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Listens for camera events, eg. when the Camera starts or stops moving
typedef MPVenueStatusListener = void Function(
    String? venueId, MPVenueStatus status);
