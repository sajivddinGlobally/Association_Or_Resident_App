import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

class Residentvisitorpassrequest extends StatefulWidget {
  const Residentvisitorpassrequest({super.key});

  @override
  State<Residentvisitorpassrequest> createState() =>
      _ResidentvisitorpassrequestState();
}

class _ResidentvisitorpassrequestState
    extends State<Residentvisitorpassrequest> {
  int selected = 0;

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
                    "Visitor Pass Request",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Request entry access for your visitor",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.heading,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(color: const Color(0xFF514719)),
                      child: Icon(
                        Icons.person_2_outlined,
                        color: Color(0xffB8860B),
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(height: 11.h),
                    Text(
                      "Request a Visitor Pass",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 11.h),
                    Text(
                      "Create a visitor request for access to your registered apartment.",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 11.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF514719),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        "Green Valley · Building A · A-204",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFB8860B),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Visitor Details",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(17.w),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff101C16)),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Visitor Name",
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Visitor Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.r),
                          borderSide: const BorderSide(
                            color: Color(0xff101C16),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.r),
                          borderSide: const BorderSide(
                            color: Color(0xff101C16),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    Text(
                      "Mobile Number",
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number",

                        hintStyle: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(16, 28, 22, 0.6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(color: AppColors.heading),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(16, 28, 22, 0.6),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 18.h),

                    Text(
                      "Visitor Type",
                      style: GoogleFonts.outfit(fontSize: 15.sp),
                    ),

                    SizedBox(height: 14.h),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selected = 0),
                            child: visitorType("Guest", selected == 0),
                          ),
                        ),
                        SizedBox(width: 30.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selected = 1),
                            child: visitorType("Service", selected == 1),
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
      ),
    );
  }

  Widget visitorType(String title, bool selected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: selected ? const Color(0xff0D1C16) : Colors.transparent,
        border: Border.all(color: const Color(0xff101C16)),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(7.w),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xff4A4510)
                  : const Color(0xffE8D39F),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(
              Icons.person_outline,
              color: const Color(0xffC49400),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 15.sp,
              color: selected ? Colors.white : const Color(0xff101C16),
            ),
          ),
        ],
      ),
    );
  }
}
