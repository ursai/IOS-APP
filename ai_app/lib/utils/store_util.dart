import 'dart:io';

import 'package:app/contants/business_constants.dart';
import 'package:flustars/flustars.dart';
import 'package:get/get.dart';

class StoreUtil {
  static String currentVersion = '1.0.0';

  static bool isLogin() {
    return !ObjectUtil.isEmptyString(
        SpUtil.getString(BusinessConstants.tokenKey));
  }

  // 文件读取
  static Future<String> readFromFile(String filePath) async {
    try {
      File f = File(filePath);
      String str = await f.readAsString();

      return str;
    } catch (e) {
      e.printError();
      return '';
    }
  }

  static String? getFilterCategoryName() {
    return SpUtil.getString(BusinessConstants.marketCategoryNameFilterKey);
  }

  static int? getFilterSelectedRarity() {
    Map? data = SpUtil.getObject(BusinessConstants.marketRarityFilterKey);
    return data!["selectedRarity"];
  }

  static List<dynamic> getFilterSelectedRaritys() {
    Map? data = SpUtil.getObject(BusinessConstants.marketRarityFilterKey);
    return (data?["rarityFilter"] ?? []);
  }

  static List<dynamic> getFilterSelectedQualitys() {
    Map? data = SpUtil.getObject(BusinessConstants.marketQualityFilterKey);
    return (data?["selectedQuality"] ?? []);
  }

  static Map getNftLevelRangeValues() {
    Map data =
        SpUtil.getObject(BusinessConstants.marketLevelRangeFilterKey) ?? {};
    return data;
  }

  static Map getNftMineRangeValues() {
    Map data =
        SpUtil.getObject(BusinessConstants.marketMintRangeFilterKey) ?? {};
    return data;
  }

  static List<dynamic> getFilterEntitySelectedRaritys() {
    Map? data =
        SpUtil.getObject(BusinessConstants.marketEntityQualityFilterKey);
    return (data?["rarityEntityFilter"] ?? []);
  }

  static String getFilterCategoryNames(int pageIndex, int entityTabIndex) {
    String categoryName =
        SpUtil.getString(BusinessConstants.marketCategoryNameFilterKey) ?? '';
    if (categoryName == '通用系列') {
      if (pageIndex == 0 || entityTabIndex != 0) {
        categoryName = '全部';
      }
    }
    return categoryName;
  }
}
