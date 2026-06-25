import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/data_sources/api_services.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  Future<void> changePassword() async {
    if (newPasswordController.text !=
        confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("كلمتا المرور غير متطابقتين"),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final token = await ApiServices.getDonorToken();

      final dio = Dio(
        BaseOptions(
          baseUrl: "https://aounplatform.runasp.net",
        ),
      );

      await dio.put(
        "/api/Profile/change-password",
        data: {
          "currentPassword":
          currentPasswordController.text,
          "newPassword": newPasswordController.text,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تم تغيير كلمة المرور بنجاح"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } on DioException catch (e) {
      String message = "حدث خطأ";

      if (e.response?.data != null) {
        message = e.response!.data.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        backgroundColor: Color(0xffE5EBE9),

        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "تغيير كلمة المرور",
              style: GoogleFonts.saira(
                fontWeight: FontWeight.w800,
                fontSize: 30,
                color: const Color(0xff255A41),
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 96.0, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormField(
                    controller: currentPasswordController,
                    label: "كلمة المرور الحالية",
                    hint: "أدخل كلمة المرور",
                    isPassword: true,
                    labelStyle: GoogleFonts.saira(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 25),
                  CustomFormField(
                    controller: newPasswordController,
                    label: "كلمة المرور",
                    hint: "أدخل كلمة المرور",
                    isPassword: true,
                    labelStyle: GoogleFonts.saira(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 25),
                  CustomFormField(
                    controller: confirmPasswordController,
                    label: "تأكيد كلمة المرور",
                    hint: "أعد إدخال كلمة المرور",
                    isPassword: true,
                    labelStyle: GoogleFonts.saira(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 120),
          
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2F674D),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                          onPressed: isLoading ? null : changePassword,
                          child: isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            "تغيير كلمة المرور",
                            style: GoogleFonts.manrope(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
          
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
