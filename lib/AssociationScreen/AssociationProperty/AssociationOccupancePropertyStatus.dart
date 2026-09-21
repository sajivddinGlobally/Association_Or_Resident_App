import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

class AssociationOccupancePropertyStatus extends StatefulWidget {
  const AssociationOccupancePropertyStatus({super.key});

  @override
  State<AssociationOccupancePropertyStatus> createState() =>
      _AssociationOccupancePropertyStatusState();
}

class _AssociationOccupancePropertyStatusState
    extends State<AssociationOccupancePropertyStatus> {
  int selectedFilter = 0;

  final List<String> filters = ["All", "Occupied", "Vacant", "Attention"];
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
                    "Occupancy / Property Status",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Complex-wide occupancy and property status",
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
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF000000), width: 1.w),
                  borderRadius: BorderRadius.circular(10.r),
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
                            border: Border.all(
                              color: Color(0xFF000000),
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.home_outlined,
                              color: Color(0xFF000000),
                              size: 16.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Complex",
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(0, 0, 0, 0.7),
                                  letterSpacing: -0.2,
                                  height: 1.h,
                                ),
                              ),
                              Text(
                                "Green Valley Residency",
                                style: GoogleFonts.outfit(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF101C16),
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF000000),
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          child: Text(
                            "Active",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF000000),
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF000000), width: 1.w),
                  borderRadius: BorderRadius.circular(10.r),
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
                            border: Border.all(
                              color: Color(0xFF000000),
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.radio_button_checked,
                              color: Color(0xFF000000),
                              size: 16.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Overall Occupancy",
                                style: GoogleFonts.outfit(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              Text(
                                "Current complex occupancy status",
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF000000),
                                  letterSpacing: -0.2,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "91%",
                              style: GoogleFonts.outfit(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                letterSpacing: -0.2,
                              ),
                            ),
                            Text(
                              "116 / 128 units",
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                                letterSpacing: -0.2,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: LinearProgressIndicator(
                        value: 0.91,
                        minHeight: 3.h,
                        backgroundColor: const Color(0xFFA8A8A8),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF101C16),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "116 Occupied",
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: -0.2,
                          ),
                        ),
                        Text(
                          "12 Vacant",
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: Icons.circle,
                      value: "116",
                      title: "Occupied",
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: _statCard(
                      icon: Icons.circle_outlined,
                      value: "12",
                      title: "Vacant",
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: _statCard(
                      icon: Icons.priority_high,
                      value: "03",
                      title: "Attention",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 19.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Unit Status',
                    style: GoogleFonts.outfit(
                      color: Color(0xFF000000),
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.2,
                    ),
                  ),
                  Text(
                    '128 UNITS',
                    style: GoogleFonts.outfit(
                      color: Color(0xFF000000),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
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
                            vertical: 6.h,
                            horizontal: 14.w,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xff101C16)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
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
                'BLOCK A',
                style: GoogleFonts.outfit(
                  color: Color(0xFF000000),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 16.h),
              _buildBlock(),
              _buildBlock(),
              SizedBox(height: 16.h),
              Text(
                'BLOCK B',
                style: GoogleFonts.outfit(
                  color: Color(0xFF000000),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 16.h),
              _buildBlock(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String title,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 8.w, top: 7.h, right: 8.w, bottom: 7.h),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF000000), width: 1.w),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF000000), width: 1.w),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Icon(icon, size: 13.sp, color: Colors.black),
          ),
          SizedBox(height: 3.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              letterSpacing: -0.2,
            ),
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              letterSpacing: -0.2,
              height: 1.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlock() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.heading),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset("assets/associationImage/bed.png"),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Apartment A-204",
                    style: GoogleFonts.outfit(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF000000),
                      letterSpacing: -0.2,
                    ),
                  ),
                  Text(
                    "Block A · 3 BHK",
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(42, 41, 51, 0.7),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF000000),
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Text(
                  "Occupied",
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF000000),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(color: Color(0xFFC6C6C6)),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Role
              Expanded(
                child: _associationInfoItem(
                  title: "OWNER",
                  value: "Arjun Sharma",
                ),
              ),

              // Total Units
              Expanded(
                child: _associationInfoItem(title: "PROPERTY", value: "Active"),
              ),

              // Blocks
              Expanded(
                child: _associationInfoItem(title: "SCORE", value: "86 / 100"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _associationInfoItem({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF000000),
            letterSpacing: -0.2,
          ),
        ),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF000000),
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}
