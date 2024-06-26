part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Special [MPDisplayRule]s that govern specific issues
enum MPSolutionDisplayRuleEnum {
  buildingOutline("buildingOutline"),
  selectionHighlight("selectionHighlight"),
  positionIndicator("positionIndicator"),
  selection("selection"),
  highlight("highlight");

  final String name;
  const MPSolutionDisplayRuleEnum(this.name);

  dynamic toJson() => name;
}
