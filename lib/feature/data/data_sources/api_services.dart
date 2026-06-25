import 'package:aoun/feature/data/models/zakat_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://aounplatform.runasp.net',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  /// ================= INIT TOKEN =================
  static Future<void> setToken(String token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static Future<void> loadSavedToken() async {
    final prefs = await SharedPreferences.getInstance();

    final token =
        prefs.getString("charityToken") ??
            prefs.getString("donorToken") ??
            prefs.getString("adminToken");

    if (token != null) {
      await setToken(token);
    }
  }

  /// ================= AUTH =================
  static Future<Response> register({required Map<String, dynamic> data}) async {
    return await dio.post('/api/Auth/register', data: data);
  }

  static Future<Response> login({required Map<String, dynamic> data}) async {
    return await dio.post('/api/Auth/login', data: data);
  }

  /// ================= CHARITY =================
  static Future<Response> completeProfile({
    required Map<String, dynamic> data,
  }) async {
    return await dio.post('/api/Charity/complete-profile', data: data);
  }

  static Future<Response> uploadDocuments({
    required File registrationCertificate,
    required File taxCard,
    required File bankAccountProof,
    required File nationalId,
  }) async {
    FormData formData = FormData.fromMap({
      "RegistrationCertificate": await MultipartFile.fromFile(
        registrationCertificate.path,
      ),
      "TaxCard": await MultipartFile.fromFile(taxCard.path),
      "BankAccountProof": await MultipartFile.fromFile(bankAccountProof.path),
      "NationalId": await MultipartFile.fromFile(nationalId.path),
    });

    return await dio.post('/api/Charity/upload-documents', data: formData);
  }

  /// Charity Status
  static Future<Response> getCharityStatus() async {
    return await dio.get('/api/Charity/status');
  }

  /// ================= TOKENS STORAGE =================
  static Future<String?> getDonorToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("donorToken");
  }

  static Future<String?> getAdminToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("adminToken");
  }



  Future<Map<String, dynamic>> calculateZakat(
      ZakatModel request,
      ) async {
    final response = await dio.post(
      '/api/zakat/calculate',
      data: request.toJson(),
    );

    return response.data;
  }
}
Future<String?> getCharityToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("charityToken");
}

