import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

class InspectionreportDetails extends StatefulWidget {
  const InspectionreportDetails({super.key});

  @override
  State<InspectionreportDetails> createState() =>
      _InspectionreportDetailsState();
}

class _InspectionreportDetailsState extends State<InspectionreportDetails> {
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
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(16, 28, 22, 0.3),
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: const Color(0xff101C16),
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inspection Details",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "PROPERTY INSPECTION REPORT",
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(42, 41, 51, 0.7),
                      letterSpacing: -0.2,
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
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFDF0),
                  border: Border.all(
                    color: const Color(0xff101C16),
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(13.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 42.w,
                          height: 42.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff101C16),
                              width: 1.2,
                            ),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.article_outlined,
                              size: 22.sp,
                              color: const Color(0xff101C16),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Property Inspection Report",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff101C16),
                                  letterSpacing: -0.2,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "15 August 2026",
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(16, 28, 22, 0.75),
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff101C16), width: 1.2),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Completed",
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff101C16),
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: const Color(0xff777970),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _infoItem(
                            title: "INSPECTION AREA",
                            value: "Green Valley",
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: _infoItem(
                            title: "Inspector",
                            value: "Rajesh Sharma",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _infoItem(
                            title: "Inspection Date",
                            value: "15 Aug 2026",
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: _infoItem(title: "Status", value: "Completed"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Inspection Checklist",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff101C16),
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff999999),
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Column(
                  children: [
                    _auditItem(
                      icon: "✓",
                      title: "Corridors — Passed",
                      description: "Clean and properly maintained",
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      height: 1.h,
                      color: const Color(0xffD0D2CE),
                    ),
                    SizedBox(height: 12.h),
                    _auditItem(
                      icon: "!",
                      title: "Terrace Area — Passed",
                      description:
                          "Minor maintenance attention is recommended for the identified area.",
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      height: 1.h,
                      color: const Color(0xffD0D2CE),
                    ),
                    SizedBox(height: 12.h),
                    _auditItem(
                      icon: "✓",
                      title: "Common Areas — Passed",
                      description:
                          "Safety-related observations recorded in the inspection report.",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Recommendations",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff101C16),
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.heading, width: 1.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recommended actions based on the audit findings are available for review.",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w500,
                        color: AppColors.heading,
                        fontSize: 14.sp,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 7.h,
                        horizontal: 20.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.heading, width: 1.2),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Text(
                        "Review Recommended Actions",
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          color: AppColors.heading,
                          fontSize: 14.sp,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Attached Documents",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w700,
                  color: AppColors.heading,
                  fontSize: 18.sp,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.heading, width: 1.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.heading, width: 1.2),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: const Icon(
                              Icons.description_outlined,
                              size: 20,
                              color: Color(0xff17231F),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "Audit Report",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.heading,
                            ),
                          ),
                          Text(
                            "PDF",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(16, 28, 22, 0.75),
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.heading, width: 1.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.heading,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: const Icon(
                              Icons.image_outlined,
                              size: 20,
                              color: Color(0xff17231F),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "Audit Images",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.heading,
                            ),
                          ),
                          Text(
                            "Images",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(16, 28, 22, 0.75),
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.scaffoldBg,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: AppColors.heading, width: 1.2),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "View Full Report",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w700,
                            color: AppColors.heading,
                            fontSize: 15.sp,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.heading,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Download Report",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 15.sp,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(16, 28, 22, 0.75),
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  Widget _auditItem({
    required String icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(16, 28, 22, 0.15),
            borderRadius: BorderRadius.circular(6.r),
          ),
          alignment: Alignment.center,
          child: Text(
            icon,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.heading,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(42, 41, 51, 0.75),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
