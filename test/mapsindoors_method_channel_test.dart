import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';

/// Test suite for [MethodChannelMapsindoors] platform interface implementation.
///
/// This test suite validates the functionality of the MapsIndoors platform
/// methods, including loading/initialization, API key management, language configuration,
/// positioning, display rules, user roles, entity management, venue synchronization,
/// and utility functions.
///
/// Tests use mock method channels to simulate platform responses and verify
/// proper argument passing and result handling.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MethodChannelMapsindoors platform;
  late MockMethodChannel mockMethodChannel;

  // Test data constants
  const testApiKey = "test_api_key";
  const testLanguage = "en";
  const testLocationId = "test_location_id";
  const testDisplayRuleName = "test_display_rule";
  const testUserRoleId = "test_user_role";
  const testVenueId1 = "venue1";
  const testVenueId2 = "venue2";

  // Reusable test objects
  final testPoint =
      MPPoint.withCoordinates(longitude: 9.9501, latitude: 57.0580);
  final testUserRole =
      MPUserRole.fromJson({"id": testUserRoleId, "name": "test_role"})!;
  final testLocationIds = ["eid1", "eid2"];
  final testVenueIds = [testVenueId1, testVenueId2];

  const MethodChannel mainChannel = MethodChannel('MapsIndoorsMethodChannel');
  const MethodChannel listenerChannel =
      MethodChannel('MapsIndoorsListenerChannel');

  // Helper functions
  void expectMethodCall(String methodName, [Map<String, dynamic>? arguments]) {
    expect(mockMethodChannel.invokedMethods.last, methodName);
    if (arguments != null) {
      expect(mockMethodChannel.lastArguments, arguments);
    }
  }

  setUp(() {
    platform = MethodChannelMapsindoors();
    mockMethodChannel = MockMethodChannel();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(mainChannel, (MethodCall call) async {
      mockMethodChannel.invokedMethods.add(call.method);
      // Store arguments as-is without casting in setup
      mockMethodChannel.lastArguments = call.arguments != null
          ? Map<String, dynamic>.from(call.arguments as Map)
          : null;
      switch (call.method) {
        case "MIN_initialize":
          return Future(() =>
              jsonEncode({"code": 120, "message": call.arguments["key"]}));
        case "MIN_synchronizeContent":
          return Future(
              () => jsonEncode({"code": 35, "message": "SYNCHRONIZE"}));
        case "MIN_isInitialized":
          return Future(() => true);
        case "MIN_isReady":
          return Future(() => false);
        case "MIN_destroy":
          return Future(() => null);
        case "MIN_getAPIKey":
          return Future(() => "test");
        case "MIN_isAPIKeyValid":
          return Future(() => true);
        case "MIN_getAvailableLanguages":
          return Future(() => ["da", "en"]);
        case "MIN_getDefaultLanguage":
          return Future(() => "da");
        case "MIN_getLanguage":
          return Future(() => "en");
        case "MIN_setLanguage":
          return Future(() => true);
        case "MIN_setPositionProvider":
          return Future(() => null);
        case "MIN_locationDisplayRuleExists":
          return Future(() => true);
        case "MIN_displayRuleNameExists":
          return Future(() => true);
        case "MIN_applyUserRoles":
          {
            var x = convertMIList(
                jsonDecode(call.arguments["userRoles"]), MPUserRole.fromJson);
            expect(x, isNotNull);
            expect(x.length, 1);
            expect(x[0].id, "afaik");
            break;
          }
        case "MIN_getAppliedUserRoles":
        case "MIN_getUserRoles":
          return Future(() => jsonEncode([
                {"id": "123", "name": "userrole"}
              ]));
        case "MIN_getSolution":
          return Future(() => jsonEncode({
                "solutionConfig": {
                  "settings3D": {
                    "wallOpacity": 0.3,
                  },
                  "collisionHandling": 0,
                },
                "id": "solutionId",
                "name": "solutionName",
                "defaultLanguage": "da",
                "availableLanguages": ["da", "en"],
                "modules": ["abc", "123"],
              }));
        case "MIN_getCategories":
          return Future(() => jsonEncode([
                {"key": "key1", "value": "value1"},
                {"key": "key2", "value": "value2"},
              ]));
        case "MIN_getVenues":
          return Future(() => jsonEncode([
                {
                  "id": "id1",
                  "name": "aid1",
                  "tilesUrl": "https//:a.com",
                  "geometry": {
                    "coordinates": [
                      [
                        [12.557822, 55.66775],
                        [12.557829, 55.667745],
                        [12.557838, 55.667749],
                        [12.557831, 55.667754],
                        [12.557822, 55.66775],
                      ],
                    ],
                    "bbox": [12.557822, 55.667745, 12.557838, 55.667754],
                    "type": "Polygon"
                  },
                  "defaultFloor": 0,
                  "venueInfo": {
                    "name": "name1",
                  },
                  "styles": [
                    {"folder": "blue", "displayName": "black"}
                  ]
                },
              ]));
        case "MIN_getDefaultVenue":
          return Future(() => jsonEncode(
                {
                  "id": "id1",
                  "name": "aid1",
                  "tilesUrl": "https//:a.com",
                  "geometry": {
                    "coordinates": [
                      [
                        [12.557822, 55.66775],
                        [12.557829, 55.667745],
                        [12.557838, 55.667749],
                        [12.557831, 55.667754],
                        [12.557822, 55.66775],
                      ],
                    ],
                    "bbox": [12.557822, 55.667745, 12.557838, 55.667754],
                    "type": "Polygon"
                  },
                  "defaultFloor": 0,
                  "venueInfo": {
                    "name": "name1",
                  },
                },
              ));
        case "MIN_getBuildings":
          return Future(() => jsonEncode([
                {
                  "id": "id1",
                  "administrativeId": "aid1",
                  "venueId": "venue1",
                  "geometry": {
                    "coordinates": [
                      [
                        [12.557822, 55.66775],
                        [12.557829, 55.667745],
                        [12.557838, 55.667749],
                        [12.557831, 55.667754],
                        [12.557822, 55.66775],
                      ],
                    ],
                    "bbox": [12.557822, 55.667745, 12.557838, 55.667754],
                    "type": "Polygon"
                  },
                },
              ]));
        case "MIN_getLocationById":
          {
            final id = call.arguments["id"];
            return Future(() => jsonEncode({
                  "id": id,
                }));
          }
        case "MIN_getLocations":
          return Future(() => jsonEncode([
                {
                  "id": "id1",
                },
                {
                  "id": "id2",
                },
              ]));
        case "MIN_getLocationsByExternalIds":
          {
            expect(call.arguments["ids"][0], "eid1");
            expect(call.arguments["ids"][1], "eid2");

            return Future(() => jsonEncode([
                  {"id": "id1"},
                  {"id": "id2"},
                ]));
          }
        case "MIN_getLocationsByQuery":
          {
            expect(call.arguments["filter"], isNotNull);
            expect(call.arguments["query"], isNotNull);

            return Future(() => jsonEncode([
                  {"id": "id1"},
                  {"id": "id2"},
                ]));
          }
        case "MIN_checkOfflineDataAvailability":
          return Future(() => false);
        case "MIN_disableEventLogging":
          {
            expect(call.arguments["disable"], false);

            return Future(() => null);
          }
        case "MIN_getMapStyles":
          return Future(() => jsonEncode([
                {
                  "folder": "folder1",
                  "displayName": "name1",
                },
                {
                  "folder": "folder2",
                  "displayName": "name2",
                },
              ]));
        case "MIN_reverseGeoCode":
          {
            expect(MPPoint.fromJson(call.arguments["point"]), isNotNull);

            return Future(() => jsonEncode({
                  "areas": [
                    {"id": "id1"},
                    {"id": "id2"},
                  ],
                  "rooms": [],
                  "floors": [],
                  "buildings": [
                    {"id": "id3"}
                  ],
                  "venues": [],
                }));
          }
        case "MIN_addVenuesToSync":
          {
            expect(call.arguments["venueIds"], isNotNull);
            final venueIds = jsonDecode(call.arguments["venueIds"]) as List;
            // Allow empty venue lists for testing
            if (venueIds.isNotEmpty) {
              expect(venueIds[0], equals("venue1"));
              expect(venueIds[1], equals("venue2"));
            }

            return Future(() => null);
          }
        case "MIN_getSyncedVenues":
          {
            return Future(() => [
                  "venue1",
                  "venue2",
                ]);
          }
        case "MIN_loadWithVenues":
          {
            expect(call.arguments["key"], isNotNull);
            expect(call.arguments["venueIds"], isNotNull);
            final venueIds = jsonDecode(call.arguments["venueIds"]) as List;
            // Allow empty venue lists for testing
            if (venueIds.isNotEmpty) {
              expect(venueIds[0], equals("venue1"));
              expect(venueIds[1], equals("venue2"));
            }

            return Future(() => null);
          }
        case "MIN_removeVenuesToSync":
          {
            expect(call.arguments["venueIds"], isNotNull);
            final venueIds = jsonDecode(call.arguments["venueIds"]) as List;
            // Allow empty venue lists for testing
            if (venueIds.isNotEmpty) {
              expect(venueIds[0], equals("venue1"));
              expect(venueIds[1], equals("venue2"));
            }

            return Future(() => null);
          }
        case "MIN_enableDebugLogging":
          {
            expect(call.arguments["enable"], isNotNull);

            return Future(() => null);
          }

        default:
          fail('Unexpected method call: ${call.method}');
      }
    });

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(listenerChannel, (MethodCall call) async {
      switch (call.method) {
        case "MIL_onMapsIndoorsReadyListener":
          {
            break;
          }
        case "MIL_onPositionUpdate":
          return Future(() => null);
        case "MIL_onVenueStatusListener":
          {
            expect(call.arguments["addListener"], isNotNull);
            break;
          }

        default:
          fail('Unexpected listener method call: ${call.method}');
      }
      return null;
    });
  });

  group("Loading and Initialization", () {
    test("should load MapsIndoors with API key successfully", () async {
      // Act
      final result = await platform.load(testApiKey);

      // Assert
      expect(result, isNotNull);
      expect(result!.message, testApiKey);
      expect(result.code, 120);
      expectMethodCall("MIN_initialize", {"key": testApiKey});
    });

    test("should synchronize content successfully", () async {
      // Act
      final result = await platform.synchronizeContent();

      // Assert
      expect(result, isNotNull);
      expect(result!.message, "SYNCHRONIZE");
      expect(result.code, 35);
      expectMethodCall("MIN_synchronizeContent");
    });

    test("should check initialization status correctly", () async {
      // Act
      final result = await platform.isInitialized();

      // Assert
      expect(result, isNotNull);
      expect(result!, true);
      expectMethodCall("MIN_isInitialized");
    });

    test("should check ready status correctly", () async {
      // Act
      final result = await platform.isReady();

      // Assert
      expect(result, isNotNull);
      expect(result!, false);
      expectMethodCall("MIN_isReady");
    });

    test("should destroy MapsIndoors successfully", () async {
      // Act
      await platform.destroy();

      // Assert
      expectMethodCall("MIN_destroy");
    });

    test("should handle MapsIndoors ready listener lifecycle", () {
      // Arrange
      OnMapsIndoorsReadyListener testListener = (error) {};

      // Act
      platform.addOnMapsIndoorsReadyListener(testListener);
      platform.removeOnMapsIndoorsReadyListener(testListener);

      // Assert - Method should complete without error
      // Listener management is handled internally
    });
  });

  group("API Key Management", () {
    test("should get API key successfully", () async {
      // Act
      final result = await platform.getAPIKey();

      // Assert
      expect(result, isNotNull);
      expect(result!, "test");
      expectMethodCall("MIN_getAPIKey");
    });

    test("should validate API key successfully", () async {
      // Act
      final result = await platform.isAPIKeyValid();

      // Assert
      expect(result, isNotNull);
      expect(result!, true);
      expectMethodCall("MIN_isAPIKeyValid");
    });
  });

  group("Language Configuration", () {
    test("should get available languages successfully", () async {
      // Act
      final result = await platform.getAvailableLanguages();

      // Assert
      expect(result, isNotNull);
      expect(result!, ["da", "en"]);
      expectMethodCall("MIN_getAvailableLanguages");
    });

    test("should get default language successfully", () async {
      // Act
      final result = await platform.getDefaultLanguage();

      // Assert
      expect(result, isNotNull);
      expect(result!, "da");
      expectMethodCall("MIN_getDefaultLanguage");
    });

    test("should get current language successfully", () async {
      // Act
      final result = await platform.getLanguage();

      // Assert
      expect(result, isNotNull);
      expect(result!, testLanguage);
      expectMethodCall("MIN_getLanguage");
    });

    test("should set language successfully", () async {
      // Act
      final result = await platform.setLanguage("language");

      // Assert
      expect(result, isNotNull);
      expect(result!, true);
      expectMethodCall("MIN_setLanguage", {"language": "language"});
    });
  });

  group("Positioning", () {
    test("should handle position updates correctly", () async {
      // Arrange
      final mockPosition = MockPositionUpdate();

      // Act
      platform.onPositionUpdate(mockPosition);

      // Assert - Method should complete without error
      // Position update handling is internal
    });

    test("should manage position provider lifecycle", () async {
      // Arrange
      final mockProvider = MockPositionProvider();

      // Act
      var currentProvider = platform.getPositionProvider();
      expect(currentProvider, isNull);

      platform.setPositionProvider(mockProvider);
      currentProvider = platform.getPositionProvider();

      // Assert
      expect(currentProvider, isNotNull);
      expect(currentProvider, mockProvider);
      expectMethodCall("MIN_setPositionProvider");
    });
  });

  group("Display Rules", () {
    test("should create display rule with name successfully", () async {
      // Act
      final result = platform.createDisplayRuleWithName(testDisplayRuleName);

      // Assert
      expect(result, isNotNull);
      // Note: No method call expected as this creates a local display rule
    });

    test("should check if display rule name exists", () async {
      // Act
      final result = await platform.displayRuleNameExists(testDisplayRuleName);

      // Assert
      expect(result, isNotNull);
      expect(result, true);
      expectMethodCall(
          "MIN_displayRuleNameExists", {"name": testDisplayRuleName});
    });

    test("should check if location display rule exists", () async {
      // Arrange
      final locationId = MPLocationId(testLocationId);

      // Act
      final result = await platform.locationDisplayRuleExists(locationId);

      // Assert
      expect(result, isNotNull);
      expect(result, true);
      expectMethodCall("MIN_locationDisplayRuleExists");
    });
  });

  group("User Roles", () {
    test("should apply user roles successfully", () async {
      // Arrange
      final userRole = MPUserRole.fromJson({"id": "afaik", "name": "test1"})!;

      // Act
      await platform.applyUserRoles([userRole]);

      // Assert
      expectMethodCall("MIN_applyUserRoles");
    });

    test("should get applied user roles successfully", () async {
      // Act
      final result = await platform.getAppliedUserRoles();

      // Assert
      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result[0].id, "123");
      expect(result[0].name, "userrole");
      expectMethodCall("MIN_getAppliedUserRoles");
    });

    test("should get user roles successfully", () async {
      // Act
      final result = await platform.getUserRoles();

      // Assert
      expect(result, isNotNull);
      expect(result!.size, 1);
      expect(result.getAll()[0].id, "123");
      expect(result.getAll()[0].name, "userrole");
      expectMethodCall("MIN_getUserRoles");
    });
  });

  group("Entity Management", () {
    test("should get solution successfully", () async {
      // Act
      final result = await platform.getSolution();

      // Assert
      expect(result, isNotNull);
      expect(result!.id, "solutionId");
      expectMethodCall("MIN_getSolution");
    });

    test("should get categories successfully", () async {
      // Act
      final result = await platform.getCategories();

      // Assert
      expect(result, isNotNull);
      expect(result!.size, 2);
      expect(result.getAll()[0].key, "key1");
      expect(result.getAll()[1].key, "key2");
      expectMethodCall("MIN_getCategories");
    });

    test("should get venues successfully", () async {
      // Act
      final result = await platform.getVenues();

      // Assert
      expect(result, isNotNull);
      expect(result!.size, 1);
      expect(result.getAll()[0].id.value, "id1");
      expect(result.getAll()[0].defaultFloor, 0);
      expectMethodCall("MIN_getVenues");
    });

    test("should get default venue successfully", () async {
      // Act
      final result = await platform.getDefaultVenue();

      // Assert
      expect(result, isNotNull);
      expect(result!.id.value, "id1");
      expect(result.defaultFloor, 0);
      expectMethodCall("MIN_getDefaultVenue");
    });

    test("should get buildings successfully", () async {
      // Act
      final result = await platform.getBuildings();

      // Assert
      expect(result, isNotNull);
      expect(result!.size, 1);
      expect(result.getAll()[0].id.value, "id1");
      expect(result.getAll()[0].venueId, testVenueId1);
      expectMethodCall("MIN_getBuildings");
    });

    test("should get location by ID successfully", () async {
      // Act
      final result = await platform.getLocationById(testLocationId);

      // Assert
      expect(result, isNotNull);
      expect(result!.id.value, testLocationId);
      expectMethodCall("MIN_getLocationById", {"id": testLocationId});
    });

    test("should get all locations successfully", () async {
      // Act
      final result = await platform.getLocations();

      // Assert
      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0].id.value, "id1");
      expect(result[1].id.value, "id2");
      expectMethodCall("MIN_getLocations");
    });

    test("should get locations by external IDs successfully", () async {
      // Act
      final result = await platform.getLocationsByExternalIds(testLocationIds);

      // Assert
      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0].id.value, "id1");
      expect(result[1].id.value, "id2");
      expectMethodCall(
          "MIN_getLocationsByExternalIds", {"ids": testLocationIds});
    });

    test("should get locations by query successfully", () async {
      // Arrange
      final query = MPQueryBuilder().build();
      final filter = MPFilter.builder().build();

      // Act
      final result = await platform.getLocationsByQuery(query, filter);

      // Assert
      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0].id.value, "id1");
      expect(result[1].id.value, "id2");
      expectMethodCall("MIN_getLocationsByQuery");
    });
  });

  group("Venue Synchronization", () {
    test("should add venues to sync successfully", () async {
      // Act
      await platform.addVenuesToSync(testVenueIds);

      // Assert
      expectMethodCall("MIN_addVenuesToSync");
    });

    test("should get synced venues successfully", () async {
      // Act
      final result = await platform.getSyncedVenues();

      // Assert
      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0], testVenueId1);
      expect(result[1], testVenueId2);
      expectMethodCall("MIN_getSyncedVenues");
    });

    test("should load with venues successfully", () async {
      // Act
      await platform.loadWithVenues(testApiKey, testVenueIds);

      // Assert
      expectMethodCall("MIN_loadWithVenues");
      expect(mockMethodChannel.lastArguments!["key"], testApiKey);
      expect(mockMethodChannel.lastArguments!["venueIds"], isNotNull);
    });

    test("should remove venues from sync successfully", () async {
      // Act
      await platform.removeVenuesToSync(testVenueIds);

      // Assert
      expectMethodCall("MIN_removeVenuesToSync");
    });
  });

  group("Utility Functions", () {
    test("should check offline data availability", () async {
      // Act
      final result = await platform.checkOfflineDataAvailability();

      // Assert
      expect(result, isNotNull);
      expect(result, false);
      expectMethodCall("MIN_checkOfflineDataAvailability");
    });

    test("should disable event logging successfully", () async {
      // Act
      await platform.disableEventLogging(false);

      // Assert
      expectMethodCall("MIN_disableEventLogging", {"disable": false});
    });

    test("should get map styles successfully", () async {
      // Act
      final result = await platform.getMapStyles();

      // Assert
      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0].displayName, "name1");
      expect(result[1].displayName, "name2");
      expectMethodCall("MIN_getMapStyles");
    });

    test("should perform reverse geocoding successfully", () async {
      // Arrange
      final testGeoPoint = MPPoint.withCoordinates(longitude: 69, latitude: 69);

      // Act
      final result = await platform.reverseGeoCode(testGeoPoint);

      // Assert
      expect(result, isNotNull);
      expect(result!.areas.length, 2);
      expect(result.rooms.length, 0);
      expect(result.floors.length, 0);
      expect(result.buildings.length, 1);
      expect(result.venues.length, 0);

      expect(result.areas[0].id.value, "id1");
      expect(result.areas[1].id.value, "id2");
      expect(result.buildings[0].id.value, "id3");
      expectMethodCall("MIN_reverseGeoCode");
    });

    test("should enable debug logging successfully", () async {
      // Act
      await platform.enableDebugLogging(true);

      // Assert
      expectMethodCall("MIN_enableDebugLogging", {"enable": true});
    });
  });

  group("Edge Cases and Error Handling", () {
    test("should handle different language codes", () async {
      const languageCodes = ["da", "en", "de", "fr"];

      for (final code in languageCodes) {
        await platform.setLanguage(code);
        expectMethodCall("MIN_setLanguage", {"language": code});
      }
    });

    test("should handle empty venue lists", () async {
      // Act
      await platform.addVenuesToSync([]);

      // Assert
      expectMethodCall("MIN_addVenuesToSync");
    });

    test("should handle various location ID formats", () async {
      const locationIds = ["loc_123", "building_456", "room_789"];

      for (final id in locationIds) {
        await platform.getLocationById(id);
        expectMethodCall("MIN_getLocationById", {"id": id});
      }
    });

    test("should handle different logging states", () async {
      // Test enabling
      await platform.enableDebugLogging(true);
      expectMethodCall("MIN_enableDebugLogging", {"enable": true});

      // Test disabling
      await platform.enableDebugLogging(false);
      expectMethodCall("MIN_enableDebugLogging", {"enable": false});
    });
  });
}

/// Mock class to track method channel calls for testing
class MockMethodChannel {
  final List<String> invokedMethods = [];
  Map<String, dynamic>? lastArguments;
}

class MockPositionProvider extends MPPositionProviderInterface {
  @override
  void addOnPositionUpdateListener(OnPositionUpdateListener listener) {}

  @override
  MPPositionResultInterface? get latestPosition => throw UnimplementedError();

  @override
  String get name => "MOCK";

  @override
  void removeOnPositionUpdateListener(OnPositionUpdateListener listener) {}
}

class MockPositionUpdate extends MPPositionResultInterface {
  @override
  num? get accuracy => 180.0;

  @override
  num? get bearing => 37.5;

  @override
  int? get floorIndex => 10;

  @override
  MPPoint? get point =>
      MPPoint.withCoordinates(longitude: 45.23, latitude: 23.55);

  @override
  MPPositionProviderInterface get provider => MockPositionProvider();
}
