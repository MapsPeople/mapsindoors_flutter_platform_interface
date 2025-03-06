# Changelog

## 4.1.4

### Fixed

* Removed a number of potential memory retentions in the iOS part of the Flutter plugin.

### Changed

* Updated Mapsindoors SDKs:
  * Android to 4.11.2
  * iOS to 4.9.5

## 4.1.3

### Changed

* Updated Mapsindoors SDKs:
  * iOS to 4.9.4

## 4.1.2

### Changed

* Updated Mapsindoors SDKs:
  * Android to 4.10.1
  * iOS to 4.9.2

## 4.1.1

### Fixed

* Fixed Android build issue

## 4.1.0

### Fixed

* Fixed error when parsing `MPRoute` objects

### Changed

* Updated Mapsindoors SDKs:
  * iOS to 4.8.3

## 4.0.2

### Changed

* Updated Mapsindoors SDKs:
  * Android to 4.9.1
  * iOS to 4.8.1

## 4.0.1

### Fixed

* Improved rendering performance of Mapbox Map view especially when pinch zooming.

### Changed

* Updated Mapsindoors SDKs:
  * iOS to 4.8.0


## 4.0.0

### Changed

* Replaced all uses of color-strings with `dart:ui` `Color` instead

## 3.1.3

* No changes

## 3.1.2

* No changes

## 3.1.1

### Fixed

* Fixed issue where camera events would not be propagated to the Flutter layer

## 3.1.0

### Added

* Added interface for disabling built-in compass

## 3.0.2

* No changes

## 3.0.1

* No changes

## 3.0.0

### Added

* Added `setHighlight` and `clearHighlight` to `MapControlWidget` which allows you to highlight a list of locations
* Added new `MPCameraViewFitMode`: `none`, which will disable automatic camera movement when changing legs
* Added `addExcludeWayType`, `clearExcludeWayType` to `MPDirectionsService` to allow the user to exclude specific `MPHighway`s when querying for a route.
* Added two new `MPSolutionDisplayRuleEnum`s `selection` and `highlight` that allows you to modify the look of highlighted and selected Locations.
* Added support for Flat and Graphic labels, as well as 3D models
* Added new setters and getters to `MPDisplayRule`:
  * `LabelStyleGraphic`
  * `LabelType`
  * `IconScale`
  * `IconPlacement`
  * `PolygonLightnessFactor`
  * `WallLightnessFactor`
  * `ExtrusionLightnessFactor`
  * `LabelStyleTextSize`
  * `LabelStyleTextColor`
  * `LabelStyleTextOpacity`
  * `LabelStyleHaloOpacity`
  * `LabelStyleHaloWidth`
  * `LabelStyleHaloBlur`
  * `LabelStyleBearing`
  * `BadgeVisibile`
  * `BadgeZoomFrom`
  * `BadgeZoomTo`
  * `BadgeRadius`
  * `BadgeStrokeWidth`
  * `BadgeStrokeColor`
  * `BadgeFillColor`
  * `BadgePosition`
  * `Model3DModel`
  * `Model3DRotationX`
  * `Model3DRotationY`
  * `Model3DrotationZ`
  * `Model3DScale`
  * `Model3DZoomFrom`
  * `Model3DZoomTo`
  * `Model3DVisible`
* Added functionality to hide specific features from the map
  * `setHiddenFeatures` set a list of `MPFeatureType` to be hidden from the map
  * `getHiddenFeatures` get a list of currently hidden `MPFeatureType`
* Added optional venue loading, use loadMapsIndoorsWithVenues(key, venueIds) to load a specific set of venues
  * Venues can be added and removed from load at any time by using `addVenueToSync(venueId)` and `removeVenueToSync(venueId)`
  * Track the status of venues by adding a listener with `addOnVenueStatusChangedListener(MPVenueStatusListener)`
  * Get a list of synced venues with `getSyncedVenues()`
* Added functionality to disable automatic floor and building selection when moving the map
  * `setBuildingSelectionMode` set a Selection mode for Buildings on the map with `MPSelectionMode` (`automatic` or `manual`)
  * `setFloorSelectionMode` set a Selection mode for Floors on the map with `MPSelectionMode` (`automatic` or `manual`)
* Added functionality to make locations `selectable`.
  * This setting can be found on `MPLoction`, `MPPOIType` and `MPSolutionConfig`
  * Added `MPPOIType` which can be fetched from `MPSolution`
* Added `mapsIndoorsTransitionLevel` to MapsIndoorsWidget ctor
  * Sets the zoom level at which the MapsIndoors data should show, instead of extruded buildings on Mapbox Maps. Can be set to 0, if extruded buildings should not show.
* Added multi-stop navigation: It is now possible to add multiple stops to routes.
  * The existing `getRoute` method gets two optional parameters `stops` and `optimize`
  * `stops` will add the stops to the route between the `origin` and `destination`
  * `optimize` will rearrange the `stops` to make a more optimal route, but `origin` and `destination` will stay the same.
* Updated Mapsindoors SDKs:
  * Android to 4.8.5
  * iOS to 4.5.7

### Deprecated

* Deprecated `clearWayType`: use `clearAvoidWayType` instead

## 2.1.6

* Updated to Mapsindoors iOS SDK 4.3.11 with proper Privacy Manifests

## 2.1.5

* Updated Mapsindoors SDKs
  * Android to 4.4.1
  * iOS to 4.3.8

## 2.1.4

* No change

## 2.1.3

* No change

## 2.1.2

* No change

## 2.1.1

* No change

## 2.1.0

* Added `showRouteLegButtons` to `MPDirectionsRenderer`
* Added `setLabelOptions` to `MapsindoorsWidget`

## 2.0.1

* RETRACTED

## 2.0.0

* Removed MPMapConfig as MapControl is now configured through the Widget
* Removed MapControlInterface as it is no longer needed
* Formatted entire project to be in line with dart formatting guidelines

## 1.0.0

* Release
