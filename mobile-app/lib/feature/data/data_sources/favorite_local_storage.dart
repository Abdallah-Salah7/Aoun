import 'package:shared_preferences/shared_preferences.dart';

class FavoriteLocalStorage {
  /// حفظ صورة حملة
  Future<void> saveCampaignImage(int id, String image) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "campaign_image_$id",
      image,
    );
  }

  /// جلب صورة حملة
  Future<String?> getCampaignImage(int id) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      "campaign_image_$id",
    );
  }

  /// حذف صورة حملة
  Future<void> removeCampaignImage(int id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(
      "campaign_image_$id",
    );
  }

  /// حفظ صورة حالة
  Future<void> saveCaseImage(int id, String image) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "case_image_$id",
      image,
    );
  }

  /// جلب صورة حالة
  Future<String?> getCaseImage(int id) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      "case_image_$id",
    );
  }

  /// حذف صورة حالة
  Future<void> removeCaseImage(int id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(
      "case_image_$id",
    );
  }
}