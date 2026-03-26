import 'package:aoun/feature/presentation/screens/widget/authentication/login/form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPassword extends StatelessWidget {
  const EditPassword({super.key});

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
            child: Text("تغيير كلمة المرور",
              style: GoogleFonts.saira(
                fontWeight: FontWeight.w800,
                fontSize: 30,
                color: const Color(0xff255A41),
              ),),
          ),
        ),


        body: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 96.0,horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFormField(
                  label: "كلمة المرور الحالية",
                  hint: "أدخل كلمة المرور",
                  isPassword: true,
                  labelStyle: GoogleFonts.saira(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25,),
                CustomFormField(
                  label: "كلمة المرور",
                  hint: "أدخل كلمة المرور",
                  isPassword: true,
                  labelStyle: GoogleFonts.saira(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25,),
                CustomFormField(
                  label: "تأكيد كلمة المرور",
                  hint: "أعد إدخال كلمة المرور",
                  isPassword: true,
                  labelStyle: GoogleFonts.saira(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 120,),

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
                      onPressed: () {
                      },
                      child: Text(
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
    );
  }
}
