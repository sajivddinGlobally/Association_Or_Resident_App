import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

class Communitycontactsscreen extends StatefulWidget {
  const Communitycontactsscreen({super.key});

  @override
  State<Communitycontactsscreen> createState() =>
      _CommunitycontactsscreenState();
}

class _CommunitycontactsscreenState extends State<Communitycontactsscreen> {
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
                    "Raise Complaint",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Tell us what needs attention",
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
            SizedBox(height: 20.h),
            Text(
              "Caretaker",
              style: GoogleFonts.outfit(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.heading,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: 16.h),
            personCard(
              name: "Ahmed Khan",
              role: "Building A Caretaker",
              phone: "+966 55 765 4321",
              badge: "CARETAKER",
              icon: Icons.person_outline,
            ),
            SizedBox(height: 20.h),
            Text(
              "Association Representative",
              style: GoogleFonts.outfit(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.heading,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: 16.h),
            personCard(
              name: "Mohammed Ali",
              role: "Association Representative",
              phone: "+966 55 765 4321",
              badge: "Association",
              icon: Icons.group,
            ),
          ],
        ),
      ),
    );
  }

  Widget personCard({
    required String name,
    required String role,
    required String phone,
    required String badge,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 11.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.heading),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(184, 134, 11, 0.3),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, size: 20.sp, color: const Color(0xffB8860B)),
              ),

              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.heading,
                      ),
                    ),
                    Text(
                      role,
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        color: const Color.fromRGBO(16, 28, 22, 0.6),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(184, 134, 11, 0.3),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.outfit(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffB8860B),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 15.h),

          Divider(thickness: 1, color: AppColors.heading),

          SizedBox(height: 5.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                phone,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: const Color.fromRGBO(16, 28, 22, 0.6),
                ),
              ),

              GestureDetector(
                onTap: () {
                  // Call action
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.heading,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.call_outlined,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "Call",
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
