part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Possible events that a [MPCameraEventListener] can receive
enum MPCameraEvent {
  finished,
  cancelled,
  moveStartedApiAnimation,
  moveStartedDeveloperAnimation,
  moveStartedGesture,
  onMove,
  moveCancelled,
  idle
}
