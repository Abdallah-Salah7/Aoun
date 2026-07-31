import 'package:shared_preferences/shared_preferences.dart';

class DonationLocalStorage {
  Future<void> saveDonationImage(
      String title,
      String image,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "donation_$title",
      image,
    );
  }

  Future<String?> getDonationImage(
      String title,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      "donation_$title",
    );
  }

  Future<void> removeDonationImage(
      String title,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(
      "donation_$title",
    );
  }
}