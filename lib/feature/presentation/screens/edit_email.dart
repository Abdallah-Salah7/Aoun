import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditEmail extends StatelessWidget {
  const EditEmail({super.key});

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
            child: Text("تغيير البريد الإلكترونى",
              style: GoogleFonts.saira(
                fontWeight: FontWeight.w800,
                fontSize: 30,
                color: const Color(0xff255A41),
              ),),
          ),
        ),

        body: Column(),
      ),
    );
  }
}
