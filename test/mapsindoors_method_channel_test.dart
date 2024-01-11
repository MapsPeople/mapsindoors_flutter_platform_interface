import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MethodChannelMapsindoors platform = MethodChannelMapsindoors();
  const MethodChannel channel = MethodChannel('MapsIndoorsMethodChannel');
  const MethodChannel listener = MethodChannel('MapsIndoorsListenerChannel');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
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
            print("Expected value: 1, Actual: ${x.length}");
            expect(x.length, 1);
            print("Expected value: afaik, Actual: ${x[0].id}");
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
            expect(call.arguments["id"], "id");
            return Future(() => jsonEncode({
                  "id": "id",
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
      }
      return null;
    });

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(listener, (MethodCall call) async {
      switch (call.method) {
        case "MIL_onMapsIndoorsReadyListener":
          {
            print("AddListener: " + call.arguments["addListener"].toString());
            break;
          }
        case "MIL_onPositionUpdate":
          return Future(() => null);
      }
      return null;
    });
  });

  group("LOADING", () {
    test("load", () async {
      var x = await platform.load("STR");

      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: STR, Actual: ${x!.message}");
      expect(x.message, "STR");
      print("Expected value: 120, Actual: ${x.code}");
      expect(x.code, 120);
    });

    test("synchronizeContent", () async {
      var x = await platform.synchronizeContent();

      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: SYNCHRONIZE, Actual: ${x!.message}");
      expect(x.message, "SYNCHRONIZE");
      print("Expected value: 35, Actual: ${x.code}");
      expect(x.code, 35);
    });

    test("isInitialized", () async {
      var x = await platform.isInitialized();

      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: true, Actual: $x");
      expect(x, true);
    });

    test("isReady", () async {
      var x = await platform.isReady();

      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: false, Actual: $x");
      expect(x, false);
    });

    test("destroy", () async {
      await platform.destroy();
    });

    test("MapsIndoorsReadyListener", () {
      OnMapsIndoorsReadyListener x = (error) {
        print("Listener");
      };
      platform.addOnMapsIndoorsReadyListener(x);

      platform.removeOnMapsIndoorsReadyListener(x);
    });
  });

  group("API KEY", () {
    test("getAPIKey", () async {
      var x = await platform.getAPIKey();

      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: test, Actual: $x");
      expect(x, "test");
    });

    test("isAPIKeyValid", () async {
      var x = await platform.isAPIKeyValid();

      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: true, Actual: $x");
      expect(x, true);
    });
  });

  group("LANGUAGE", () {
    test("getAvailableLanguages", () async {
      var x = await platform.getAvailableLanguages();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: [\"da\", \"en\"], Actual: $x");
      expect(x, ["da", "en"]);
    });
    test("getDefaultLanguage", () async {
      var x = await platform.getDefaultLanguage();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: da, Actual: $x");
      expect(x, "da");
    });
    test("getLanguage", () async {
      var x = await platform.getLanguage();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: en, Actual: $x");
      expect(x, "en");
    });
    test("setLanguage", () async {
      var x = await platform.setLanguage("language");
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: true, Actual: $x");
      expect(x, true);
    });
  });

  group("POSITIONING", () {
    test("onPositionUpdate", () async {
      platform.onPositionUpdate(MockPositionUpdate());
    });

    test("getSetPositionProvider", () async {
      var x = platform.getPositionProvider();

      expect(x, isNull);

      var y = MockPositionProvider();

      platform.setPositionProvider(y);

      x = platform.getPositionProvider();

      expect(x, isNotNull, reason: "Expected value null");

      expect(x, y);
    });
  });

  group("DISPLAY RULES", () {
    test("createDisplayRuleWithName", () async {
      var x = platform.createDisplayRuleWithName("test");
      expect(x, isNotNull, reason: "Expected value null");
    });
    test("displayRuleNameExists", () async {
      var x = await platform.displayRuleNameExists("test");
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: true, Actual: $x");
      expect(x, true);
    });
    test("locationDisplayRuleExists", () async {
      var x =
          await platform.locationDisplayRuleExists(MPLocationId("location"));
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: true, Actual: $x");
      expect(x, true);
    });
  });

  group("USERROLES", () {
    test("applyUserRoles", () async {
      MPUserRole x = MPUserRole.fromJson({"id": "afaik", "name": "test1"})!;
      await platform.applyUserRoles([x]);
    });
    test("getAppliedUserRoles", () async {
      var x = await platform.getAppliedUserRoles();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: 1, Actual: ${x!.length}");
      expect(x.length, 1);
      print("Expected value: 123, Actual: ${x[0].id}");
      expect(x[0].id, "123");
      print("Expected value: userrole, Actual: ${x[0].name}");
      expect(x[0].name, "userrole");
    });
    test("getUserRoles", () async {
      var x = await platform.getUserRoles();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: 1, Actual: ${x!.size}");
      expect(x.size, 1);
      print("Expected value: 123, Actual: ${x.getAll()[0].id}");
      expect(x.getAll()[0].id, "123");
      print("Expected value: userrole, Actual: ${x.getAll()[0].name}");
      expect(x.getAll()[0].name, "userrole");
    });
  });

  group("ENTITIES", () {
    test("getSolution", () async {
      var x = await platform.getSolution();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: solutionId, Actual: ${x!.id}");
      expect(x.id, "solutionId");
    });
    test("getCategories", () async {
      var x = await platform.getCategories();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: 2, Actual: ${x!.size}");
      expect(x.size, 2);

      print("Expected value: key1, Actual: ${x.getAll()[0].key}");
      expect(x.getAll()[0].key, "key1");
      print("Expected value: key2, Actual: ${x.getAll()[1].key}");
      expect(x.getAll()[1].key, "key2");
    });
    test("getVenues", () async {
      var x = await platform.getVenues();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: 1, Actual: ${x!.size}");
      expect(x.size, 1);

      print("Expected value: id1, Actual: ${x.getAll()[0].id.value}");
      expect(x.getAll()[0].id.value, "id1");
      print("Expected value: 0, Actual: ${x.getAll()[0].defaultFloor}");
      expect(x.getAll()[0].defaultFloor, 0);
    });
    test("getDefaultVenue", () async {
      var x = await platform.getDefaultVenue();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: id1, Actual: ${x!.id.value}");
      expect(x.id.value, "id1");
      print("Expected value: 0, Actual: ${x.defaultFloor}");
      expect(x.defaultFloor, 0);
    });
    test("getBuildings", () async {
      var x = await platform.getBuildings();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: 1, Actual: ${x!.size}");
      expect(x.size, 1);

      print("Expected value: id1, Actual: ${x.getAll()[0].id.value}");
      expect(x.getAll()[0].id.value, "id1");
      print("Expected value: venue1, Actual: ${x.getAll()[0].venueId}");
      expect(x.getAll()[0].venueId, "venue1");
    });
    test("getLocationById", () async {
      var x = await platform.getLocationById("id");
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: id, Actual: ${x!.id.value}");
      expect(x.id.value, "id");
    });
    test("getLocations", () async {
      var x = await platform.getLocations();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: 2, Actual: ${x!.length}");
      expect(x.length, 2);

      print("Expected value: id1, Actual: ${x[0].id.value}");
      expect(x[0].id.value, "id1");
      print("Expected value: id2, Actual: ${x[1].id.value}");
      expect(x[1].id.value, "id2");
    });
    test("getLocationsByExternalIds", () async {
      var x = await platform.getLocationsByExternalIds(["eid1", "eid2"]);
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: 2, Actual: ${x!.length}");
      expect(x.length, 2);

      print("Expected value: id1, Actual: ${x[0].id.value}");
      expect(x[0].id.value, "id1");
      print("Expected value: id2, Actual: ${x[1].id.value}");
      expect(x[1].id.value, "id2");
    });
    test("getLocationsByQuery", () async {
      var x = await platform.getLocationsByQuery(
          MPQueryBuilder().build(), MPFilter.builder().build());
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: 2, Actual: ${x!.length}");
      expect(x.length, 2);

      print("Expected value: id1, Actual: ${x[0].id.value}");
      expect(x[0].id.value, "id1");
      print("Expected value: id2, Actual: ${x[1].id.value}");
      expect(x[1].id.value, "id2");
    });
  });

  group("UTILITY", () {
    test("checkOfflineDataAvailability", () async {
      var x = await platform.checkOfflineDataAvailability();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: false, Actual: $x");
      expect(x, false);
    });
    test("disableEventLogging", () async {
      await platform.disableEventLogging(false);
    });
    test("getMapStyles", () async {
      var x = await platform.getMapStyles();
      expect(x, isNotNull, reason: "Expected value null");

      print("Expected value: 2, Actual: ${x!.length}");
      expect(x.length, 2);

      print("Expected value: name1, Actual: ${x[0].displayName}");
      expect(x[0].displayName, "name1");
      print("Expected value: name2, Actual: ${x[1].displayName}");
      expect(x[1].displayName, "name2");
    });
    test("reverseGeoCode", () async {
      var x = await platform
          .reverseGeoCode(MPPoint.withCoordinates(longitude: 69, latitude: 69));
      expect(x, isNotNull, reason: "Expected value null");

      expect(x!.areas.length, 2);
      expect(x.rooms.length, 0);
      expect(x.floors.length, 0);
      expect(x.buildings.length, 1);
      expect(x.venues.length, 0);

      print("Expected value: id1, Actual: ${x.areas[0].id.value}");
      expect(x.areas[0].id.value, "id1");
      print("Expected value: id2, Actual: ${x.areas[1].id.value}");
      expect(x.areas[1].id.value, "id2");
      print("Expected value: id3, Actual: ${x.buildings[0].id.value}");
      expect(x.buildings[0].id.value, "id3");
    });
  });
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
