
import 'package:aoun/feature/data/models/zakat_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {


  static final Dio aiDio = Dio(
    BaseOptions(
      baseUrl: "https://abdallah-salah-aoun-ai-engine.hf.space",
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      },
    ),
  );

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://aounplatform.runasp.net',
      headers: {'Content-Type': 'application/json'},
    ),
  )
    ..interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  static Future<String> askCharityAI({
    required String question,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final email = prefs.getString("email") ?? "";
    final password = prefs.getString("password") ?? "";

    print("EMAIL = $email");
    print("PASSWORD = $password");

    final body = {
      "question": question,
      "email": email,
      "password": password,
    };

    print("REQUEST = $body");

    try {
      final response = await aiDio.post(
        "/api/ai/charity-chat",
        data: body,
      );

      print("STATUS = ${response.statusCode}");
      print("RESPONSE = ${response.data}");

      return response.data["answer"];
    } on DioException catch (e) {
      print("STATUS = ${e.response?.statusCode}");
      print("ERROR = ${e.response?.data}");
      print("MESSAGE = ${e.message}");

      rethrow;
    }
  }
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

  /// Charity Report
  static Future<Response> getCharityDashboard() async {
    return await dio.get('/api/charity/dashboard');
  }

  /// Change Password
  static Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await dio.put(
      '/api/Profile/change-password',
      data: {"currentPassword": currentPassword, "newPassword": newPassword},
    );
  }

  static Future<Response> getCharityDetails(int charityId) async {
    return await dio.get('/api/Admin/charities/$charityId');
  }

  static Future<Response> updateCharityStatus({
    required int charityId,
    required String status,
  }) async {
    return await dio.put(
      '/api/Admin/charities/$charityId/status',
      data: {"status": status},
    );
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

  Future<String?> getCharityToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("charityToken");
  }

  /// ================= Donor =================
  static Future<Response> searchCases({required String keyword}) async {
    return await dio.get(
      "/api/Cases/search",
      queryParameters: {
        "status": "all",
        "keyword": keyword,
        "page": 1,
        "pageSize": 10,
      },
    );
  }

  static Future<Response> getNotifications() async {
    return await dio.get('/api/Notifications');
  }

  static Future<Response> createDonation({
    required String donorName,
    required double amount,
    required int targetId,
    required String targetType,
  }) {
    return dio.post(
      "/api/Donations",
      data: {
        "donorName": donorName,
        "amount": amount,
        "targetType": targetType,
        "targetId": targetId,
        "isGift": false,
        "giftReceiverName": "",
        "giftReceiverPhone": "",
        "giftMessage": "",
      },
    );
  }

  static Future<Response> payDonation({
    required int donationId,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
    required String cardHolderName,
  }) {
    return dio.post(
      "/api/Donations/pay",
      data: {
        "donationId": donationId,
        "paymentMethod": "credit",
        "cardNumber": cardNumber,
        "expiryDate": expiryDate,
        "cvv": cvv,
        "cardHolderName": cardHolderName,
      },
    );
  }

  Future<Map<String, dynamic>> calculateZakat(ZakatModel request) async {
    final response = await dio.post(
      '/api/zakat/calculate',
      data: request.toJson(),
    );

    return response.data;
  }
}
