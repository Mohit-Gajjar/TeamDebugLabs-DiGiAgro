import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  static String sharedPrefsCropSelectedKey = "SELECTED";
  static String sharedPrefsSavedCropSelectedKey = "SAVED";
  static String sharedPrefsViewedCropSelectedKey = "VIEWED";

  static Future<bool> saveCropIsSelectedSharedPrefs(bool isSelected) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPrefsSavedCropSelectedKey, isSelected);
  }

  static Future<bool> saveViewedPageSelectedSharedPrefs(bool isViewed) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPrefsViewedCropSelectedKey, isViewed);
  }

  static Future<bool?> getSavedIsCropsSelectedSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPrefsSavedCropSelectedKey);
  }

  static Future<bool?> getViewedPageSelectedSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPrefsViewedCropSelectedKey);
  }

  static Future<bool> saveCropSharedPrefs(String crop) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefsCropSelectedKey, crop);
  }

  static Future<String?> getSavedCropSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPrefsCropSelectedKey);
  }
}
