import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/AssociationScreen/AssociationInspectionReport/InspectionReport_Details.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

class InspectionreportScreen extends StatefulWidget {
  const InspectionreportScreen({super.key});

  @override
  State<InspectionreportScreen> createState() => _InspectionreportScreenState();
}

class _InspectionreportScreenState extends State<InspectionreportScreen> {
  int selectedFilter = 0;
  int selectedSummary = 0;
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
                    "Inspection Reports",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "PROPERTY INSPECTION HISTORY",
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.heading),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: AppColors.heading),
                      ),
                      child: Center(
                        // child: Image.asset(
                        //   "assets/auditImg.png",
                        //   height: 18.h,
                        //   width: 18.w,
                        // ),
                        child: Icon(
                          Icons.description,
                          color: AppColors.heading,
                          size: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Green Valley Residency",
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            color: AppColors.heading,
                            fontSize: 16.sp,
                            letterSpacing: -0.2,
                          ),
                        ),
                        Text(
                          "Building A · Common Areas",
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(42, 41, 51, 0.5),
                            fontSize: 13.sp,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Inspection Reports",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  fontSize: 17.sp,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "View previous inspections, inspection dates, inspector\n information and report findings.",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(42, 41, 51, 0.5),
                  fontSize: 14.sp,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 20.h),
              _buildSummaryCards(),
              SizedBox(height: 20.h),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => InspectionreportDetails(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 11.w,
                        vertical: 15.h,
                      ),
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
                                width: 36.w,
                                height: 36.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff101C16),
                                    width: 1.1,
                                  ),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.article_outlined,
                                    size: 22.sp,
                                    color: const Color(0xff101C16),
                                  ),
                                ),
                              ),

                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Common Area Inspection",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.outfit(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff101C16),
                                        letterSpacing: -0.2,
                                      ),
                                    ),

                                    SizedBox(height: 6.h),

                                    Text(
                                      "15 August 2026",
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(16, 28, 22, 0.6),
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 10.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff101C16),
                                  ),
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Completed",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
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

                          SizedBox(height: 17.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _infoItem(
                                  title: "Inspector",
                                  value: "Amit Verma",
                                ),
                              ),

                              SizedBox(width: 15.w),
                              Expanded(
                                child: _infoItem(
                                  title: "Inspection Date",
                                  value: "20 May 2026",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Findings & recommendations available",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.heading,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  "View Details →",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.heading,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(16, 28, 22, 0.6),
            letterSpacing: -0.2,
          ),
        ),

        SizedBox(height: 2.h),

        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.heading,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  Widget buildReportButton(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 7.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF0),
        border: Border.all(color: const Color(0xFF101C16), width: 1.5),
        borderRadius: BorderRadius.circular(35.r),
      ),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.outfit(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF101C16),
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _summaryCard(index: 0, title: "All Reports")),
        SizedBox(width: 10.w),
        Expanded(child: _summaryCard(index: 1, title: "Recent")),
        SizedBox(width: 10.w),
        Expanded(child: _summaryCard(index: 2, title: "Previous")),
      ],
    );
  }

  Widget _summaryCard({required int index, required String title}) {
    final bool isSelected = selectedSummary == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSummary = index;
          selectedFilter = 0;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.heading : Colors.transparent,
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(
            color: isSelected ? AppColors.heading : Color(0xff6A6A6A),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Color(0xff6A6A6A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
