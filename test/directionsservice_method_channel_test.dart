import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';

/// Test suite for [MethodChannelDirectionsService] platform interface implementation.
///
/// This test suite validates the functionality of the MapsIndoors DirectionsService
/// platform methods, including route calculation, travel mode configuration,
/// way type management, and time/departure settings.
///
/// Tests use mock method channels to simulate platform responses and verify
/// proper argument passing and result handling.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MethodChannelDirectionsService platform;
  late MockMethodChannel mockMethodChannel;

  // Test data constants
  const testWayType = "stairs";
  const testTravelMode = "walking";
  const testTime = 1638360000;
  const testDeparture = true;
  const testOptimize = true;

  // Reusable test objects
  final testOrigin =
      MPPoint.withCoordinates(latitude: 57.0580, longitude: 9.9501);
  final testDestination =
      MPPoint.withCoordinates(latitude: 57.0590, longitude: 9.9511);
  final testStops = [
    MPPoint.withCoordinates(latitude: 57.0585, longitude: 9.9506),
    MPPoint.withCoordinates(latitude: 57.0588, longitude: 9.9508),
  ];

  final testRouteJson = {
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
  };

  final testErrorJson = {"code": 404, "message": "No route found"};

  // Helper functions
  void expectMethodCall(String methodName, [Map<String, dynamic>? arguments]) {
    expect(mockMethodChannel.invokedMethods.last, methodName);
    if (arguments != null) {
      expect(mockMethodChannel.lastArguments, arguments);
    }
  }

  setUp(() {
    platform = MethodChannelDirectionsService();
    mockMethodChannel = MockMethodChannel();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('DirectionsServiceMethodChannel'),
      (MethodCall call) async {
        mockMethodChannel.invokedMethods.add(call.method);
        // Store arguments as-is without casting in setup
        mockMethodChannel.lastArguments = call.arguments != null
            ? Map<String, dynamic>.from(call.arguments as Map)
            : null;

        switch (call.method) {
          case "DSE_create":
            return null;

          case "DSE_addAvoidWayType":
            return null;

          case "DSE_clearAvoidWayType":
            return null;

          case "DSE_setIsDeparture":
            return null;

          case "DSE_getRoute":
            // Return successful route response
            return <String, dynamic>{"route": testRouteJson, "error": null};

          case "DSE_getRoute_withError":
            // Return error response for error testing
            return <String, dynamic>{"route": null, "error": testErrorJson};

          case "DSE_setTravelMode":
            return null;

          case "DSE_setTime":
            return null;

          case "DSE_addExcludeWayType":
            return null;

          case "DSE_clearExcludeWayType":
            return null;

          default:
            fail('Unexpected method call: ${call.method}');
        }
      },
    );
  });

  group("DirectionsService Initialization", () {
    test("should create directions service successfully", () async {
      // Act
      await platform.create();

      // Assert
      expectMethodCall("DSE_create");
    });
  });

  group("Way Type Management - Avoid", () {
    test("should add avoid way type with correct parameters", () async {
      // Act
      await platform.addAvoidWayType(testWayType);

      // Assert
      expectMethodCall("DSE_addAvoidWayType", {"wayType": testWayType});
    });

    test("should clear avoid way types successfully", () async {
      // Act
      await platform.clearAvoidWayType();

      // Assert
      expectMethodCall("DSE_clearAvoidWayType");
    });
  });

  group("Way Type Management - Exclude", () {
    test("should add exclude way type with correct parameters", () async {
      // Act
      await platform.addExcludeWayType(testWayType);

      // Assert
      expectMethodCall("DSE_addExcludeWayType", {"wayType": testWayType});
    });

    test("should clear exclude way types successfully", () async {
      // Act
      await platform.clearExcludeWayType();

      // Assert
      expectMethodCall("DSE_clearExcludeWayType");
    });
  });

  group("Travel Configuration", () {
    test("should set departure flag correctly", () async {
      // Act
      await platform.setIsDeparture(testDeparture);

      // Assert
      expectMethodCall("DSE_setIsDeparture", {"isDeparture": testDeparture});
    });

    test("should set travel mode correctly", () async {
      // Act
      await platform.setTravelMode(testTravelMode);

      // Assert
      expectMethodCall("DSE_setTravelMode", {"travelMode": testTravelMode});
    });

    test("should set time correctly", () async {
      // Act
      await platform.setTime(testTime);

      // Assert
      expectMethodCall("DSE_setTime", {"time": testTime});
    });
  });

  group("Route Calculation", () {
    test("should calculate route with origin and destination successfully",
        () async {
      // Act
      final result =
          await platform.getRoute(testOrigin, testDestination, null, null);

      // Assert
      expect(result, isNotNull);
      expect(result.legs, isNotNull);
      expect(result.legs!.length, 1);

      // Verify route leg contains expected data
      final firstLeg = result.legs!.first;
      expect(firstLeg.distance, isNotNull);
      expect(firstLeg.duration, isNotNull);

      expectMethodCall("DSE_getRoute");
      expect(mockMethodChannel.lastArguments!["origin"], isNotNull);
      expect(mockMethodChannel.lastArguments!["destination"], isNotNull);
      expect(mockMethodChannel.lastArguments!["stops"], isNull);
      expect(mockMethodChannel.lastArguments!["optimize"], isNull);
    });

    test("should calculate route with stops and optimization", () async {
      // Act
      final result = await platform.getRoute(
          testOrigin, testDestination, testStops, testOptimize);

      // Assert
      expect(result, isNotNull);
      expect(result.legs, isNotNull);
      expect(result.legs!.length, 1);

      // Verify route leg contains expected data
      final firstLeg = result.legs!.first;
      expect(firstLeg.distance, isNotNull);
      expect(firstLeg.duration, isNotNull);

      expectMethodCall("DSE_getRoute");
      expect(mockMethodChannel.lastArguments!["origin"], isNotNull);
      expect(mockMethodChannel.lastArguments!["destination"], isNotNull);
      expect(mockMethodChannel.lastArguments!["stops"], isNotNull);
      expect(mockMethodChannel.lastArguments!["optimize"], testOptimize);

      // Verify stops array
      final stops = mockMethodChannel.lastArguments!["stops"] as List;
      expect(stops.length, 2);
    });

    test("should handle route calculation errors correctly", () async {
      // Arrange - Override the mock to return error
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('DirectionsServiceMethodChannel'),
        (MethodCall call) async {
          if (call.method == "DSE_getRoute") {
            return <String, dynamic>{"route": null, "error": testErrorJson};
          }
          return null;
        },
      );

      // Act & Assert
      expect(() => platform.getRoute(testOrigin, testDestination, null, null),
          throwsA(isA<MPError>()));
    });

    test("should handle missing route and error response", () async {
      // Arrange - Override the mock to return neither route nor error
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('DirectionsServiceMethodChannel'),
        (MethodCall call) async {
          if (call.method == "DSE_getRoute") {
            return <String, dynamic>{"route": null, "error": null};
          }
          return null;
        },
      );

      // Act & Assert
      expect(() => platform.getRoute(testOrigin, testDestination, null, null),
          throwsA(isA<MPError>()));
    });
  });

  group("Edge Cases and Error Handling", () {
    test("should handle null stops list in route calculation", () async {
      // Act
      final result =
          await platform.getRoute(testOrigin, testDestination, null, false);

      // Assert
      expect(result, isNotNull);
      expectMethodCall("DSE_getRoute");
      expect(mockMethodChannel.lastArguments!["stops"], isNull);
      expect(mockMethodChannel.lastArguments!["optimize"], false);
    });

    test("should handle empty stops list in route calculation", () async {
      // Act
      final result =
          await platform.getRoute(testOrigin, testDestination, [], true);

      // Assert
      expect(result, isNotNull);
      expectMethodCall("DSE_getRoute");

      final stops = mockMethodChannel.lastArguments!["stops"] as List;
      expect(stops.isEmpty, true);
    });

    test("should handle different way type formats", () async {
      const specialWayType = "elevator_up";

      // Test avoid way type
      await platform.addAvoidWayType(specialWayType);
      expectMethodCall("DSE_addAvoidWayType", {"wayType": specialWayType});

      // Test exclude way type
      await platform.addExcludeWayType(specialWayType);
      expectMethodCall("DSE_addExcludeWayType", {"wayType": specialWayType});
    });

    test("should handle different travel modes", () async {
      const modes = ["walking", "driving", "transit", "bicycling"];

      for (final mode in modes) {
        await platform.setTravelMode(mode);
        expectMethodCall("DSE_setTravelMode", {"travelMode": mode});
      }
    });

    test("should handle different departure configurations", () async {
      // Test departure = true
      await platform.setIsDeparture(true);
      expectMethodCall("DSE_setIsDeparture", {"isDeparture": true});

      // Test departure = false
      await platform.setIsDeparture(false);
      expectMethodCall("DSE_setIsDeparture", {"isDeparture": false});
    });

    test("should handle various time values", () async {
      const timeValues = [
        0,
        1638360000,
        2147483647
      ]; // Min, normal, max int values

      for (final time in timeValues) {
        await platform.setTime(time);
        expectMethodCall("DSE_setTime", {"time": time});
      }
    });
  });
}

/// Mock class to track method channel calls for testing
class MockMethodChannel {
  final List<String> invokedMethods = [];
  Map<String, dynamic>? lastArguments;
}
