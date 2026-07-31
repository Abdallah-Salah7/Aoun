import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final String hint;
  final String? imagePath;
  final bool isPassword;
  final TextStyle? labelStyle;
  final bool downloadIcon;
  final bool? filled;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  const CustomFormField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.downloadIcon = false,
    this.labelStyle,
    this.controller,
    this.imagePath,
    this.filled = true,
    this.onTap,
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
            padding: EdgeInsets.only(right: width * 0.01),
            child: Text(
              widget.label,
              style:
                  widget.labelStyle ??
                  TextStyle(
                    color: Colors.black,
                    fontSize: fontSize * 1.3,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: fieldHeight * 0.8,
            child: TextField(
              controller: widget.controller,
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

                          onPressed: widget.onTap,
                        )
                        : null,
                filled: widget.filled,
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
