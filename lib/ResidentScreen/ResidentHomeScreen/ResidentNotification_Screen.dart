import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

class ResidentnotificationScreen extends StatefulWidget {
  const ResidentnotificationScreen({super.key});

  @override
  State<ResidentnotificationScreen> createState() =>
      _ResidentnotificationScreenState();
}

class _ResidentnotificationScreenState
    extends State<ResidentnotificationScreen> {
  int selectedFilter = 0;

  final List<String> filters = [
    "All",
    "Issues",
    "Maintenance",
    "Association",
    "Important",
  ];
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
                    "Notifications",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Stay updated with your property",
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
            SizedBox(height: 16.h),
            Row(
              children: List.generate(filters.length, (index) {
                final bool isSelected = selectedFilter == index;
                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
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
                          fontSize: 13.sp,
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
            SizedBox(height: 20.h),
            Row(
              children: [
                Text(
                  "Today",
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.heading,
                    letterSpacing: -0.2,
                  ),
                ),
                Spacer(),
                Text(
                  "3 New",
                  style: GoogleFonts.outfit(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.heading,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 13.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff101010)),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 42.w,
                        height: 42.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff101010),
                            width: 1.1,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: AppColors.heading,
                            size: 16.sp,
                          ),
                        ),
                      ),

                      SizedBox(width: 27.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Service Request Update",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.heading,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 8.w),

                                Text(
                                  "09:45 AM",
                                  style: GoogleFonts.outfit(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.heading,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 5.h),
                            Text(
                              "Your bathroom water leakage request has been assigned for further coordination.",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(0, 0, 0, 0.7),
                                letterSpacing: -0.2,
                              ),
                            ),

                            SizedBox(height: 5.h),

                            Container(
                              height: 23.h,
                              width: 106.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xff101010),
                                ),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "#RES-1048 · A-204",
                                style: GoogleFonts.outfit(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff101010),
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
