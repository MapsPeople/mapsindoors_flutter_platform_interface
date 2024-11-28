part of 'package:mapsindoors_platform_interface/platform_library.dart';

@immutable
class DynamicObjectId {
  /// Creates an immutable object in MapsIndoors.
  const DynamicObjectId(this.value);

  /// The value of the id.
  final String value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DynamicObjectId && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return '${objectRuntimeType(this, 'MapsObjectId')}($value)';
  }
}

extension StringColorExtensions on String {
  Color toColor() {
    final value = _hexToInteger(substring(1));

    if (Platform.isAndroid) {
      // fetch from aRGB, this is built-in for Color
      return Color(value);
    } else {
      // fetch from RGBa
      final int red = (0xff000000 & value) >> 24;
      final int green = (0x00ff0000 & value) >> 16;
      final int blue = (0x0000ff00 & value) >> 8;
      final int alpha = (0x000000ff & value) >> 0;
      // parse to aRGB
      return Color((alpha << 24) + (red << 16) + (green << 8) + (blue << 0));
    }
  }
}

int _hexToInteger(String hex) => int.parse(hex, radix: 16);

extension ColorStringExtensions on Color {
  String toRGBString() {
    if (Platform.isAndroid) {
      // aRGB for Android
      return '#${((alpha << 24) + (red << 16) + (green << 8) + (blue << 0)).toRadixString(16).padLeft(8, '0')}';
    } else {
      // RGBa for iOS
      return '#${((red << 24) + (green << 16) + (blue << 8) + (alpha << 0)).toRadixString(16).padLeft(8, '0')}';
    }
  }
}

abstract class DynamicObject<T extends DynamicObjectId> {
  const DynamicObject();
  T get id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DynamicObject && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

abstract class MapsIndoorsObject {
  const MapsIndoorsObject();
  Map<String, dynamic> toJson();
  String _jsonEncode() => jsonEncode(toJson());
}

/// for use with MapsIndoors objects
List<T> convertMIList<T>(List<dynamic> data, T? Function(dynamic) fromJson) {
  final List<T> list = List.empty(growable: true);
  for (final item in data) {
    final T? convert = fromJson(item);
    if (convert != null) {
      list.add(convert);
    }
  }
  return list;
}

/// for use with MapsIndoors objects
List<T>? convertNullableMIList<T>(
    List<dynamic>? data, T? Function(dynamic) fromJson) {
  if (data == null) {
    return null;
  }
  final List<T> list = List.empty(growable: true);
  for (final item in data) {
    final T? convert = fromJson(item);
    if (convert != null) {
      list.add(convert);
    }
  }
  return list;
}

String convertMIListToJson(List<MapsIndoorsObject> objects) {
  return jsonEncode(List.from(objects.map((e) => e.toJson())));
}

/// for use with dart default types
List<T> convertJsonArray<T>(List<dynamic> json) {
  return json.map((e) => e as T).toList();
}

/// for use with dart default types
List<List<T>> convertJson2dArray<T>(List<dynamic> json) {
  return json.map((e) {
    if (e is List<dynamic>) {
      return convertJsonArray<T>(e);
    } else {
      return [] as List<T>;
    }
  }).toList();
}

/// for use with dart default types
List<List<List<T>>> convertJson3dArray<T>(List<dynamic> json) {
  return json.map((e) {
    if (e is List<dynamic>) {
      return convertJson2dArray<T>(e);
    } else {
      return [] as List<List<T>>;
    }
  }).toList();
}

/// for use with dart default types
List<List<List<List<T>>>> convertJson4dArray<T>(List<dynamic> json) {
  return json.map((e) {
    if (e is List<dynamic>) {
      return convertJson3dArray<T>(e);
    } else {
      return [] as List<List<List<T>>>;
    }
  }).toList();
}
