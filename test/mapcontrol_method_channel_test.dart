import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapsindoors_platform_interface/platform_library.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MethodChannelMapControl platform = MethodChannelMapControl();
  const MethodChannel channel = MethodChannel('MapControlMethodChannel');
  const MethodChannel listener =
      MethodChannel('MapControlListenerMethodChannel');
  const MethodChannel floorSelector =
      MethodChannel('MapControlFloorSelectorChannel');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      switch (call.method) {
        case "MPC_getHiddenFeatures":
          return [1, 2, 4];
        case "MPC_setHiddenFeatures":
          return "success";
      }
      return null;
    });
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(listener, (MethodCall call) async {
      switch (call.method) {}
      return null;
    });
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(floorSelector, (MethodCall call) async {
      switch (call.method) {}
      return null;
    });
  });

  group("HIDDEN FEATURES", () {
    test("getHiddenFeatures", () async {
      var x = await platform.getHiddenFeatures();
      expect(x, [
        MPFeatureType.walls2D,
        MPFeatureType.model3D,
        MPFeatureType.extrusion3D
      ]);
      print("Expected value: ${[
        MPFeatureType.walls2D,
        MPFeatureType.model3D,
        MPFeatureType.extrusion3D
      ]}, Actual: ${x}");
    });
    test("setHiddenFeatures", () async {
      print("Set: ${[MPFeatureType.extrudedBuildings, MPFeatureType.model2D]}");
      await platform.setHiddenFeatures(
          [MPFeatureType.extrudedBuildings, MPFeatureType.model2D]);
      print("Set: ${[]}");
      await platform.setHiddenFeatures([]);
      print("Set: ${null}");
      await platform.setHiddenFeatures(null);
    });
  });
}
