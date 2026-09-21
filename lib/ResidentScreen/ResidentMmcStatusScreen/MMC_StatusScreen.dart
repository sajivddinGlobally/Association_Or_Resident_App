import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

class MmcStatusscreen extends StatefulWidget {
  const MmcStatusscreen({super.key});

  @override
  State<MmcStatusscreen> createState() => _MmcStatusscreenState();
}

class _MmcStatusscreenState extends State<MmcStatusscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBg,
        automaticallyImplyLeading: false,
        titleSpacing: 20.w,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 41.w,
                  height: 41.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(16, 28, 22, 0.3),
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: const Color(0xff101C16),
                    size: 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MMC Status",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Monthly Maintenance Charge",
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(42, 41, 51, 0.6),
                      letterSpacing: -0.24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text(
              "Current Month",
              style: GoogleFonts.outfit(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.heading,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.heading),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(184, 134, 11, 0.3),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Icon(
                          Icons.attach_money,
                          size: 20.sp,
                          color: const Color(0xffB8860B),
                        ),
                      ),

                      SizedBox(width: 10.w),
                      Text(
                        "Monthly Maintenance Charge",
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.heading,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    height: 96.h,
                    padding: EdgeInsets.only(top: 22.h),
                    decoration: BoxDecoration(color: Color(0xffEDEDED)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Monthly Charge",
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff2A2933),
                            letterSpacing: -0.2,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "SAR",
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffB8860B),
                                  fontSize: 14.sp,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              TextSpan(
                                text: " 500",
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffB8860B),
                                  fontSize: 18.sp,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Current Status",
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          color: const Color.fromRGBO(16, 28, 22, 0.6),
                          letterSpacing: -0.2,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 17.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(184, 134, 11, 0.3),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Text(
                          "Paid",
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffB8860B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Divider(
                    thickness: 1,
                    color: const Color.fromRGBO(16, 28, 22, 0.6),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Month",
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          color: const Color.fromRGBO(16, 28, 22, 0.6),
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        "September 2026",
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          color: AppColors.heading,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Divider(
                    thickness: 1,
                    color: const Color.fromRGBO(16, 28, 22, 0.6),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Paid On",
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          color: const Color.fromRGBO(16, 28, 22, 0.6),
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        "02 Sep 2026",
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          color: AppColors.heading,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
