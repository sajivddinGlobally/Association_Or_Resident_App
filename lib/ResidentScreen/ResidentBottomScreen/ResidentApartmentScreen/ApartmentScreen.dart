import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/AssociationScreen/AssociatoinComplaint/ComplaintStatus.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/ResidentScreen/ResidentComplaintScreen/ResidentComplantStatus.dart';

class Apartmentscreen extends StatefulWidget {
  const Apartmentscreen({super.key});

  @override
  State<Apartmentscreen> createState() => _ApartmentscreenState();
}

class _ApartmentscreenState extends State<Apartmentscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Container(
          color: AppColors.scaffoldBg,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PROPERTY DETAILS",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  Text(
                    "Complete information about your property",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(42, 41, 51, 0.6),
                      letterSpacing: -0.24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      "assets/property_img (2).png",
                      width: double.infinity,
                      height: 183.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff101C16).withOpacity(0.0),
                            Color(0xff101C16).withOpacity(0.0),
                            Color(0xff101C16),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.r),
                          bottomRight: Radius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.w,
                    bottom: 17.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "My Property",
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            color: Color(0xffFFFFFF),
                            fontSize: 13.sp,
                            letterSpacing: -0.24,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Apartment A-204",
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            color: Color(0xffFFFFFF),
                            fontSize: 17.sp,
                            letterSpacing: -0.54,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Green Valley Residency · Jaipur",
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            fontSize: 14.sp,
                            letterSpacing: -0.34,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Text(
                    "Property Overview",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                      color: AppColors.heading,
                      fontSize: 17.sp,
                      letterSpacing: -0.34,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "View All",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                      color: AppColors.heading,
                      fontSize: 14.sp,
                      letterSpacing: -0.34,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.heading),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    _documentRow(title: "Property Number", value: "A-204"),
                    _documentRow(title: "Property Type", value: "Apartment"),
                    _documentRow(title: "Area", value: "1,250 sq.ft"),
                    _documentRow(title: "Location", value: "Jaipur, Rajasthan"),
                    _documentRow(title: "Property Status", value: "Good"),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "Property Information",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  fontSize: 17.sp,
                  letterSpacing: -0.34,
                ),
              ),
              SizedBox(height: 18.h),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 28.w,
                mainAxisSpacing: 22.h,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.75,
                children: [
                  _infoCard(
                    icon: Icons.home_outlined,
                    title: "Green Valley Residency",
                    subtitle: "Associated Complex",
                  ),

                  _infoCard(
                    icon: Icons.circle,
                    title: "Rahul Sharma",
                    subtitle: "Assigned Caretaker",
                    iconSize: 19,
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: const Color(0xFF101C16),
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        fixedSize: Size(double.infinity, 44.h),
                        side: BorderSide(
                          color: const Color(0xFF777777),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      child: Text(
                        "Add Complain",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 25.w),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => Residentcomplantstatus(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF101C16),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        fixedSize: Size(double.infinity, 44.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      child: Text(
                        "Complain Track Status  →",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _documentRow({
    required String title,
    required String value,
    // Color valueColor = const Color(0xFF171A18),
    bool showBottomBorder = true,
  }) {
    return SizedBox(
      height: 40.h,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                border: showBottomBorder
                    ? const Border(
                        bottom: BorderSide(color: Color(0xFFC8C8C1), width: 1),
                      )
                    : null,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(42, 41, 51, 0.6),
                  letterSpacing: -0.24,
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              border: showBottomBorder
                  ? const Border(
                      bottom: BorderSide(color: Color(0xFFC8C8C1), width: 1),
                    )
                  : null,
            ),
            alignment: Alignment.centerRight,
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.heading,
                letterSpacing: -0.24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    double iconSize = 20,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: 15.w,
        right: 12.w,
        top: 10.h,
        bottom: 10.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.heading),
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: iconSize.sp, color: AppColors.heading),

          SizedBox(height: 8.h),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.heading,
              letterSpacing: -0.54,
            ),
          ),

          SizedBox(height: 6.h),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(41, 42, 51, 0.6),
              letterSpacing: -0.34,
            ),
          ),
        ],
      ),
    );
  }
}
