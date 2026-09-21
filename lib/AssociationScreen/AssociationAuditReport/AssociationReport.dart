import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/AssociationScreen/AssociationAuditReport/Provider/associationReportProvider.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

class AssociationReport extends ConsumerStatefulWidget {
  const AssociationReport({super.key});

  @override
  ConsumerState<AssociationReport> createState() => _AssociationReportState();
}

class _AssociationReportState extends ConsumerState<AssociationReport> {
  final searchController = TextEditingController();
  int selectedFilter = 0;
  String searchQuery = "";
  final List<String> filters = [
    "All",
    "Residential/Commercial management team",
    "Financial",
    "Reports",
    "Maintenance,",
  ];

  @override
  Widget build(BuildContext context) {
    final selectFilter = filters[selectedFilter].toLowerCase();
    final reportState = ref.watch(
      associationReportprovider((status: selectFilter, search: searchQuery)),
    );
    final association = reportState.valueOrNull?.data.reportsCentreInsights;
    final quickReport = reportState.valueOrNull?.data.quickReports;
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
                    "Reports",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Association Management",
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xff101C16), width: 1),
                ),
                child: reportState.isLoading
                    ? SizedBox(
                        height: 100.h,
                        width: double.infinity,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.heading,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            association?.badge ?? "",
                            style: GoogleFonts.outfit(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF000000),
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 13.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 36.w,
                                height: 36.w,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(184, 134, 11, 0.3),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.bar_chart_rounded,
                                    size: 20.sp,
                                    color: const Color(0xFFB8860B),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      association?.headline ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.outfit(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF000000),
                                        letterSpacing: -0.3,
                                        height: 1.1,
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    Text(
                                      association?.description ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.outfit(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(0, 0, 0, 0.6),
                                        letterSpacing: -0.3,
                                        height: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            width: double.infinity,
                            height: 1.h,
                            color: const Color(0xFFC6C6C6),
                          ),
                          SizedBox(height: 13.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _reportStat(
                                  title:
                                      association?.metrics.totalReports.count ??
                                      "",
                                  value:
                                      association?.metrics.totalReports.title ??
                                      "",
                                ),
                              ),
                              Expanded(
                                child: _reportStat(
                                  title:
                                      association?.metrics.thisMonth.count ??
                                      "",
                                  value:
                                      association?.metrics.thisMonth.title ??
                                      "",
                                ),
                              ),
                              Expanded(
                                child: _reportStat(
                                  title:
                                      association?.metrics.categories.count ??
                                      "",
                                  value:
                                      association?.metrics.categories.title ??
                                      "",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
              SizedBox(height: 16.h),
              Container(
                height: 45.h,
                width: double.infinity,
                padding: EdgeInsets.only(left: 16.w, right: 10.w),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Color(0xff101C16), width: 1),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 25.sp,
                      color: const Color(0xff8B8D8B),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.trim();
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: "Search service or provider...",
                          hintStyle: GoogleFonts.outfit(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff8B8D8B),
                            letterSpacing: -0.3,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(filters.length, (index) {
                    final bool isSelected = selectedFilter == index;
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            vertical: 5.h,
                            horizontal: 13.w,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xff101C16)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(40.r),
                            border: Border.all(
                              color: const Color(0xff101C16),
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            filters[index],
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xff101C16),
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Quick Reports",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff101C16),
                  fontSize: 17.sp,
                  letterSpacing: -0.54,
                ),
              ),
              SizedBox(height: 16.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: quickReport?.items.length ?? 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 15.h,
                  childAspectRatio: 1.80,
                ),
                itemBuilder: (context, index) {
                  final report = quickReport!.items[index];

                  return _topReportCard(
                    icon: Icons.build,
                    title: report.title,
                    subtitle: report.subtitle,
                  );
                },
              ),
              SizedBox(height: 16.h),
              Text(
                "Quick Reports",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff101C16),
                  fontSize: 17.sp,
                  letterSpacing: -0.54,
                ),
              ),
              SizedBox(height: 16.h),
              reportState.when(
                data: (data) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: data.data.reportsList.items.length,
                    itemBuilder: (context, index) {
                      final report = data.data.reportsList.items[index];

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom:
                              index == data.data.reportsList.items.length - 1
                              ? 0
                              : 14.h,
                        ),
                        child: _reportCard(
                          icon: report.categoryKey == "financial"
                              ? Icons.bar_chart_rounded
                              : Icons.description_outlined,
                          iconColor: report.categoryKey == "financial"
                              ? const Color(0xFFB58A16)
                              : const Color(0xFFE3C000),
                          iconBgColor: report.categoryKey == "financial"
                              ? const Color(0xFFF0DDA8)
                              : const Color(0xFFFFF5CE),
                          title: report.title,
                          subtitle: report.subtitle,
                          count: report.statBadge,
                          status: report.status,
                          pdf: report.format
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  log(stackTrace.toString());
                  log(error.toString());
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    alignment: Alignment.center,
                    child: Text(
                      "Something went wrong",
                      style: GoogleFonts.outfit(
                        fontSize: 15.sp,
                        color: AppColors.heading,
                      ),
                    ),
                  );
                },
                loading: () {
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.heading,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reportStat({required String value, required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 17.sp,
            color: const Color(0xFF000000),
            fontWeight: FontWeight.w500,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(42, 41, 51, 0.6),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _topReportCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF000000), width: 1.w),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 36.h,
            width: 36.w,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 242, 165, 0.3),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Icon(icon, size: 20.sp, color: const Color(0xFFB8860B)),
          ),
          SizedBox(height: 7.h),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              height: 1,
              color: Color(0xFF000000),
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              height: 1,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required String count,
    required String status,
    required String pdf,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 20.h),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF111111), width: 1.w),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 36.h,
                width: 36.w,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(icon, size: 19.sp, color: iconColor),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        color: Color(0xFF111111),
                        letterSpacing: -0.2,
                      ),
                    ),

                    SizedBox(height: 3.h),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 242, 165, 0.3),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFB8860B),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(height: 1.w, color: Color(0xFFC6C6C6)),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                count,
                style: GoogleFonts.outfit(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(width: 28.w),
              Text(
                pdf,
                style: GoogleFonts.outfit(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                  letterSpacing: -0.2,
                ),
              ),
              const Spacer(),
              Text(
                "VIEW →",
                style: GoogleFonts.outfit(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E5993),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}