import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:aoun/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final String hint;
  final String? imagePath;
  final bool isPassword;
  final FontWeight labelFontWeight;
  final bool downloadIcon;
  final TextEditingController? emailController;

  const CustomFormField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.downloadIcon = false,
    this.labelFontWeight = FontWeight.normal,
    this.emailController,
    this.imagePath,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double fontSize = width < 600 ? 14 : 16;
    double fieldHeight = width < 600 ? 55 : 60;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.03),
            child: Text(
              widget.label,
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize * 1.3,
                fontWeight: widget.labelFontWeight,
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: fieldHeight * 0.8,
            child: TextField(
              controller: widget.emailController,
              obscureText: widget.isPassword ? obscure : false,
              style: TextStyle(fontSize: fontSize),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(
                  color: Color(0xffC4C4C4),
                  fontSize: fontSize * 1.1,
                ),
                prefixIcon:
                    widget.downloadIcon ? Image.asset(widget.imagePath!) : null,
                suffixIcon:
                    widget.isPassword
                        ? IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                        )
                        : widget.downloadIcon
                        ? IconButton(
                          icon: Image.asset("assets/images/upload.png"),
                          onPressed: () {},
                        )
                        : null,
                filled: true,
                fillColor: Color(0xffFFFFFF),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.withAlpha(100)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.withAlpha(100)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
