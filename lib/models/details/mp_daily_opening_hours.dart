part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Represents the opening hours for a single day, including whether the location is closed all day or has specific opening and closing times.
class MPDailyOpeningHours extends MapsIndoorsObject {
  /// Indicates whether the location is closed for the entire day.
  final bool? closedAllDay;

  /// The opening time for the day, represented as an ISO 8601 string.
  final String? startTime;

  /// The closing time for the day, represented as an ISO 8601 string.
  final String? endTime;

  static MPDailyOpeningHours? fromJson(json) => json != null && json != "null"
      ? MPDailyOpeningHours._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPDailyOpeningHours._fromJson(data)
      : closedAllDay = data["closedAllDay"],
        startTime = data["startTime"],
        endTime = data["endTime"];

  MPDailyOpeningHours({
    this.closedAllDay,
    this.startTime,
    this.endTime,
  });

  @override
  String toString() {
    return closedAllDay == true
        ? "Closed all day"
        : "Open from $startTime to $endTime";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "closedAllDay": closedAllDay,
      "startTime": startTime,
      "endTime": endTime,
    };
  }
}
