import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';

void main() {
  final venueJsonString = """{
        "id": "v123e4567-e89b-12d3-a456-426614174000",
        "graphId": "graph-123-456-789",
        "name": "MapsPeople Office Complex",
        "tilesUrl": "https://tiles.mapsindoors.com/mapspeople/tiles/",
        "styles": [
            {
                "folder": "default",
                "displayName": "Default Style"
            },
            {
                "folder": "dark",
                "displayName": "Dark Theme"
            },
            {
                "folder": "accessibility", 
                "displayName": "High Contrast"
            }
        ],
        "geometry": {
            "coordinates": [
                [
                    [
                        9.9507000,
                        57.0580000
                    ],
                    [
                        9.9510000,
                        57.0580000
                    ],
                    [
                        9.9510000,
                        57.0583000
                    ],
                    [
                        9.9507000,
                        57.0583000
                    ],
                    [
                        9.9507000,
                        57.0580000
                    ]
                ]
            ],
            "bbox": [
                9.9507000,
                57.0580000,
                9.9510000,
                57.0583000
            ],
            "type": "Polygon"
        },
        "defaultFloor": 0,
        "venueInfo": {
            "name": "MapsPeople HQ",
            "aliases": ["MapsPeople Office", "MP Office", "HQ"],
            "language": "en-US",
            "fields": {
                "capacity": {
                    "text": "Total Venue Capacity",
                    "type": "number",
                    "value": "2500"
                },
                "venueType": {
                    "text": "Venue Type",
                    "type": "text",
                    "value": "Corporate Office"
                },
                "established": {
                    "text": "Established Year",
                    "type": "text",
                    "value": "2005"
                }
            }
        },
        "anchor": {
            "coordinates": [
                9.9508500,
                57.0581500,
                0
            ],
            "type": "Point"
        },
        "entryPoints": [
            {
                "coordinates": [
                    9.9507200,
                    57.0581000,
                    0
                ],
                "type": "Point"
            },
            {
                "coordinates": [
                    9.9509800,
                    57.0582500,
                    0
                ],
                "type": "Point"
            },
            {
                "coordinates": [
                    9.9508000,
                    57.0583000,
                    0
                ],
                "type": "Point"
            }
        ],
        "externalId": "VENUE-MP-001"
    }""";

  group("VENUE PARSE", () {
    MPVenue? venue = null;
    try {
      venue = MPVenue.fromJson(jsonDecode(venueJsonString));
    } catch (e) {}

    test("Venue is not null", () {
      expect(venue, isNotNull);
    });

    test("Venue id is correct", () {
      expect(venue?.id.value, "v123e4567-e89b-12d3-a456-426614174000");
    });

    test("Venue graph id is correct", () {
      expect(venue?.graphId, "graph-123-456-789");
    });

    test("Venue administrative id is correct", () {
      expect(venue?.administrativeId, "MapsPeople Office Complex");
    });

    test("Venue tiles url is correct", () {
      expect(
          venue?.tilesUrl, "https://tiles.mapsindoors.com/mapspeople/tiles/");
    });

    test("Venue external id is correct", () {
      expect(venue?.externalId, "VENUE-MP-001");
    });

    test("Venue name is correct", () {
      expect(venue?.name, "MapsPeople HQ");
    });

    test("Venue default floor is correct", () {
      expect(venue?.defaultFloor, 0);
    });

    test("Venue position (anchor) is correct", () {
      expect(venue?.position.latitude, closeTo(57.0581500, 0.000001));
      expect(venue?.position.longitude, closeTo(9.9508500, 0.000001));
      expect(venue?.position.floorIndex, 0);
    });

    test("Venue geometry is correct", () {
      expect(venue?.geometry, isNotNull);
      expect(venue?.isPoint, false);
      expect(venue?.bounds, isNotNull);
    });

    test("Venue map styles are correct", () {
      expect(venue?.mapStyles.length, 3);

      final styles = venue!.mapStyles;
      expect(styles[0].folder, "default");
      expect(styles[0].displayName, "Default Style");

      expect(styles[1].folder, "dark");
      expect(styles[1].displayName, "Dark Theme");

      expect(styles[2].folder, "accessibility");
      expect(styles[2].displayName, "High Contrast");
    });

    test("Venue default map style is correct", () {
      final defaultStyle = venue?.defaultMapStyle;
      expect(defaultStyle, isNotNull);
      expect(defaultStyle?.folder, "default");
      expect(defaultStyle?.displayName, "Default Style");
    });

    test("Venue map style validation works correctly", () {
      final validStyle = venue!.mapStyles[1]; // dark theme
      final invalidStyle = MPMapStyle.fromJson(
          {"folder": "nonexistent", "displayName": "Non-existent Style"});

      expect(venue?.isMapStyleValid(validStyle), true);
      expect(venue?.isMapStyleValid(invalidStyle!), false);
    });

    test("Venue entry points are correct", () {
      expect(venue?.entryPoints.length, 3);

      final entryPoints = venue!.entryPoints;

      // First entry point
      expect(entryPoints[0].latitude, closeTo(57.0581000, 0.000001));
      expect(entryPoints[0].longitude, closeTo(9.9507200, 0.000001));
      expect(entryPoints[0].floorIndex, 0);

      // Second entry point
      expect(entryPoints[1].latitude, closeTo(57.0582500, 0.000001));
      expect(entryPoints[1].longitude, closeTo(9.9509800, 0.000001));
      expect(entryPoints[1].floorIndex, 0);

      // Third entry point
      expect(entryPoints[2].latitude, closeTo(57.0583000, 0.000001));
      expect(entryPoints[2].longitude, closeTo(9.9508000, 0.000001));
      expect(entryPoints[2].floorIndex, 0);
    });

    test("Venue custom fields are correct", () {
      final capacityField = venue?.getField("capacity");
      expect(capacityField, isNotNull);
      expect(capacityField?.text, "Total Venue Capacity");
      expect(capacityField?.type, "number");
      expect(capacityField?.value, "2500");

      final venueTypeField = venue?.getField("venueType");
      expect(venueTypeField, isNotNull);
      expect(venueTypeField?.text, "Venue Type");
      expect(venueTypeField?.type, "text");
      expect(venueTypeField?.value, "Corporate Office");

      final establishedField = venue?.getField("established");
      expect(establishedField, isNotNull);
      expect(establishedField?.text, "Established Year");
      expect(establishedField?.type, "text");
      expect(establishedField?.value, "2005");

      final nonExistentField = venue?.getField("nonExistent");
      expect(nonExistentField, isNull);
    });

    test("Venue equality works correctly", () {
      final venue1 = MPVenue.fromJson(jsonDecode(venueJsonString));
      final venue2 = MPVenue.fromJson(jsonDecode(venueJsonString));

      expect(venue1 == venue2, true);
      expect(venue1.hashCode == venue2.hashCode, true);

      // Test with different venue
      final differentVenueJson = venueJsonString.replaceAll(
          '"id": "v123e4567-e89b-12d3-a456-426614174000"',
          '"id": "different-venue-id"');
      final differentVenue = MPVenue.fromJson(jsonDecode(differentVenueJson));

      expect(venue1 == differentVenue, false);
      expect(venue1.hashCode == differentVenue.hashCode, false);
    });

    test("Venue toJson works correctly", () {
      final json = venue?.toJson();
      expect(json, isNotNull);
      expect(json?["id"], "v123e4567-e89b-12d3-a456-426614174000");
      expect(json?["name"], "MapsPeople Office Complex");
      expect(json?["administrativeId"], "MapsPeople Office Complex");
      expect(json?["graphId"], "graph-123-456-789");
      expect(
          json?["tilesUrl"], "https://tiles.mapsindoors.com/mapspeople/tiles/");
      expect(json?["externalId"], "VENUE-MP-001");
      expect(json?["defaultFloor"], 0);
      expect(json?["anchor"], isNotNull);
      expect(json?["venueInfo"], isNotNull);
      expect(json?["geometry"], isNotNull);
      expect(json?["styles"], isNotNull);
      expect(json?["entryPoints"], isNotNull);
    });

    test("Map style equality works correctly", () {
      final style1 = MPMapStyle.fromJson(
          {"folder": "Default", "displayName": "Default Style"});
      final style2 = MPMapStyle.fromJson({
        "folder": "default", // Different case
        "displayName": "DEFAULT STYLE" // Different case
      });
      final style3 =
          MPMapStyle.fromJson({"folder": "dark", "displayName": "Dark Theme"});

      expect(style1 == style2, true); // Case insensitive
      expect(style1.hashCode == style2.hashCode, true);
      expect(style1 == style3, false);
      expect(style1.hashCode == style3.hashCode, false);
    });
  });

  group("VENUE EDGE CASES", () {
    test("Venue with null/empty data", () {
      final nullVenue = MPVenue.fromJson(null);
      expect(nullVenue, isNull);

      final nullStringVenue = MPVenue.fromJson("null");
      expect(nullStringVenue, isNull);
    });

    test("Venue with minimal data", () {
      final minimalVenueJson = """{
        "id": "minimal-venue",
        "name": "Minimal Venue",
        "tilesUrl": "https://example.com/tiles/",
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
        },
        "defaultFloor": 0,
        "venueInfo": {
          "name": "Minimal Venue Info"
        }
      }""";

      final minimalVenue = MPVenue.fromJson(jsonDecode(minimalVenueJson));
      expect(minimalVenue, isNotNull);
      expect(minimalVenue?.name, "Minimal Venue Info");
      expect(minimalVenue?.mapStyles, isEmpty);
      expect(minimalVenue?.defaultMapStyle, isNull);
      expect(minimalVenue?.entryPoints, isEmpty);
      expect(minimalVenue?.externalId, isNull);
      expect(minimalVenue?.graphId, isNull);
    });

    test("Venue with no map styles", () {
      final noStylesJson = venueJsonString.replaceAll(
          RegExp(r'"styles":\s*\[[^\]]*\]'), '"styles": null');

      final venueNoStyles = MPVenue.fromJson(jsonDecode(noStylesJson));
      expect(venueNoStyles, isNotNull);
      expect(venueNoStyles?.mapStyles, isEmpty);
      expect(venueNoStyles?.defaultMapStyle, isNull);

      // Test map style validation with null styles
      final testStyle =
          MPMapStyle.fromJson({"folder": "test", "displayName": "Test Style"});
      expect(venueNoStyles?.isMapStyleValid(testStyle!), false);
    });

    test("Map style with null data", () {
      final nullStyle = MPMapStyle.fromJson(null);
      expect(nullStyle, isNull);

      final nullStringStyle = MPMapStyle.fromJson("null");
      expect(nullStringStyle, isNull);
    });

    test("Map style toJson works correctly", () {
      final style = MPMapStyle.fromJson(
          {"folder": "test-folder", "displayName": "Test Display Name"});

      final json = style?.toJson();
      expect(json, isNotNull);
      expect(json?["folder"], "test-folder");
      expect(json?["displayName"], "Test Display Name");
    });
  });
}
