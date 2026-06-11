import 'package:dio/dio.dart';

class PaymentModel {

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://aounplatform.runasp.net/api/Donations',
    ),
  );

  static Future<Response> donate({
    required String donorName,
    required int amount,
    required String targetType,
    required int targetId,
    required bool isGift,
    String? giftReceiverName,
    String? giftReceiverPhone,
    String? giftMessage,
  }) async {

    return await dio.post(
      '/api/Donations',
      data: {

        "donorName": donorName,
        "amount": amount,
        "targetType": targetType,
        "targetId": targetId,
        "isGift": isGift,
        "giftReceiverName": giftReceiverName,
        "giftReceiverPhone": giftReceiverPhone,
        "giftMessage": giftMessage,
      },
    );
  }
}