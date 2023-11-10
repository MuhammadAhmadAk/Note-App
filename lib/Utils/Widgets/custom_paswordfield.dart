// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextfield extends StatefulWidget {
  const PasswordTextfield({
    Key? key,
    this.label,
    this.controller,
    this.inputType,
    this.hintText,
    this.labelTheme,
  }) : super(key: key);

  final String? label;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? hintText;
  final TextStyle? labelTheme;

  @override
  _PasswordTextfieldState createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: widget.labelTheme ??
              GoogleFonts.montserrat(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
        ),
        // SizedBox(
        //   height: 5.h,
        // ),
        Container(
          width: 350.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.06),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: widget.controller,
                keyboardType: widget.inputType,
                obscureText: _obscureText, // Use the obscureText property
                cursorColor: Colors.grey.withOpacity(0.07),
                style: GoogleFonts.montserrat(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.5)),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.w),
                  hintText: widget.hintText,
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
              IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black.withOpacity(0.3),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
