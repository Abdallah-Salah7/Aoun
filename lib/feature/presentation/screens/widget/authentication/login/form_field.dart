import 'package:aoun/core/color_manager/primary_colors.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final FontWeight labelFontWeight;

  const CustomFormField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.labelFontWeight = FontWeight.normal,
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
                fontSize: fontSize * 1.2,
                fontWeight: widget.labelFontWeight,
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: fieldHeight * 0.8,
            child: TextField(
              obscureText: widget.isPassword ? obscure : false,
              style: TextStyle(fontSize: fontSize),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(color: Color(0xffC4C4C4)),

                suffixIcon:
                    widget.isPassword
                        ? IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility_off : Icons.visibility,
                            color: PrimaryColors.secondaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                        )
                        : null,
                filled: true,
                fillColor: Color(0xffFFFFFF),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: PrimaryColors.secondaryColor,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
