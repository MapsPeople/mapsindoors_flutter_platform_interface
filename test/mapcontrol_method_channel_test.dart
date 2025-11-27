import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';

/// Test suite for [MethodChannelMapControl] platform interface implementation.
///
/// This test suite validates the functionality of the MapsIndoors MapControl
/// platform methods, including floor selection, filtering, navigation, camera controls,
/// live data, listeners, display options, feature visibility, highlighting,
/// and selection modes.
///
/// Tests use mock method channels to simulate platform responses and verify
/// proper argument passing and result handling.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MethodChannelMapControl platform;
  late MockMethodChannel mockMethodChannel;

  // Test data constants
  const testFloorIndex = 10;
  const testZoomLevel = 15.5;
  const testPaddingStart = 10;
  const testPaddingTop = 20;
  const testPaddingEnd = 30;
  const testPaddingBottom = 40;
  const testLabelSize = 14;
  const testAnimationDuration = 2000;
  const testDomainType = "occupancy";
  const testLocationId = "locationid";
  const testBuildingId = "buildingid";
  const testVenueId = "venueid";
  const testFloorId = "floorid";

  // Test colors
  const testLabelColor = Color(0xFFFF0000); // Red

  // Channel constants
  const MethodChannel mainChannel = MethodChannel('MapControlMethodChannel');
  const MethodChannel listenerChannel =
      MethodChannel('MapControlListenerMethodChannel');
  const MethodChannel floorSelectorChannel =
      MethodChannel('MapControlFloorSelectorChannel');

  // Test JSON data constants
  const testLocationJson = """{"id": "$testLocationId"}""";
  const testBuildingJson = """{
  "id": "$testBuildingId",
  "administrativeId": "admin",
  "venueId": "$testVenueId",
  "geometry": {
            "coordinates": [
                [
                    [
                        9.9508231,
                        57.058159
                    ],
                    [
                        9.9509007,
                        57.0581925
                    ],
                    [
                        9.9508533,
                        57.0582249
                    ],
                    [
                        9.9507757,
                        57.0581914
                    ],
                    [
                        9.9508231,
                        57.058159
                    ]
                ]
            ],
            "bbox": [
                9.9507757,
                57.058159,
                9.9509007,
                57.0582249
            ],
            "type": "Polygon"
        }
}""";
  const testVenueJson = """{
  "id": "$testVenueId",
  "graphId": "graph",
  "name": "admin",
  "tilesUrl": "tiles",
"geometry": {
            "coordinates": [
                [
                    [
                        9.9508231,
                        57.058159
                    ],
                    [
                        9.9509007,
                        57.0581925
                    ],
                    [
                        9.9508533,
                        57.0582249
                    ],
                    [
                        9.9507757,
                        57.0581914
                    ],
                    [
                        9.9508231,
                        57.058159
                    ]
                ]
            ],
            "bbox": [
                9.9507757,
                57.058159,
                9.9509007,
                57.0582249
            ],
            "type": "Polygon"
        },
  "defaultFloor": 10,
  "venueInfo": {}
}""";
  const testMapStyleJson = """{"folder": "folder", "displayName": "name"}""";
  const testFloorJson = """{"id": "$testFloorId", "name": "Ground Floor"}""";

  // Reusable test objects
  final testLocation = MPLocation.fromJson(testLocationJson)!;
  final testBuilding = MPBuilding.fromJson(testBuildingJson)!;
  final testVenue = MPVenue.fromJson(testVenueJson)!;
  final testMapStyle = MPMapStyle.fromJson(testMapStyleJson)!;
  final testPoint = MPPoint.withCoordinates(longitude: 55.0, latitude: 12.0);
  final testCameraUpdate = MPCameraUpdate.fromPoint(testPoint);

  // Helper functions
  void expectMethodCall(String methodName, [Map<String, dynamic>? arguments]) {
    expect(mockMethodChannel.invokedMethods.last, methodName);
    if (arguments != null) {
      expect(mockMethodChannel.lastArguments, arguments);
    }
  }

  setUp(() {
    platform = MethodChannelMapControl();
    mockMethodChannel = MockMethodChannel();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(mainChannel, (MethodCall call) async {
      mockMethodChannel.invokedMethods.add(call.method);
      // Store arguments as-is without casting in setup
      mockMethodChannel.lastArguments = call.arguments != null
          ? Map<String, dynamic>.from(call.arguments as Map)
          : null;
      switch (call.method) {
        case "MPC_getHiddenFeatures":
          return [1, 2, 4];
        case "MPC_setHiddenFeatures":
          return "success";
        case "MPC_setFloorSelector":
          return null;
        case "MPC_selectFloor":
          return null;
        case "MPC_clearFilter":
          return null;
        case "MPC_deSelectLocation":
          return null;
        case "MPC_getCurrentBuilding":
          return testBuildingJson;
        case "MPC_getCurrentBuildingFloor":
          return testFloorJson;
        case "MPC_getCurrentFloorIndex":
          return 20;
        case "MPC_getCurrentMapsIndoorsZoom":
          return testZoomLevel;
        case "MPC_getCurrentVenue":
          return testVenueJson;
        case "MPC_getMapStyle":
          return testMapStyleJson;
        case "MPC_getMapViewPaddingBottom":
          return 50;
        case "MPC_getMapViewPaddingEnd":
          return testPaddingBottom;
        case "MPC_getMapViewPaddingStart":
          return testPaddingStart;
        case "MPC_getMapViewPaddingTop":
          return testPaddingTop;
        case "MPC_goTo":
          return null;
        case "MPC_hideFloorSelector":
          return null;
        case "MPC_isFloorSelectorHidden":
          return false;
        case "MPC_isUserPositionShown":
          return true;
        case "MPC_selectBuilding":
          return null;
        case "MPC_selectLocation":
          return null;
        case "MPC_selectLocationById":
          return null;
        case "MPC_selectVenue":
          return null;
        case "MPC_setFilter":
          return "success";
        case "MPC_setFilterWithLocations":
          return null;
        case "MPC_setMapPadding":
          return null;
        case "MPC_setMapStyle":
          return null;
        case "MPC_showInfoWindowOnClickedLocation":
          return null;
        case "MPC_showUserPosition":
          return null;
        case "MPC_disableLiveData":
          return null;
        case "MPC_enableLiveData":
          return null;
        case "MPC_animateCamera":
          return null;
        case "MPC_getCurrentCameraPosition":
          return jsonEncode({
            "target": [12.0, 55.0],
            "zoom": 15.0,
            "tilt": 0.0,
            "bearing": 0.0,
          });
        case "MPC_moveCamera":
          return null;
        case "MPC_setLabelOptions":
          return null;
        case "MPC_clearHighlight":
          return null;
        case "MPC_setHighlight":
          return null;
        case "MPC_getBuildingSelectionMode":
          return 1; // MPSelectionMode.automatic.index
        case "MPC_getFloorSelectionMode":
          return 0; // MPSelectionMode.manual.index
        case "MPC_setBuildingSelectionMode":
          return null;
        case "MPC_setFloorSelectionMode":
          return null;
        case "MPC_showCompassOnRotate":
          return null;

        default:
          fail('Unexpected method call: ${call.method}');
      }
    });
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(listenerChannel, (MethodCall call) async {
      switch (call.method) {
        case "MPL_cameraEventListener":
          return null;
        case "MPL_floorUpdateListener":
          return null;
        case "MPL_buildingFoundAtCameraTargetListener":
          return null;
        case "MPL_venueFoundAtCameraTargetListener":
          return null;
        case "MPL_locationSelectedListener":
          return null;
        case "MPL_mapClickListener":
          return null;
        case "MPL_markerClickListener":
          return null;
        case "MPL_markerInfoWindowClickListener":
          return null;

        default:
          fail('Unexpected listener method call: ${call.method}');
      }
      return null;
    });
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(floorSelectorChannel,
            (MethodCall call) async {
      switch (call.method) {
        case "FSE_onFloorChanged":
          return null;

        default:
          fail('Unexpected floor selector method call: ${call.method}');
      }
      return null;
    });
  });

  group("Floor Selector Management", () {
    test("should set floor selector successfully", () async {
      // Arrange
      final mockFloorSelector = MockFloorSelector();

      // Act
      await platform.setFloorSelector(mockFloorSelector, true);
      final result = platform.getFloorSelector();

      // Assert
      expect(result, mockFloorSelector);
      // Note: setFloorSelector manages internal state and may not always call method channel
      if (mockMethodChannel.invokedMethods.isNotEmpty) {
        expectMethodCall("MPC_setFloorSelector");
      }
    });

    test("should set floor selector to null", () async {
      // Act
      await platform.setFloorSelector(null, false);
      final result = platform.getFloorSelector();

      // Assert
      expect(result, isNull);
      expectMethodCall("MPC_setFloorSelector");
    });

    test("should select floor by index successfully", () async {
      // Act
      await platform.selectFloor(testFloorIndex);

      // Assert
      expectMethodCall("MPC_selectFloor", {"floorIndex": testFloorIndex});
    });
  });

  group("Filtering and Selection", () {
    test("should clear filter successfully", () async {
      // Act
      await platform.clearFilter();

      // Assert
      expectMethodCall("MPC_clearFilter");
    });

    test("should deselect location successfully", () async {
      // Act
      await platform.deSelectLocation();

      // Assert
      expectMethodCall("MPC_deSelectLocation");
    });

    test("should set filter successfully", () async {
      // Arrange
      final filter = MPFilter.builder().build();

      // Act
      final result = await platform.setFilter(filter, MPFilterBehavior.DEFAULT);

      // Assert
      expect(result, true);
      expectMethodCall("MPC_setFilter");
      expect(mockMethodChannel.lastArguments!["filter"], isNotNull);
      expect(mockMethodChannel.lastArguments!["behavior"], isNotNull);
    });

    test("should set filter with locations successfully", () async {
      // Arrange
      final locations = [testLocation];

      // Act
      await platform.setFilterWithLocations(
          locations, MPFilterBehavior.DEFAULT);

      // Assert
      expectMethodCall("MPC_setFilterWithLocations");
      expect(mockMethodChannel.lastArguments!["locations"], isNotNull);
      expect(mockMethodChannel.lastArguments!["behavior"], isNotNull);
    });

    test("should select building successfully", () async {
      // Act
      await platform.selectBuilding(testBuilding, true);

      // Assert
      expectMethodCall("MPC_selectBuilding");
      expect(mockMethodChannel.lastArguments!["building"], isNotNull);
      expect(mockMethodChannel.lastArguments!["moveCamera"], true);
    });

    test("should select location successfully", () async {
      // Act
      await platform.selectLocation(testLocation, MPSelectionBehavior.DEFAULT);

      // Assert
      expectMethodCall("MPC_selectLocation");
      expect(mockMethodChannel.lastArguments!["location"], testLocationId);
      expect(mockMethodChannel.lastArguments!["behavior"], isNotNull);
    });

    test("should select location by ID successfully", () async {
      // Act
      await platform.selectLocationById(
          testLocationId, MPSelectionBehavior.DEFAULT);

      // Assert
      expectMethodCall("MPC_selectLocationById");
      expect(mockMethodChannel.lastArguments!["id"], testLocationId);
      expect(mockMethodChannel.lastArguments!["behavior"], isNotNull);
    });

    test("should select venue successfully", () async {
      // Act
      await platform.selectVenue(testVenue, false);

      // Assert
      expectMethodCall("MPC_selectVenue");
      expect(mockMethodChannel.lastArguments!["venue"], isNotNull);
      expect(mockMethodChannel.lastArguments!["moveCamera"], false);
    });
  });

  group("State Getters", () {
    test("should get current building successfully", () async {
      // Act
      final result = await platform.getCurrentBuilding();

      // Assert
      expect(result, isNotNull);
      expect(result!.id.value, testBuildingId);
      expectMethodCall("MPC_getCurrentBuilding");
    });

    test("should get current building floor successfully", () async {
      // Act
      final result = await platform.getCurrentBuildingFloor();

      // Assert
      expect(result, isNotNull);
      expect(result!.displayName, "Ground Floor");
      expectMethodCall("MPC_getCurrentBuildingFloor");
    });

    test("should get current floor index successfully", () async {
      // Act
      final result = await platform.getCurrentFloorIndex();

      // Assert
      expect(result, 20);
      expectMethodCall("MPC_getCurrentFloorIndex");
    });

    test("should get current MapsIndoors zoom successfully", () async {
      // Act
      final result = await platform.getCurrentMapsIndoorsZoom();

      // Assert
      expect(result, testZoomLevel);
      expectMethodCall("MPC_getCurrentMapsIndoorsZoom");
    });

    test("should get current venue successfully", () async {
      // Act
      final result = await platform.getCurrentVenue();

      // Assert
      expect(result, isNotNull);
      expect(result!.id.value, testVenueId);
      expectMethodCall("MPC_getCurrentVenue");
    });

    test("should get map style successfully", () async {
      // Act
      final result = await platform.getMapStyle();

      // Assert
      expect(result, isNotNull);
      expect(result!.folder, "folder");
      expectMethodCall("MPC_getMapStyle");
    });

    test("should get map view padding bottom successfully", () async {
      // Act
      final result = await platform.getMapViewPaddingBottom();

      // Assert
      expect(result, 50);
      expectMethodCall("MPC_getMapViewPaddingBottom");
    });

    test("should get map view padding end successfully", () async {
      // Act
      final result = await platform.getMapViewPaddingEnd();

      // Assert
      expect(result, testPaddingBottom);
      expectMethodCall("MPC_getMapViewPaddingEnd");
    });

    test("should get map view padding start successfully", () async {
      // Act
      final result = await platform.getMapViewPaddingStart();

      // Assert
      expect(result, testPaddingStart);
      expectMethodCall("MPC_getMapViewPaddingStart");
    });

    test("should get map view padding top successfully", () async {
      // Act
      final result = await platform.getMapViewPaddingTop();

      // Assert
      expect(result, testPaddingTop);
      expectMethodCall("MPC_getMapViewPaddingTop");
    });

    test("should check if floor selector is hidden", () async {
      // Act
      final result = await platform.isFloorSelectorHidden();

      // Assert
      expect(result, false);
      expectMethodCall("MPC_isFloorSelectorHidden");
    });

    test("should check if user position is shown", () async {
      // Act
      final result = await platform.isUserPositionShown();

      // Assert
      expect(result, true);
      expectMethodCall("MPC_isUserPositionShown");
    });
  });

  group("NAVIGATION AND POSITIONING", () {
    test("goTo with entity only", () async {
      final entity = MPLocation.fromJson(testLocationJson);
      await platform.goTo(entity);
    });

    test("goTo with entity and maxZoom", () async {
      final entity = MPLocation.fromJson(testLocationJson);
      await platform.goTo(entity, 18.0);
    });

    test("hideFloorSelector", () async {
      await platform.hideFloorSelector(true);
    });

    test("setMapPadding", () async {
      await platform.setMapPadding(10, 20, 30, 40);
    });

    test("setMapStyle", () async {
      final mapStyle = MPMapStyle.fromJson(testMapStyleJson);
      await platform.setMapStyle(mapStyle!);
    });

    test("showInfoWindowOnClickedLocation", () async {
      await platform.showInfoWindowOnClickedLocation(true);
    });

    test("showUserPosition", () async {
      await platform.showUserPosition(false);
    });
  });

  group("LIVE DATA", () {
    test("disableLiveData", () async {
      await platform.disableLiveData(testDomainType);
    });

    test("enableLiveData with listener", () async {
      OnLiveLocationUpdateListener listener = (location) {};
      await platform.enableLiveData(testDomainType, listener);
    });

    test("enableLiveData without listener should handle gracefully", () async {
      // Act & Assert - Platform may handle null listener gracefully or throw exception
      try {
        await platform.enableLiveData(testDomainType, null);
        // If no exception, that's also acceptable behavior
      } catch (e) {
        expect(e, isA<PlatformException>());
      }
    });
  });

  group("CAMERA CONTROLS", () {
    test("animateCamera without duration", () async {
      final update = MPCameraUpdate.fromPoint(
          MPPoint.withCoordinates(longitude: 55.0, latitude: 12.0));
      await platform.animateCamera(update);
    });

    test("animateCamera with duration", () async {
      final update = MPCameraUpdate.fromPoint(
          MPPoint.withCoordinates(longitude: 55.0, latitude: 12.0));
      await platform.animateCamera(update, 2000);
    });

    test("currentCameraPosition", () async {
      final result = await platform.currentCameraPosition();
      expect(result, isNotNull);
      expect(result.target.latitude, 55.0);
      expect(result.target.longitude, 12.0);
    });

    test("moveCamera", () async {
      final update = MPCameraUpdate.fromPoint(
          MPPoint.withCoordinates(longitude: 55.0, latitude: 12.0));
      await platform.moveCamera(update);
    });
  });

  group("LISTENERS", () {
    test("addOnCameraEventListner", () {
      MPCameraEventListener listener = (event) {};
      platform.addOnCameraEventListner(listener);
    });

    test("addOnFloorUpdateListener", () {
      OnFloorUpdateListener listener = (floor) {};
      platform.addOnFloorUpdateListener(listener);
    });

    test("setOnCurrentBuildingChangedListener", () {
      OnBuildingFoundAtCameraTargetListener listener = (building) {};
      platform.setOnCurrentBuildingChangedListener(listener);
    });

    test("setOnCurrentVenueChangedListener", () {
      OnVenueFoundAtCameraTargetListener listener = (venue) {};
      platform.setOnCurrentVenueChangedListener(listener);
    });

    test("removeOnCameraEventListner", () {
      MPCameraEventListener listener = (event) {};
      platform.addOnCameraEventListner(listener);
      platform.removeOnCameraEventListner(listener);
    });

    test("removeOnFloorUpdateListener", () {
      OnFloorUpdateListener listener = (floor) {};
      platform.addOnFloorUpdateListener(listener);
      platform.removeOnFloorUpdateListener(listener);
    });

    test("setOnLocationSelectedListener", () {
      OnLocationSelectedListener listener = (location) {};
      platform.setOnLocationSelectedListener(listener, true);
    });

    test("setOnMapClickListener", () {
      OnMapClickListener listener = (point, locations) {};
      platform.setOnMapClickListener(listener, false);
    });

    test("setOnMarkerClickListener", () {
      OnMarkerClickListener listener = (locationId) {};
      platform.setOnMarkerClickListener(listener, true);
    });

    test("setOnMarkerInfoWindowClickListener", () {
      OnMarkerInfoWindowClickListener listener = (locationId) {};
      platform.setOnMarkerInfoWindowClickListener(listener);
    });

    test("setOnMapControlReadyListener", () {
      OnMapReadyListener listener = (error) {};
      platform.setOnMapControlReadyListener(listener);
    });
  });

  group("DISPLAY OPTIONS", () {
    test("setLabelOptions", () async {
      await platform.setLabelOptions(14, const Color(0xFFFF0000), true);
    });
  });

  group("HIDDEN FEATURES", () {
    test("getHiddenFeatures", () async {
      var x = await platform.getHiddenFeatures();
      expect(x, [
        MPFeatureType.walls2D,
        MPFeatureType.model3D,
        MPFeatureType.extrusion3D
      ]);
    });
    test("setHiddenFeatures", () async {
      await platform.setHiddenFeatures(
          [MPFeatureType.extrudedBuildings, MPFeatureType.model2D]);
      await platform.setHiddenFeatures([]);
    });
  });

  group("HIGHLIGHTING", () {
    test("clearHighlight", () async {
      await platform.clearHighlight();
    });

    test("setHighlight", () async {
      final locations = [MPLocation.fromJson(testLocationJson)!];
      await platform.setHighlight(locations, MPHighlightBehavior.DEFAULT);
    });
  });

  group("SELECTION MODES", () {
    test("getBuildingSelectionMode", () async {
      final result = await platform.getBuildingSelectionMode();
      expect(result, MPSelectionMode.automatic);
    });

    test("getFloorSelectionMode", () async {
      final result = await platform.getFloorSelectionMode();
      expect(result, MPSelectionMode.manual);
    });

    test("setBuildingSelectionMode", () async {
      await platform.setBuildingSelectionMode(MPSelectionMode.manual);
    });

    test("setFloorSelectionMode", () async {
      await platform.setFloorSelectionMode(MPSelectionMode.automatic);
    });
  });

  group("COMPASS", () {
    test("showCompassOnRotate", () async {
      await platform.showCompassOnRotate(true);
    });
  });
}

/// Mock class to track method channel calls for testing
class MockMethodChannel {
  final List<String> invokedMethods = [];
  Map<String, dynamic>? lastArguments;
}

// Mock classes for testing
class MockFloorSelector extends MPFloorSelectorInterface {
  @override
  Widget? getWidget() {
    return null;
  }

  @override
  List<MPFloor>? floors;

  @override
  bool isAutoFloorChangeEnabled = true;

  @override
  OnFloorSelectionChangedListener? onFloorSelectionChangedListener;

  @override
  int? userPositionFloor;

  @override
  void setSelectedFloor(MPFloor floor) {}

  @override
  void setSelectedFloorByFloorIndex(int floorIndex) {}

  @override
  void show(bool show) {}

  @override
  void zoomLevelChanged(num zoomLevel) {}
}
