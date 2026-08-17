import 'package:flutter_test/flutter_test.dart';
import 'package:health_data_hub/core/constants/app_assets.dart';
import 'package:health_data_hub/core/utils/asset_catalog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('declared Assignment 2 assets resolve from the asset bundle', () async {
    expect(AppAssets.all, isNotEmpty);
    await AssetCatalog.ensureDeclaredAssetsExist();
  });
}
