part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Represents additional details associated with a MapIndoors entity, such as a location or a point of interest.
/// This class contains various fields that provide information about the additional details.
class MPAdditionalDetail extends MapsIndoorsObject {
  /// The type of detail, e.g. "phone", "email", "website", etc.
  final MPDetailType? detailType;

  /// The key for the additional detail, which is typically a string identifier.
  final String? key;

  /// The value of the additional detail, which can be a string representing
  final String? value;

  /// The icon associated with the additional detail, which is a URL.
  final String? icon;

  /// The display text for the additional detail, which is a localized user-friendly string.
  final String? displayText;

  /// Indicates whether the additional detail is active or not.
  final bool? active;

  /// The opening hours associated with the additional detail, represented by an [MPOpeningHours] object.
  final MPOpeningHours? openingHours;

  MPAdditionalDetail({
    this.detailType,
    this.key,
    this.value,
    this.icon,
    this.displayText,
    this.active,
    this.openingHours,
  });

  static MPAdditionalDetail? fromJson(json) => json != null && json != "null"
      ? MPAdditionalDetail._fromJson(json is String ? jsonDecode(json) : json)
      : null;

  MPAdditionalDetail._fromJson(data)
      : detailType = data["detailType"] != null
            ? MPDetailType.fromString(data["detailType"])
            : null,
        key = data["key"],
        value = data["value"],
        icon = data["icon"],
        displayText = data["displayText"],
        active = data["active"],
        openingHours = MPOpeningHours.fromJson(data["openingHours"]);

  @override
  String toString() {
    return 'MPAdditionalDetail{detailType: $detailType, key: $key, value: $value, icon: $icon, displayText: $displayText, active: $active, openingHours: $openingHours}';
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "detailType": detailType?.toJson(),
      "key": key,
      "value": value,
      "icon": icon,
      "displayText": displayText,
      "active": active,
      "openingHours": openingHours?.toJson(),
    };
  }
}
