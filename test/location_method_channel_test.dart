import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MethodChannelLocation platform = MethodChannelLocation();
  const MethodChannel channel = MethodChannel('LocationMethodChannel');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      switch (call.method) {
        case "LOC_setLocationSettingsSelectable":
          {
            return jsonDecode(call.arguments["settings"])["selectable"] !=
                    null &&
                call.arguments["id"] != null;
          }
      }
      return null;
    });
  });

  group("LOCATION SETTINGS", () {
    test("setLocationSettingsSelectable", () async {
      await platform.setLocationSettingsSelectable(
          MPLocationId("id"), MPLocationSettings(selectable: true));
    });
  });
}
