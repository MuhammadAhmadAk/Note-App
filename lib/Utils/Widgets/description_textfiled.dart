import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    Key? key,
    this.label,
    this.controller,
    this.inputType,
    this.hintText,
    this.labelTheme,
    this.maxLines,
  }) : super(key: key);

  final String? label;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? hintText;
  final TextStyle? labelTheme;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? "",
          style: labelTheme ??
              GoogleFonts.montserrat(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(
          height: 7.h,
        ),
        Container(
          width: 350.w,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.06),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            style: GoogleFonts.montserrat(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.5),
            ),
            cursorColor: Colors.grey.withOpacity(0.07),
            maxLines: maxLines ?? 10,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.w),
              hintText: hintText,
              fillColor: Colors.black.withOpacity(0.01),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
