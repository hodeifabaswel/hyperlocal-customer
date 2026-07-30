import 'package:flutter/foundation.dart' show kDebugMode;

const String kBuildType = kDebugMode ? 'debug' : 'release';
const String kDeepLinkScheme = 'hcust';
const String kBundleId = 'com.hyperlocal.customer';

/// Tile server URL — berbeda per environment.
const String kTileUrl = String.fromEnvironment(
  'TILE_URL',
  defaultValue: 'http://tile-server:8080/{z}/{x}/{y}.png',
);
