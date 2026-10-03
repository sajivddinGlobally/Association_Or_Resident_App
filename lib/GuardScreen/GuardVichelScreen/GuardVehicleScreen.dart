import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/GuardScreen/GuardVichelScreen/Provider/vehicleSearchProvider.dart';

class Guardvehiclescreen extends ConsumerStatefulWidget {
  const Guardvehiclescreen({super.key});

  @override
  ConsumerState<Guardvehiclescreen> createState() => _GuardvehiclescreenState();
}

class _GuardvehiclescreenState extends ConsumerState<Guardvehiclescreen> {
  final List<Map<String, dynamic>> recentSearches = [
    {
      "vehicle": "🚘",
      "flat": "RJ14 AB 1234",
      "time": "Flat A-204 Searched today",
    },
    {
      "vehicle": "🚙",
      "flat": "RJ14 CD 5678",
      "time": "Flat B-102 Searched yesterday",
    },
    {
      "vehicle": "🚘",
      "flat": "RJ14 EF 9012",
      "time": "Flat C-301 Searched 2 days ago",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final search = ref.watch(vehicleSearchProvider);
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
                    "Vehicle Search",
                    style: GoogleFonts.outfit(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Find vehicle and registered owner details",
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(42, 41, 51, 0.65),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: search.when(
        data: (data) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xffE0E0E0),
                      width: 1.3,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VEHICLE NUMBER',
                        style: GoogleFonts.outfit(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 10.h),
                      TextField(
                        style: GoogleFonts.outfit(
                          fontSize: 20.sp,
                          color: AppColors.heading,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "e.g. RJ14 AB 1234",
                          hintStyle: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff888891),
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 27.sp,
                            color: const Color(0xff858585),
                          ),

                          suffixIcon: Container(
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: AppColors.heading,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                                bottomRight: Radius.circular(10.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Search",
                                style: GoogleFonts.outfit(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ),

                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 10.h,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                              color: Color(0xff92929A),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                              color: AppColors.heading,
                              width: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 22.w,
                    vertical: 25.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(
                      color: const Color(0xffDEDEDE),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        "Recent Searches",
                        style: GoogleFonts.outfit(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff111111),
                          letterSpacing: -0.2,
                        ),
                      ),

                      SizedBox(height: 16.h),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              children: [
                                // Vehicle Icon
                                Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF3F0E9),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "🚗",
                                      style: TextStyle(fontSize: 18.sp),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 12.w),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.data?.vehicleNumber ?? "",
                                        style: GoogleFonts.outfit(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff111111),
                                          letterSpacing: -0.4,
                                        ),
                                      ),

                                      SizedBox(height: 2.h),

                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: data.data?.flatNumber,
                                              style: GoogleFonts.outfit(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff666666),
                                                letterSpacing: -0.2,
                                              ),
                                            ),
                                            TextSpan(
                                              text: data.data?.searchedAt,
                                              style: GoogleFonts.outfit(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff666666),
                                                letterSpacing: -0.2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return const Center(child: Text("Something went wrong"));
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.heading),
          );
        },
      ),
    );
  }
}
