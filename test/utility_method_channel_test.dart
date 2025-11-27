import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';

/// Test suite for [MethodChannelUtil] platform interface implementation.
///
/// This test suite validates the functionality of the MapsIndoors platform
/// utility methods, including geometry operations, solution settings,
/// and location type configurations.
///
/// Tests use mock method channels to simulate platform responses and verify
/// proper argument passing and result handling.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MethodChannelUtil platform = MethodChannelUtil();
  const MethodChannel channel = MethodChannel('UtilMethodChannel');

  // Test data constants
  const String testVenueId = "venue123";
  const String testVenueId2 = "venue456";
  const String testLocationId = "location789";
  const String expectedVersion = "1.0.0";
  const String expectedUrl = "https://mapsclient.com/venue456/location789";
  const double testAngle = 45.5;
  const double testDistance = 123.45;
  const double testArea = 2500.75;
  const double testEdgeDistance = 15.25;
  const double testOpacity = 0.8;
  const double testWallOpacity = 0.6;
  const double testZoomLimit = 18.5;

  final testPoint1 = MPPoint.withCoordinates(latitude: 57.0, longitude: 9.0);
  final testPoint2 = MPPoint.withCoordinates(latitude: 57.1, longitude: 9.1);
  final testPolygonCoordinates = [
    [
      [9.0, 57.0],
      [9.1, 57.0],
      [9.1, 57.1],
      [9.0, 57.1],
      [9.0, 57.0]
    ]
  ];
  final testBbox = [9.0, 57.0, 9.1, 57.1];

  // Helper functions
  MPPolygon createTestPolygon() {
    return MPPolygon.fromJson({
      "coordinates": testPolygonCoordinates,
      "bbox": testBbox,
      "type": "Polygon"
    })!;
  }

  MPPoint createTestPointInside() {
    return MPPoint.withCoordinates(latitude: 57.05, longitude: 9.05);
  }

  MPPoint createTestPointOutside() {
    return MPPoint.withCoordinates(latitude: 58.0, longitude: 10.0);
  }

  MPLocationSettings createTestLocationSettings({bool selectable = true}) {
    return MPLocationSettings(selectable: selectable);
  }

  void expectNonNullResult<T>(T? result, T expected, [String? reason]) {
    expect(result, isNotNull, reason: reason ?? "Expected non-null result");
    expect(result!, expected);
  }

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      switch (call.method) {
        case "UTL_getPlatformVersion":
          return Future(() => "1.0.0");
        case "UTL_venueHasGraph":
          {
            expect(call.arguments["id"], "venue123");
            return Future(() => true);
          }
        case "UTL_pointAngleBetween":
          {
            expect(call.arguments["it"], isNotNull);
            expect(call.arguments["other"], isNotNull);
            return Future(() => 45.5);
          }
        case "UTL_pointDistanceTo":
          {
            expect(call.arguments["it"], isNotNull);
            expect(call.arguments["other"], isNotNull);
            return Future(() => 123.45);
          }
        case "UTL_geometryIsInside":
          {
            expect(call.arguments["it"], isNotNull);
            expect(call.arguments["point"], isNotNull);
            return Future(() => true);
          }
        case "UTL_geometryArea":
          {
            expect(call.arguments["geometry"], isNotNull);
            return Future(() => 2500.75);
          }
        case "UTL_polygonDistToClosestEdge":
          {
            expect(call.arguments["it"], isNotNull);
            expect(call.arguments["point"], isNotNull);
            return Future(() => 15.25);
          }
        case "UTL_parseMapClientUrl":
          {
            expect(call.arguments["venueId"], "venue456");
            expect(call.arguments["locationId"], "location789");
            return Future(() => "https://mapsclient.com/venue456/location789");
          }
        case "UTL_setCollisionHandling":
          {
            expect(call.arguments["handling"], 1);
            return Future(() => null);
          }
        case "UTL_setEnableClustering":
          {
            expect(call.arguments["enable"], true);
            return Future(() => null);
          }
        case "UTL_setExtrusionOpacity":
          {
            expect(call.arguments["opacity"], 0.8);
            return Future(() => null);
          }
        case "UTL_setWallOpacity":
          {
            expect(call.arguments["opacity"], 0.6);
            return Future(() => null);
          }
        case "UTL_setLocationSettings":
          {
            expect(call.arguments["locationSettings"], isNotNull);
            return Future(() => null);
          }
        case "UTL_setTypeLocationSettingsSelectable":
          {
            expect(call.arguments["name"], "room");
            expect(call.arguments["settings"], isNotNull);
            return Future(() => null);
          }
        case "UTL_setAutomatedZoomLimit":
          {
            expect(call.arguments["limit"], 18.5);
            return Future(() => null);
          }
      }
      return null;
    });
  });

  group("Platform Utility Methods", () {
    test("should return correct platform version", () async {
      // Act
      final result = await platform.getPlatformVersion();

      // Assert
      expectNonNullResult(result, expectedVersion,
          "Platform version should return expected value");
    });

    test("should verify venue graph availability", () async {
      // Act
      final result = await platform.venueHasGraph(testVenueId);

      // Assert
      expectNonNullResult(result, true, "Venue should have graph available");
    });
  });

  group("Geometry Operations", () {
    test("should calculate angle between two points correctly", () async {
      // Act
      final result = await platform.pointAngleBetween(testPoint1, testPoint2);

      // Assert
      expectNonNullResult(
          result, testAngle, "Angle calculation should return expected value");
    });

    test("should calculate distance between two points correctly", () async {
      // Act
      final result = await platform.pointDistanceTo(testPoint1, testPoint2);

      // Assert
      expectNonNullResult(result, testDistance,
          "Distance calculation should return expected value");
    });

    test("should correctly determine if point is inside geometry", () async {
      // Arrange
      final polygon = createTestPolygon();
      final pointInside = createTestPointInside();

      // Act
      final result = await platform.geometryIsInside(polygon, pointInside);

      // Assert
      expectNonNullResult(
          result, true, "Point inside geometry should return true");
    });

    test("should calculate polygon area correctly", () async {
      // Arrange
      final polygon = createTestPolygon();

      // Act
      final result = await platform.geometryArea(polygon);

      // Assert
      expectNonNullResult(result, testArea,
          "Polygon area calculation should return expected value");
    });

    test("geometryGetSquaredDistanceToClosestEdge", () async {
      var polygon = MPPolygon.fromJson({
        "coordinates": [
          [
            [9.0, 57.0],
            [9.1, 57.0],
            [9.1, 57.1],
            [9.0, 57.1],
            [9.0, 57.0]
          ]
        ],
        "bbox": [9.0, 57.0, 9.1, 57.1],
        "type": "Polygon"
      })!;
      var point = MPPoint.withCoordinates(latitude: 57.05, longitude: 9.05);

      var x = await platform.geometryGetSquaredDistanceToClosestEdge(
          polygon, point);

      expect(x, isNotNull, reason: "Expected value null");
      expect(x!, 15.25);
    });
  });

  group("Solution Configuration Settings", () {
    test("parseMapClientUrl", () async {
      var x = await platform.parseMapClientUrl("venue456", "location789");

      expect(x, isNotNull, reason: "Expected value null");
      expect(x!, "https://mapsclient.com/venue456/location789");
    });

    test("setEnableClustering", () async {
      await platform.setEnableClustering(true);
    });

    test("setCollisionHandling", () async {
      await platform.setCollisionHandling(MPCollisionHandling.removeLabelFirst);
    });

    test("setLocationSettings", () async {
      var settings = MPLocationSettings(selectable: true);
      await platform.setLocationSettings(settings);
    });

    test("setExtrusionOpacity", () async {
      await platform.setExtrusionOpacity(0.8);
    });

    test("setWallOpacity", () async {
      await platform.setWallOpacity(0.6);
    });

    test("setAutomatedZoomLimit", () async {
      await platform.setAutomatedZoomLimit(18.5);
    });
  });

  group("Location Type Configuration", () {
    test("setTypeLocationSettingsSelectable", () async {
      var settings = MPLocationSettings(selectable: true);
      await platform.setTypeLocationSettingsSelectable("room", settings);
    });
  });

  group("Error Handling and Edge Cases", () {
    test("setAutomatedZoomLimit with null", () async {
      // Test the null case for automated zoom limit
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall call) async {
        if (call.method == "UTL_setAutomatedZoomLimit") {
          expect(call.arguments["limit"], isNull);
          return Future(() => null);
        }
        return null;
      });

      await platform.setAutomatedZoomLimit(null);
    });

    test("venueHasGraph with different venue", () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall call) async {
        if (call.method == "UTL_venueHasGraph") {
          expect(call.arguments["id"], "emptyVenue");
          return Future(() => false);
        }
        return null;
      });

      var x = await platform.venueHasGraph("emptyVenue");
      expect(x, isNotNull);
      expect(x!, false);
    });

    test("geometryIsInside with point outside", () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall call) async {
        if (call.method == "UTL_geometryIsInside") {
          expect(call.arguments["it"], isNotNull);
          expect(call.arguments["point"], isNotNull);
          return Future(() => false);
        }
        return null;
      });

      var polygon = MPPolygon.fromJson({
        "coordinates": [
          [
            [9.0, 57.0],
            [9.1, 57.0],
            [9.1, 57.1],
            [9.0, 57.1],
            [9.0, 57.0]
          ]
        ],
        "bbox": [9.0, 57.0, 9.1, 57.1],
        "type": "Polygon"
      })!;
      var pointOutside =
          MPPoint.withCoordinates(latitude: 58.0, longitude: 10.0);

      var x = await platform.geometryIsInside(polygon, pointOutside);
      expect(x, isNotNull);
      expect(x!, false);
    });

    test("pointDistanceTo with same points", () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall call) async {
        if (call.method == "UTL_pointDistanceTo") {
          expect(call.arguments["it"], isNotNull);
          expect(call.arguments["other"], isNotNull);
          return Future(() => 0.0);
        }
        return null;
      });

      var point = MPPoint.withCoordinates(latitude: 57.0, longitude: 9.0);

      var x = await platform.pointDistanceTo(point, point);
      expect(x, isNotNull);
      expect(x!, 0.0);
    });

    test("pointAngleBetween with opposite points", () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall call) async {
        if (call.method == "UTL_pointAngleBetween") {
          expect(call.arguments["it"], isNotNull);
          expect(call.arguments["other"], isNotNull);
          return Future(() => 180.0);
        }
        return null;
      });

      var point1 = MPPoint.withCoordinates(latitude: 57.0, longitude: 9.0);
      var point2 = MPPoint.withCoordinates(latitude: 57.0, longitude: 9.2);

      var x = await platform.pointAngleBetween(point1, point2);
      expect(x, isNotNull);
      expect(x!, 180.0);
    });

    test("setCollisionHandling with different values", () async {
      // Test all collision handling values
      for (var handling in [
        MPCollisionHandling.allowOverlap,
        MPCollisionHandling.removeIconAndLabel,
        MPCollisionHandling.removeIconFirst,
        MPCollisionHandling.removeLabelFirst,
      ]) {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall call) async {
          if (call.method == "UTL_setCollisionHandling") {
            expect(call.arguments["handling"], handling.value);
            return Future(() => null);
          }
          return null;
        });

        await platform.setCollisionHandling(handling);
      }
    });

    test("setLocationSettings with different configurations", () async {
      var selectableSettings = MPLocationSettings(selectable: true);
      var nonSelectableSettings = MPLocationSettings(selectable: false);

      // Test selectable true
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall call) async {
        if (call.method == "UTL_setLocationSettings") {
          expect(call.arguments["locationSettings"], isNotNull);
          return Future(() => null);
        }
        return null;
      });

      await platform.setLocationSettings(selectableSettings);
      await platform.setLocationSettings(nonSelectableSettings);
    });
  });
}
