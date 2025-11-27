import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';

/// Test suite for [MethodChannelDirectionsRenderer] platform interface implementation.
///
/// This test suite validates the functionality of the MapsIndoors DirectionsRenderer
/// platform methods, including route rendering, polyline animation, camera controls,
/// leg navigation, and event handling.
///
/// Tests use mock method channels to simulate platform responses and verify
/// proper argument passing and result handling.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MethodChannelDirectionsRenderer platform;
  late MockMethodChannel mockMethodChannel;

  // Test data constants
  const testLegIndex = 2;
  const testFloorIndex = 1;
  const testDurationMs = 3000;
  const testShow = true;
  const testAnimated = true;
  const testRepeating = false;

  // Color constants for testing
  final testForegroundColor = Color.fromRGBO(255, 0, 0, 1.0); // Red
  final testBackgroundColor = Color.fromRGBO(0, 0, 255, 1.0); // Blue

  // Reusable test objects
  final testRoute = MPRoute.fromJson({
    "legs": [
      {
        "duration": {"value": 300, "text": "5 min", "time_zone": null},
        "distance": {"value": 150, "text": "150 m", "time_zone": null},
        "startAddress": "Start Location",
        "endAddress": "End Location",
        "startLocation": {
          "lat": 57.0580,
          "lng": 9.9501,
          "zLevel": 0,
          "floorName": "Ground Floor"
        },
        "endLocation": {
          "lat": 57.0590,
          "lng": 9.9511,
          "zLevel": 0,
          "floorName": "Ground Floor"
        },
        "steps": []
      }
    ]
  });

  // Mock stop icons map for testing
  final testStopIcons = <num, MPRouteStopIconConfigInterface>{
    0: MockRouteStopIconConfig("start_icon"),
    1: MockRouteStopIconConfig("end_icon"),
  };

  final testDefaultIcon = MockRouteStopIconConfig("default_icon");

  // Helper functions
  void expectMethodCall(String methodName, [Map<String, dynamic>? arguments]) {
    expect(mockMethodChannel.invokedMethods.last, methodName);
    if (arguments != null) {
      expect(mockMethodChannel.lastArguments, arguments);
    }
  }

  setUp(() {
    platform = MethodChannelDirectionsRenderer();
    mockMethodChannel = MockMethodChannel();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('DirectionsRendererMethodChannel'),
      (MethodCall call) async {
        mockMethodChannel.invokedMethods.add(call.method);
        // Store arguments as-is without casting in setup
        mockMethodChannel.lastArguments = call.arguments != null
            ? Map<String, dynamic>.from(call.arguments as Map)
            : null;

        switch (call.method) {
          case "DRE_clear":
            return null;

          case "DRE_nextLeg":
            return null;

          case "DRE_previousLeg":
            return null;

          case "DRE_setRoute":
            return null;

          case "DRE_setAnimatedPolyline":
            return null;

          case "DRE_setPolyLineColors":
            return null;

          case "DRE_selectLegIndex":
            return null;

          case "DRE_getSelectedLegFloorIndex":
            return testFloorIndex;

          case "DRE_setCameraAnimationDuration":
            return null;

          case "DRE_setCameraViewFitMode":
            return null;

          case "DRE_setOnLegSelectedListener":
            return null;

          case "DRE_showRouteLegButtons":
            return null;

          case "DRE_setDefaultRouteStopIcon":
            return null;

          default:
            fail('Unexpected method call: ${call.method}');
        }
      },
    );
  });

  group("Route Management", () {
    test("should clear route successfully", () async {
      // Act
      await platform.clear();

      // Assert
      expectMethodCall("DRE_clear");
    });

    test("should set route with stop icons successfully", () async {
      // Act
      await platform.setRoute(testRoute, testStopIcons);

      // Assert
      expectMethodCall("DRE_setRoute");
      expect(mockMethodChannel.lastArguments!["route"], isNotNull);
      expect(mockMethodChannel.lastArguments!["stopIcons"], isNotNull);

      // Verify stop icons structure
      final stopIcons = mockMethodChannel.lastArguments!["stopIcons"] as Map;
      expect(stopIcons.length, 2);
      expect(stopIcons[0], "start_icon");
      expect(stopIcons[1], "end_icon");
    });

    test("should set route without stop icons successfully", () async {
      // Act
      await platform.setRoute(testRoute, null);

      // Assert
      expectMethodCall("DRE_setRoute");
      expect(mockMethodChannel.lastArguments!["route"], isNotNull);
      expect(mockMethodChannel.lastArguments!["stopIcons"], isNull);
    });

    test("should set null route successfully", () async {
      // Act
      await platform.setRoute(null, null);

      // Assert
      expectMethodCall("DRE_setRoute");
      expect(mockMethodChannel.lastArguments!["route"], "null");
      expect(mockMethodChannel.lastArguments!["stopIcons"], isNull);
    });
  });

  group("Leg Navigation", () {
    test("should navigate to next leg successfully", () async {
      // Act
      await platform.nextLeg();

      // Assert
      expectMethodCall("DRE_nextLeg");
    });

    test("should navigate to previous leg successfully", () async {
      // Act
      await platform.previousLeg();

      // Assert
      expectMethodCall("DRE_previousLeg");
    });

    test("should select specific leg index successfully", () async {
      // Act
      await platform.selectLegIndex(testLegIndex);

      // Assert
      expectMethodCall("DRE_selectLegIndex", {"legIndex": testLegIndex});
    });

    test("should get selected leg floor index successfully", () async {
      // Act
      final result = await platform.getSelectedLegFloorIndex();

      // Assert
      expect(result, testFloorIndex);
      expectMethodCall("DRE_getSelectedLegFloorIndex");
    });

    test("should show route leg buttons correctly", () async {
      // Act
      await platform.showRouteLegButtons(testShow);

      // Assert
      expectMethodCall("DRE_showRouteLegButtons", {"show": testShow});
    });
  });

  group("Polyline Configuration", () {
    test("should set animated polyline with all parameters", () async {
      // Act
      await platform.setAnimatedPolyline(
          testAnimated, testRepeating, testDurationMs);

      // Assert
      expectMethodCall("DRE_setAnimatedPolyline", {
        "animated": testAnimated,
        "repeating": testRepeating,
        "durationMs": testDurationMs
      });
    });

    test("should set polyline colors correctly", () async {
      // Act
      await platform.setPolyLineColors(
          testForegroundColor, testBackgroundColor);

      // Assert
      expectMethodCall("DRE_setPolyLineColors", {
        "foreground": testForegroundColor.toRGBString(),
        "background": testBackgroundColor.toRGBString()
      });
    });
  });

  group("Camera Configuration", () {
    test("should set camera animation duration correctly", () async {
      // Act
      await platform.setCameraAnimationDuration(testDurationMs);

      // Assert
      expectMethodCall(
          "DRE_setCameraAnimationDuration", {"durationMs": testDurationMs});
    });

    test("should set camera view fit mode to north aligned", () async {
      // Act
      await platform.setCameraViewFitMode(MPCameraViewFitMode.northAligned);

      // Assert
      expectMethodCall("DRE_setCameraViewFitMode", {"cameraFitMode": 0});
    });

    test("should set camera view fit mode to first step aligned", () async {
      // Act
      await platform.setCameraViewFitMode(MPCameraViewFitMode.firstStepAligned);

      // Assert
      expectMethodCall("DRE_setCameraViewFitMode", {"cameraFitMode": 1});
    });

    test("should set camera view fit mode to start to end aligned", () async {
      // Act
      await platform
          .setCameraViewFitMode(MPCameraViewFitMode.startToEndAligned);

      // Assert
      expectMethodCall("DRE_setCameraViewFitMode", {"cameraFitMode": 2});
    });

    test("should set camera view fit mode to none", () async {
      // Act
      await platform.setCameraViewFitMode(MPCameraViewFitMode.none);

      // Assert
      expectMethodCall("DRE_setCameraViewFitMode", {"cameraFitMode": 3});
    });
  });

  group("Event Listeners", () {
    test("should set leg selected listener successfully", () async {
      bool listenerCalled = false;
      int? receivedLegIndex;

      // Arrange
      void testListener(int legIndex) {
        listenerCalled = true;
        receivedLegIndex = legIndex;
      }

      // Act
      await platform.setOnLegSelectedListener(testListener);

      // Assert
      expectMethodCall("DRE_setOnLegSelectedListener");

      // Note: We can't directly test the private _listenerHandler method,
      // but we can verify the listener is set up correctly
      expect(listenerCalled, false); // Should not be called yet
    });

    test("should handle null leg selected listener", () async {
      // Act
      await platform.setOnLegSelectedListener(null);

      // Assert
      expectMethodCall("DRE_setOnLegSelectedListener");
    });
  });

  group("Icon Configuration", () {
    test("should set default route stop icon successfully", () async {
      // Act
      await platform.setDefaultRouteStopIcon(testDefaultIcon);

      // Assert
      expectMethodCall("DRE_setDefaultRouteStopIcon", {"icon": "default_icon"});
    });
  });

  group("Edge Cases and Error Handling", () {
    test("should handle different animation durations", () async {
      const durations = [0, 1000, 5000, 10000];

      for (final duration in durations) {
        await platform.setAnimatedPolyline(true, false, duration);
        expectMethodCall("DRE_setAnimatedPolyline",
            {"animated": true, "repeating": false, "durationMs": duration});
      }
    });

    test("should handle different leg indices", () async {
      const indices = [0, 1, 5, 10];

      for (final index in indices) {
        await platform.selectLegIndex(index);
        expectMethodCall("DRE_selectLegIndex", {"legIndex": index});
      }
    });

    test("should handle different color combinations", () async {
      final colorPairs = [
        [
          Color.fromRGBO(255, 255, 255, 1.0),
          Color.fromRGBO(0, 0, 0, 1.0)
        ], // White/Black
        [
          Color.fromRGBO(0, 255, 0, 1.0),
          Color.fromRGBO(255, 0, 255, 1.0)
        ], // Green/Magenta
      ];

      for (final colors in colorPairs) {
        await platform.setPolyLineColors(colors[0], colors[1]);
        expectMethodCall("DRE_setPolyLineColors", {
          "foreground": colors[0].toRGBString(),
          "background": colors[1].toRGBString()
        });
      }
    });

    test("should handle all camera view fit modes", () async {
      const modes = [
        MPCameraViewFitMode.northAligned,
        MPCameraViewFitMode.firstStepAligned,
        MPCameraViewFitMode.startToEndAligned,
        MPCameraViewFitMode.none,
      ];
      const expectedValues = [0, 1, 2, 3];

      for (int i = 0; i < modes.length; i++) {
        await platform.setCameraViewFitMode(modes[i]);
        expectMethodCall(
            "DRE_setCameraViewFitMode", {"cameraFitMode": expectedValues[i]});
      }
    });

    test("should handle boolean variations for show route leg buttons",
        () async {
      // Test true
      await platform.showRouteLegButtons(true);
      expectMethodCall("DRE_showRouteLegButtons", {"show": true});

      // Test false
      await platform.showRouteLegButtons(false);
      expectMethodCall("DRE_showRouteLegButtons", {"show": false});
    });

    test("should handle animation parameter combinations", () async {
      final combinations = [
        [true, true, 2000],
        [true, false, 3000],
        [false, true, 1000],
        [false, false, 0],
      ];

      for (final combo in combinations) {
        await platform.setAnimatedPolyline(
            combo[0] as bool, combo[1] as bool, combo[2] as int);
        expectMethodCall("DRE_setAnimatedPolyline", {
          "animated": combo[0],
          "repeating": combo[1],
          "durationMs": combo[2]
        });
      }
    });
  });

  group("Special Methods", () {
    test("should handle useContentOfNearbyLocations as no-op", () async {
      // Act - This is currently a no-op method
      await platform.useContentOfNearbyLocations();

      // Assert - Method should complete without error
      // No method channel call is expected since it's a no-op
      expect(
          mockMethodChannel.invokedMethods.isEmpty ||
              !mockMethodChannel.invokedMethods
                  .contains("useContentOfNearbyLocations"),
          true);
    });
  });
}

/// Mock class to track method channel calls for testing
class MockMethodChannel {
  final List<String> invokedMethods = [];
  Map<String, dynamic>? lastArguments;
}

/// Mock implementation of MPRouteStopIconConfigInterface for testing
class MockRouteStopIconConfig implements MPRouteStopIconConfigInterface {
  final String iconPath;

  MockRouteStopIconConfig(this.iconPath);

  @override
  Uri getImage() => Uri.parse(iconPath);
}
