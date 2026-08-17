import 'package:flutter/services.dart';
import 'package:health_data_hub/core/constants/app_assets.dart';

class AssetCatalog {
  AssetCatalog._();

  static Future<void> ensureDeclaredAssetsExist() async {
    for (final path in AppAssets.all) {
      await rootBundle.load(path);
    }
  }
}
