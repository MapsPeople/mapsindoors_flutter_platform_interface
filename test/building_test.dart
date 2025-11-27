import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';

void main() {
  final buildingJsonString = """{
        "id": "b374e8f8e3c24e0f8e2b4567",
        "administrativeId": "admin-building-001",
        "externalId": "BUILDING-EAST-01",
        "venueId": "venue-123456789",
        "anchor": {
            "coordinates": [
                9.9508382,
                57.0581919,
                0
            ],
            "type": "Point"
        },
        "buildingInfo": {
            "name": "East Wing Building",
            "aliases": ["East Building", "Main Building East"],
            "fields": {
                "capacity": {
                    "text": "Total Capacity",
                    "type": "number",
                    "value": "500"
                },
                "buildingType": {
                    "text": "Building Type",
                    "type": "text",
                    "value": "Office"
                }
            }
        },
        "geometry": {
            "coordinates": [
                [
                      [
                          9.9507757,
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
                          9.9507757,
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
        "floors": {
            "0": {
                "id": "floor-ground-001",
                "name": "Ground Floor",
                "floorIndex": 0,
                "aliases": ["G", "Main Floor"],
                "geometry": {
                    "coordinates": [
                        [
                            [
                                [
                                    9.9507757,
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
                                    9.9507757,
                                    57.058159
                                ]
                            ]
                        ]
                    ],
                    "type": "MultiPolygon"
                }
            },
            "10": {
                "id": "floor-first-001",
                "name": "First Floor",
                "floorIndex": 10,
                "aliases": ["1st", "Level 1"],
                "geometry": {
                    "coordinates": [
                        [
                            [
                                [
                                    9.9507757,
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
                                    9.9507757,
                                    57.058159
                                ]
                            ]
                        ]
                    ],
                    "type": "MultiPolygon"
                }
            },
            "100": {
                "id": "floor-tenth-001",
                "name": "Tenth Floor",
                "floorIndex": 100,
                "aliases": ["10th", "Level 10"],
                "geometry": {
                    "coordinates": [
                        [
                            [
                                [
                                    9.9507757,
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
                                    9.9507757,
                                    57.058159
                                ]
                            ]
                        ]
                    ],
                    "type": "MultiPolygon"
                }
            }
        },
        "defaultFloor": 0,
        "address": "123 Main Street, Downtown, City 12345"
    }""";

  group("BUILDING PARSE", () {
    MPBuilding? building = null;
    try {
      building = MPBuilding.fromJson(jsonDecode(buildingJsonString));
    } catch (e) {
      fail("Failed parsing building: $e");
    }

    test("Building is not null", () {
      expect(building, isNotNull);
    });

    test("Building id is correct", () {
      expect(building?.id.value, "b374e8f8e3c24e0f8e2b4567");
      expect(building?.buildingId, "b374e8f8e3c24e0f8e2b4567");
    });

    test("Building administrative id is correct", () {
      expect(building?.administrativeId, "admin-building-001");
    });

    test("Building external id is correct", () {
      expect(building?.externalId, "BUILDING-EAST-01");
    });

    test("Building venue id is correct", () {
      expect(building?.venueId, "venue-123456789");
    });

    test("Building name is correct", () {
      expect(building?.name, "East Wing Building");
    });

    test("Building aliases are correct", () {
      expect(building?.aliases.length, 2);
      expect(building?.aliases[0], "East Building");
      expect(building?.aliases[1], "Main Building East");
    });

    test("Building address is correct", () {
      expect(building?.address, "123 Main Street, Downtown, City 12345");
    });

    test("Building position (anchor) is correct", () {
      expect(building?.position.latitude, closeTo(57.0581919, 0.000001));
      expect(building?.position.longitude, closeTo(9.9508382, 0.000001));
      expect(building?.position.floorIndex, 0);
    });

    test("Building geometry is correct", () {
      expect(building?.geometry, isNotNull);
      expect(building?.isPoint, false);
      expect(building?.bounds, isNotNull);
    });

    test("Building floors are correct", () {
      expect(building?.floorCount, 3);
      expect(building?.floors.length, 3);

      // Test floors are sorted by floor index
      final floors = building!.floors;
      expect(floors[0].floorIndex, 0);
      expect(floors[1].floorIndex, 10);
      expect(floors[2].floorIndex, 100);
    });

    test("Building default floor is correct", () {
      expect(building?.initialFloorIndex, 0);
    });

    test("Building floor access methods work correctly", () {
      expect(building?.hasFloorIndex(0), true);
      expect(building?.hasFloorIndex(10), true);
      expect(building?.hasFloorIndex(100), true);
      expect(building?.hasFloorIndex(5), false);

      final groundFloor = building?.getFloorByIndex(0);
      expect(groundFloor, isNotNull);
      expect(groundFloor?.displayName, "Ground Floor");
      expect(groundFloor?.floorIndex, 0);
      expect(groundFloor?.buildingId, "b374e8f8e3c24e0f8e2b4567");

      final firstFloor = building?.getFloorByIndex(10);
      expect(firstFloor, isNotNull);
      expect(firstFloor?.displayName, "First Floor");
      expect(firstFloor?.floorIndex, 10);

      final tenthFloor = building?.getFloorByIndex(100);
      expect(tenthFloor, isNotNull);
      expect(tenthFloor?.displayName, "Tenth Floor");
      expect(tenthFloor?.floorIndex, 100);

      final nonExistentFloor = building?.getFloorByIndex(99);
      expect(nonExistentFloor, isNull);
    });

    test("Building floor details are correct", () {
      final groundFloor = building?.getFloorByIndex(0);
      expect(groundFloor?.aliases?.length, 2);
      expect(groundFloor?.aliases?[0], "G");
      expect(groundFloor?.aliases?[1], "Main Floor");

      final firstFloor = building?.getFloorByIndex(10);
      expect(firstFloor?.aliases?.length, 2);
      expect(firstFloor?.aliases?[0], "1st");
      expect(firstFloor?.aliases?[1], "Level 1");

      final tenthFloor = building?.getFloorByIndex(100);
      expect(tenthFloor?.aliases?.length, 2);
      expect(tenthFloor?.aliases?[0], "10th");
      expect(tenthFloor?.aliases?[1], "Level 10");
    });

    test("Building custom fields are correct", () {
      final capacityField = building?.getField("capacity");
      expect(capacityField, isNotNull);
      expect(capacityField?.text, "Total Capacity");
      expect(capacityField?.type, "number");
      expect(capacityField?.value, "500");

      final buildingTypeField = building?.getField("buildingType");
      expect(buildingTypeField, isNotNull);
      expect(buildingTypeField?.text, "Building Type");
      expect(buildingTypeField?.type, "text");
      expect(buildingTypeField?.value, "Office");

      final nonExistentField = building?.getField("nonExistent");
      expect(nonExistentField, isNull);
    });

    test("Building equality works correctly", () {
      final building1 = MPBuilding.fromJson(jsonDecode(buildingJsonString));
      final building2 = MPBuilding.fromJson(jsonDecode(buildingJsonString));

      expect(building1 == building2, true);
      expect(building1.hashCode == building2.hashCode, true);

      // Test with different building
      final differentBuildingJson = buildingJsonString.replaceAll(
          '"id": "b374e8f8e3c24e0f8e2b4567"', '"id": "different-building-id"');
      final differentBuilding =
          MPBuilding.fromJson(jsonDecode(differentBuildingJson));

      expect(building1 == differentBuilding, false);
      expect(building1.hashCode == differentBuilding.hashCode, false);
    });

    test("Building toJson works correctly", () {
      final json = building?.toJson();
      expect(json, isNotNull);
      expect(json?["id"], "b374e8f8e3c24e0f8e2b4567");
      expect(json?["administrativeId"], "admin-building-001");
      expect(json?["externalId"], "BUILDING-EAST-01");
      expect(json?["venueId"], "venue-123456789");
      expect(json?["address"], "123 Main Street, Downtown, City 12345");
      expect(json?["defaultFloor"], 0);
      expect(json?["anchor"], isNotNull);
      expect(json?["buildingInfo"], isNotNull);
      expect(json?["geometry"], isNotNull);
      expect(json?["floors"], isNotNull);
      expect(json?["boundingBox"], isNotNull);
    });
  });

  group("BUILDING EDGE CASES", () {
    test("Building with null/empty data", () {
      final nullBuilding = MPBuilding.fromJson(null);
      expect(nullBuilding, isNull);

      final nullStringBuilding = MPBuilding.fromJson("null");
      expect(nullStringBuilding, isNull);
    });

    test("Building with minimal data", () {
      final minimalBuildingJson = """{
        "id": "minimal-building",
        "administrativeId": "admin-minimal",
        "venueId": "venue-minimal",
        "geometry": {
          "coordinates": [
            [
              [0, 0],
              [1, 0],
              [1, 1],
              [0, 1],
              [0, 0]
            ]
          ],
          "type": "Polygon"
        }
      }""";

      final minimalBuilding =
          MPBuilding.fromJson(jsonDecode(minimalBuildingJson));
      expect(minimalBuilding, isNotNull);
      expect(minimalBuilding?.name, "");
      expect(minimalBuilding?.aliases, isEmpty);
      expect(minimalBuilding?.address, "");
      expect(minimalBuilding?.floorCount, 0);
      expect(minimalBuilding?.floors, isEmpty);
    });
  });
}
