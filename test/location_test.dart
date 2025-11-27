import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';

void main() {
  final locationJsonString = """{
        "id": "0f3512052d67483e9f7bc13c",
        "type": "Feature",
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
        "properties": {
            "name": "East Wing 2",
            "aliases": ["name1", "name2"],
            "categories": {
                "Dining Room": "Dining Room",
                "Diningroom": "Diningroom"
            },
            "floor": "10",
            "floorName": "one",
            "building": "STIGSBORGVEJ",
            "venue": "STIGSBORGVEJ",
            "type": "MeetingRoom",
            "imageURL": null,
            "locationType": "room",
            "mapElement": "active",
            "anchor": {
                "coordinates": [
                    9.9508382,
                    57.0581919
                ],
                "type": "Point"
            },
            "status": 3,
            "locationSettings": {
                "selectable": true
            },
            "displayRule": null,
            "externalId": "1.34.01",
            "description": "description",
            "activeFrom": 1640995200,
            "activeTo": 1672531200,
            "bookable": true,
            "contact": {
                "email": {
                    "text": "Email",
                    "type": "email",
                    "value": "contact@eastwtng.com"
                },
                "phone": {
                    "text": "Phone",
                    "type": "phone",
                    "value": "+45 12 34 56 78"
                }
            },
            "fields": {
                "capacity": {
                    "text": "Capacity",
                    "type": "text",
                    "value": "1"
                }
            },
            "additionalDetails": [
                {
                    "key": "url-1",
                    "detailType": "url",
                    "value": "https://www.dining.com",
                    "icon": "https://app.mapsindoors.com/mapsindoors/cms/assets/icons/misc/mi-icon-link.png",
                    "active": true,
                    "displayText": "The best restaurant in the building",
                    "openingHours": null
                },
                {
                    "key": "email-1",
                    "detailType": "email",
                    "value": "dining@room.com",
                    "icon": "https://app.mapsindoors.com/mapsindoors/cms/assets/icons/misc/mi-icon-email.png",
                    "active": false,
                    "displayText": "",
                    "openingHours": null
                },
                {
                    "key": "phone-1",
                    "detailType": "phone",
                    "value": "0118 999 881 999 119 725 3",
                    "icon": "https://app.mapsindoors.com/mapsindoors/cms/assets/icons/misc/mi-icon-phone.png",
                    "active": true,
                    "displayText": "Emergency Number",
                    "openingHours": null
                },
                {
                    "key": "openinghours-1",
                    "detailType": "openinghours",
                    "value": null,
                    "icon": "https://app.mapsindoors.com/mapsindoors/cms/assets/icons/misc/mi-icon-opening-hours.png",
                    "active": false,
                    "displayText": "Opening Hours",
                    "openingHours": {
                        "standardOpeningHours": {
                            "monday": {
                                "closedAllDay": true,
                                "startTime": null,
                                "endTime": null
                            },
                            "tuesday": {
                                "closedAllDay": false,
                                "startTime": "22:29",
                                "endTime": "10:29"
                            },
                            "wednesday": {
                                "closedAllDay": false,
                                "startTime": "02:30",
                                "endTime": "16:30"
                            },
                            "thursday": {
                                "closedAllDay": true,
                                "startTime": null,
                                "endTime": null
                            },
                            "friday": {
                                "closedAllDay": true,
                                "startTime": null,
                                "endTime": null
                            },
                            "saturday": {
                                "closedAllDay": true,
                                "startTime": null,
                                "endTime": null
                            },
                            "sunday": null
                        }
                    }
                }
            ]
        }
    }""";

  group("LOCATION PARSE", () {
    MPLocation? location = null;
    try {
      location = MPLocation.fromJson(jsonDecode(locationJsonString));
    } catch (e) {}
    ;

    test("Location is not null", () {
      expect(location, isNotNull);
    });

    test("Location id is correct", () {
      expect(location?.id.value, "0f3512052d67483e9f7bc13c");
    });

    test("Location name is correct", () {
      expect(location?.name, "East Wing 2");
    });

    test("Location aliases are correct", () {
      expect(location?.aliases, ["name1", "name2"]);
    });

    test("Location description is correct", () {
      expect(location?.description, "description");
    });

    test("Location categories are correct", () {
      expect(location?.categories?.length, 2);
      expect(location?.categories?[0], "Dining Room");
      expect(location?.categories?[1], "Diningroom");
    });

    test("Location floor index is correct", () {
      expect(location?.floorIndex, 10);
    });

    test("Location floor name is correct", () {
      expect(location?.floorName, "one");
    });

    test("Location building name is correct", () {
      expect(location?.buildingName, "STIGSBORGVEJ");
    });

    test("Location venue name is correct", () {
      expect(location?.venueName, "STIGSBORGVEJ");
    });

    test("Location type name is correct", () {
      expect(location?.typeName, "MeetingRoom");
    });

    test("Location external id is correct", () {
      expect(location?.externalId, "1.34.01");
    });

    test("Location point is correct", () {
      expect(location?.point.latitude, closeTo(57.0581919, 0.000001));
      expect(location?.point.longitude, closeTo(9.9508382, 0.000001));
      expect(location?.point.floorIndex, 10);
    });

    test("Location additional url details are correct", () {
      expect(location?.additionalDetails?.length, 4);

      var urlDetail = location?.getAdditionalDetailByType(MPDetailType.url);
      expect(urlDetail, isNotNull);
      expect(urlDetail?.key, "url-1");
      expect(urlDetail?.value, "https://www.dining.com");
      expect(urlDetail?.icon,
          "https://app.mapsindoors.com/mapsindoors/cms/assets/icons/misc/mi-icon-link.png");
      expect(urlDetail?.active, true);
      expect(urlDetail?.displayText, "The best restaurant in the building");
      expect(urlDetail?.openingHours, isNull);
    });
    test("Location additional email details are correct", () {
      var emailDetail = location?.getAdditionalDetailByType(MPDetailType.email);
      expect(emailDetail, isNotNull);
      expect(emailDetail?.key, "email-1");
      expect(emailDetail?.value, "dining@room.com");
      expect(emailDetail?.icon,
          "https://app.mapsindoors.com/mapsindoors/cms/assets/icons/misc/mi-icon-email.png");
      expect(emailDetail?.active, false);
      expect(emailDetail?.displayText, "");
      expect(emailDetail?.openingHours, isNull);
    });
    test("Location additional phone details are correct", () {
      var phoneDetail = location?.getAdditionalDetailByType(MPDetailType.phone);
      expect(phoneDetail, isNotNull);
      expect(phoneDetail?.key, "phone-1");
      expect(phoneDetail?.value, "0118 999 881 999 119 725 3");
      expect(phoneDetail?.icon,
          "https://app.mapsindoors.com/mapsindoors/cms/assets/icons/misc/mi-icon-phone.png");
      expect(phoneDetail?.active, true);
      expect(phoneDetail?.displayText, "Emergency Number");
      expect(phoneDetail?.openingHours, isNull);
    });

    test("Location additional opening hours details are correct", () {
      var openingHoursDetail =
          location?.getAdditionalDetailByType(MPDetailType.openingHours);
      expect(openingHoursDetail, isNotNull);
      expect(openingHoursDetail?.key, "openinghours-1");
      expect(openingHoursDetail?.value, isNull);
      expect(openingHoursDetail?.icon,
          "https://app.mapsindoors.com/mapsindoors/cms/assets/icons/misc/mi-icon-opening-hours.png");
      expect(openingHoursDetail?.active, false);
      expect(openingHoursDetail?.displayText, "Opening Hours");
      expect(openingHoursDetail?.openingHours, isNotNull);
      expect(
          openingHoursDetail
              ?.openingHours?.standardOpeningHours?.monday?.closedAllDay,
          true);
      expect(
          openingHoursDetail
              ?.openingHours?.standardOpeningHours?.tuesday?.closedAllDay,
          false);
      expect(
          openingHoursDetail
              ?.openingHours?.standardOpeningHours?.tuesday?.startTime,
          "22:29");
      expect(
          openingHoursDetail
              ?.openingHours?.standardOpeningHours?.tuesday?.endTime,
          "10:29");
      expect(
          openingHoursDetail
              ?.openingHours?.standardOpeningHours?.wednesday?.closedAllDay,
          false);
      expect(
          openingHoursDetail
              ?.openingHours?.standardOpeningHours?.wednesday?.startTime,
          "02:30");
      expect(
          openingHoursDetail
              ?.openingHours?.standardOpeningHours?.wednesday?.endTime,
          "16:30");
      expect(
          openingHoursDetail
              ?.openingHours?.standardOpeningHours?.thursday?.closedAllDay,
          true);
      expect(
          openingHoursDetail
              ?.openingHours?.standardOpeningHours?.friday?.closedAllDay,
          true);
      expect(
          openingHoursDetail
              ?.openingHours?.standardOpeningHours?.saturday?.closedAllDay,
          true);
      expect(openingHoursDetail?.openingHours?.standardOpeningHours?.sunday,
          isNull);
    });

    test("Location geometry and bounds are correct", () {
      expect(location?.isPoint, false);
      expect(location?.bounds, isNotNull);
    });

    test("Location ID properties are correct", () {
      expect(location?.locationId, "0f3512052d67483e9f7bc13c");
    });

    test("Location base type is correct", () {
      expect(location?.baseType, MPLocationType.room);
    });

    test("Location active time properties work correctly", () {
      expect(location?.activeFrom, 1640995200);
      expect(location?.activeTo, 1672531200);
    });

    test("Location image URL is correct", () {
      expect(location?.imageUrl, isNull);
    });

    test("Location restrictions are correct", () {
      expect(location?.restrictions, isNull);
    });

    test("Location selectable property works correctly", () {
      expect(location?.selectable, true);
    });

    test("Location bookable property is correct", () {
      expect(location?.isBookable, true);
    });

    test("Location contact information is correct", () {
      final emailContact =
          location?.getProperty(MPLocationPropertyNames.contact);
      expect(emailContact, isNotNull);
      expect(emailContact, isA<Map<String, MPDataField>>());

      final contactMap = emailContact as Map<String, MPDataField>?;

      final emailField = contactMap?["email"];
      expect(emailField, isNotNull);
      expect(emailField?.text, "Email");
      expect(emailField?.type, "email");
      expect(emailField?.value, "contact@eastwtng.com");

      final phoneField = contactMap?["phone"];
      expect(phoneField, isNotNull);
      expect(phoneField?.text, "Phone");
      expect(phoneField?.type, "phone");
      expect(phoneField?.value, "+45 12 34 56 78");
    });

    test("Location getProperty method works correctly", () {
      expect(
          location?.getProperty(MPLocationPropertyNames.name), "East Wing 2");
      expect(location?.getProperty(MPLocationPropertyNames.description),
          "description");
      expect(
          location?.getProperty(MPLocationPropertyNames.externalId), "1.34.01");
      expect(
          location?.getProperty(MPLocationPropertyNames.type), "MeetingRoom");
      expect(location?.getProperty(MPLocationPropertyNames.building),
          "STIGSBORGVEJ");
      expect(
          location?.getProperty(MPLocationPropertyNames.venue), "STIGSBORGVEJ");
      expect(location?.getProperty(MPLocationPropertyNames.floor), 10);
      expect(location?.getProperty(MPLocationPropertyNames.floorName), "one");
      expect(location?.getProperty(MPLocationPropertyNames.activeFrom),
          1640995200);
      expect(
          location?.getProperty(MPLocationPropertyNames.activeTo), 1672531200);
      expect(location?.getProperty(MPLocationPropertyNames.bookable), true);
      expect(location?.getProperty(MPLocationPropertyNames.contact), isNotNull);
    });

    test("Location equality works correctly", () {
      final location1 = MPLocation.fromJson(jsonDecode(locationJsonString));
      final location2 = MPLocation.fromJson(jsonDecode(locationJsonString));

      expect(location1 == location2, true);
      expect(location1.hashCode == location2.hashCode, true);

      // Test with different location
      final differentLocationJson = locationJsonString.replaceAll(
          '"id": "0f3512052d67483e9f7bc13c"', '"id": "different-location-id"');
      final differentLocation =
          MPLocation.fromJson(jsonDecode(differentLocationJson));

      expect(location1 == differentLocation, false);
      expect(location1.hashCode == differentLocation.hashCode, false);
    });

    test("Location toJson works correctly", () {
      final json = location?.toJson();
      expect(json, isNotNull);
      expect(json?["id"], "0f3512052d67483e9f7bc13c");
    });
  });

  group("LOCATION EDGE CASES", () {
    test("Location with null/empty data", () {
      final nullLocation = MPLocation.fromJson(null);
      expect(nullLocation, isNull);

      final nullStringLocation = MPLocation.fromJson("null");
      expect(nullStringLocation, isNull);
    });

    test("Location with minimal data", () {
      final minimalLocationJson = """{
        "id": "minimal-location",
        "type": "Feature",
        "geometry": {
          "coordinates": [0, 0],
          "type": "Point"
        },
        "properties": {
          "name": "minimal"
        }
      }""";

      final minimalLocation =
          MPLocation.fromJson(jsonDecode(minimalLocationJson));
      expect(minimalLocation, isNotNull);
      expect(minimalLocation?.name, "minimal");
      expect(minimalLocation?.aliases, isNull);
      expect(minimalLocation?.description, isNull);
      expect(minimalLocation?.categories, isNull);
      expect(minimalLocation?.externalId, "");
      expect(minimalLocation?.isBookable, false);
      expect(minimalLocation?.baseType, MPLocationType.poi); // Default type
      expect(minimalLocation?.floorIndex,
          2147483647); // Error code for missing floor
    });

    test("Location with no additional details", () {
      final noDetailsJson = locationJsonString.replaceAll(
          RegExp(r'"additionalDetails":\s*\[[^\]]*\]'),
          '"additionalDetails": null');

      final locationNoDetails = MPLocation.fromJson(jsonDecode(noDetailsJson));
      expect(locationNoDetails, isNotNull);
      expect(locationNoDetails?.additionalDetails, isNull);

      final urlDetail =
          locationNoDetails?.getAdditionalDetailByType(MPDetailType.url);
      expect(urlDetail, isNull);
    });

    test("Location with no geometry", () {
      final noGeometryJson = locationJsonString.replaceAll(
          RegExp(r'"geometry":\s*{[^}]*}'), '"geometry": null');

      final locationNoGeometry =
          MPLocation.fromJson(jsonDecode(noGeometryJson));
      expect(locationNoGeometry, isNotNull);
      expect(locationNoGeometry?.isPoint, false);
      expect(
          locationNoGeometry?.point, isNotNull); // Should return empty MPPoint
    });

    test("Location with different geometry types", () {
      // Test with Point geometry
      final pointLocationJson = """{
        "id": "point-location",
        "type": "Feature",
        "geometry": {
          "coordinates": [9.9508382, 57.0581919],
          "type": "Point"
        },
        "properties": {
          "name": "Point Location",
          "anchor": {
            "coordinates": [9.9508382, 57.0581919],
            "type": "Point"
          },
          "floor": "1"
        }
      }""";

      final pointLocation = MPLocation.fromJson(jsonDecode(pointLocationJson));
      expect(pointLocation, isNotNull);
      expect(pointLocation?.isPoint, true);
    });

    test("Location with different base types", () {
      final areaLocationJson = locationJsonString.replaceAll(
          '"locationType": "room"', '"locationType": "area"');
      final areaLocation = MPLocation.fromJson(jsonDecode(areaLocationJson));
      expect(areaLocation?.baseType, MPLocationType.area);

      final venueLocationJson = locationJsonString.replaceAll(
          '"locationType": "room"', '"locationType": "venue"');
      final venueLocation = MPLocation.fromJson(jsonDecode(venueLocationJson));
      expect(venueLocation?.baseType, MPLocationType.venue);

      final buildingLocationJson = locationJsonString.replaceAll(
          '"locationType": "room"', '"locationType": "building"');
      final buildingLocation =
          MPLocation.fromJson(jsonDecode(buildingLocationJson));
      expect(buildingLocation?.baseType, MPLocationType.building);

      final floorLocationJson = locationJsonString.replaceAll(
          '"locationType": "room"', '"locationType": "floor"');
      final floorLocation = MPLocation.fromJson(jsonDecode(floorLocationJson));
      expect(floorLocation?.baseType, MPLocationType.floor);

      final assetLocationJson = locationJsonString.replaceAll(
          '"locationType": "room"', '"locationType": "asset"');
      final assetLocation = MPLocation.fromJson(jsonDecode(assetLocationJson));
      expect(assetLocation?.baseType, MPLocationType.asset);

      final poiLocationJson = locationJsonString.replaceAll(
          '"locationType": "room"', '"locationType": "poi"');
      final poiLocation = MPLocation.fromJson(jsonDecode(poiLocationJson));
      expect(poiLocation?.baseType, MPLocationType.poi);
    });

    test("Location with null bookable property", () {
      final nullBookableLocationJson = locationJsonString.replaceAll(
          '"bookable": true,', '"bookable": null,');

      final nullBookableLocation =
          MPLocation.fromJson(jsonDecode(nullBookableLocationJson));
      expect(nullBookableLocation?.isBookable, false); // Default when null
    });

    test("Location with null active time properties", () {
      final nullActiveTimeLocationJson = locationJsonString.replaceAll(
          '"activeFrom": 1640995200,\n            "activeTo": 1672531200,',
          '"activeFrom": null,\n            "activeTo": null,');

      final nullActiveTimeLocation =
          MPLocation.fromJson(jsonDecode(nullActiveTimeLocationJson));
      expect(nullActiveTimeLocation?.activeFrom, isNull);
      expect(nullActiveTimeLocation?.activeTo, isNull);
    });

    test("Location with image URL", () {
      final imageLocationJson = locationJsonString.replaceAll(
          '"imageURL": null,', '"imageURL": "https://example.com/image.jpg",');

      final imageLocation = MPLocation.fromJson(jsonDecode(imageLocationJson));
      expect(imageLocation?.imageUrl, "https://example.com/image.jpg");
    });

    test("Location with restrictions", () {
      final restrictionsLocationJson = locationJsonString.replaceAll(
          '"id": "0f3512052d67483e9f7bc13c",',
          '"id": "0f3512052d67483e9f7bc13c",\n        "restrictions": ["wheelchair_accessible", "no_smoking"],');

      final restrictionsLocation =
          MPLocation.fromJson(jsonDecode(restrictionsLocationJson));
      expect(restrictionsLocation?.restrictions?.length, 2);
      expect(restrictionsLocation?.restrictions?[0], "wheelchair_accessible");
      expect(restrictionsLocation?.restrictions?[1], "no_smoking");
    });

    test("Location with no categories", () {
      final noCategoriesJson = locationJsonString.replaceAll(
          RegExp(r'"categories":\s*{[^}]*}'), '"categories": null');

      final locationNoCategories =
          MPLocation.fromJson(jsonDecode(noCategoriesJson));
      expect(locationNoCategories, isNotNull);
      expect(locationNoCategories?.categories, isNull);
    });

    test("Location with empty categories", () {
      final emptyCategoriesJson = locationJsonString.replaceAll(
          RegExp(r'"categories":\s*{[^}]*}'), '"categories": {}');

      final locationEmptyCategories =
          MPLocation.fromJson(jsonDecode(emptyCategoriesJson));
      expect(locationEmptyCategories, isNotNull);
      expect(locationEmptyCategories?.categories, isEmpty);
    });

    test("Location property getter with all properties", () {
      final location = MPLocation.fromJson(jsonDecode(locationJsonString));

      // Test all available properties
      expect(location?.getProperty(MPLocationPropertyNames.aliases),
          ["name1", "name2"]);
      expect(location?.getProperty(MPLocationPropertyNames.categories),
          isA<Map>());
      expect(location?.getProperty(MPLocationPropertyNames.anchor), isNotNull);
      expect(location?.getProperty(MPLocationPropertyNames.activeFrom),
          1640995200);
      expect(
          location?.getProperty(MPLocationPropertyNames.activeTo), 1672531200);
      expect(location?.getProperty(MPLocationPropertyNames.contact), isNotNull);
      expect(location?.getProperty(MPLocationPropertyNames.fields), isNotNull);
      expect(location?.getProperty(MPLocationPropertyNames.imageURL), isNull);
      expect(
          location?.getProperty(MPLocationPropertyNames.locationType), "room");
      expect(location?.getProperty(MPLocationPropertyNames.bookable), true);
      expect(location?.getProperty(MPLocationPropertyNames.roomId), "1.34.01");
    });
  });
}
