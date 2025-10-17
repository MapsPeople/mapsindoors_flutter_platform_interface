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
            "locationSettings": null,
            "displayRule": null,
            "externalId": "1.34.01",
            "description": "description",
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
  });
}
