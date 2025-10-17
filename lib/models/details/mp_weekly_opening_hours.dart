part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Represents the opening hours for a week, with each day having its own set of opening hours.
/// This class is used to define the opening hours for a business or location, detailing the hours for each day of the week.
/// Each day is represented by an instance of [MPDailyOpeningHours], which contains the specific opening and closing times for that day.
class MPWeeklyOpeningHours extends MapsIndoorsObject {
  final MPDailyOpeningHours? monday;
  final MPDailyOpeningHours? tuesday;
  final MPDailyOpeningHours? wednesday;
  final MPDailyOpeningHours? thursday;
  final MPDailyOpeningHours? friday;
  final MPDailyOpeningHours? saturday;
  final MPDailyOpeningHours? sunday;

  MPWeeklyOpeningHours({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  static MPWeeklyOpeningHours? fromJson(json) => json != null && json != "null"
      ? MPWeeklyOpeningHours._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPWeeklyOpeningHours._fromJson(data)
      : monday = MPDailyOpeningHours.fromJson(data["monday"]),
        tuesday = MPDailyOpeningHours.fromJson(data["tuesday"]),
        wednesday = MPDailyOpeningHours.fromJson(data["wednesday"]),
        thursday = MPDailyOpeningHours.fromJson(data["thursday"]),
        friday = MPDailyOpeningHours.fromJson(data["friday"]),
        saturday = MPDailyOpeningHours.fromJson(data["saturday"]),
        sunday = MPDailyOpeningHours.fromJson(data["sunday"]);

  @override
  String toString() {
    var out = "WeeklyOpeningHours: { ";
    out += "${monday.toString()}, ";
    out += "${tuesday.toString()}, ";
    out += "${wednesday.toString()}, ";
    out += "${thursday.toString()}, ";
    out += "${friday.toString()}, ";
    out += "${saturday.toString()}, ";
    out += "${sunday.toString()} ";
    out += "}";
    return out;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "monday": monday?.toJson(),
      "tuesday": tuesday?.toJson(),
      "wednesday": wednesday?.toJson(),
      "thursday": thursday?.toJson(),
      "friday": friday?.toJson(),
      "saturday": saturday?.toJson(),
      "sunday": sunday?.toJson(),
    };
  }
}
