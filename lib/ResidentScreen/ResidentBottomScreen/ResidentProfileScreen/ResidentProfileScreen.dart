import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:property_association_or_resident/AssociationScreen/Auth/AssociationLogin.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/ResidentScreen/ResidentAssociationCalendarScreen/Resident_Calendar_Screen.dart';
import 'package:property_association_or_resident/ResidentScreen/ResidentBottomScreen/ResidentProfileScreen/ResidentChangePassword.dart';
import 'package:property_association_or_resident/ResidentScreen/ResidentBottomScreen/ResidentProfileScreen/Resident_MyProfile.dart';
import 'package:property_association_or_resident/ResidentScreen/ResidentHomeScreen/ResidentNotification_Screen.dart';
import 'package:property_association_or_resident/ResidentScreen/ResidentLoginScreen.dart';

import '../../../AssociationScreen/AssociationProfile/Provider/getProfileProvider.dart';

class Residentprofilescreen extends ConsumerStatefulWidget {
  const Residentprofilescreen({super.key});

  @override
  ConsumerState<Residentprofilescreen> createState() =>
      _ResidentprofilescreenState();
}

class _ResidentprofilescreenState extends ConsumerState<Residentprofilescreen> {
  @override
  Widget build(BuildContext context) {
    final residentProfileState = ref.watch(getProfileProvider);
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
              SizedBox(width: 10.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Manage your account and profile",
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
      body: residentProfileState.when(
        data: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.heading,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                "assets/profile (2).png",
                                width: 58.w,
                                height: 58.w,
                                fit: BoxFit.cover,
                              ),
                            ),

                            SizedBox(width: 10.w),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ahmed Rahman",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      letterSpacing: -0.2,
                                    ),
                                  ),

                                  SizedBox(height: 2.h),

                                  Text(
                                    "Resident · Apartment A-204",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),

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
                            "•  Resident Access Active",
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
                  SizedBox(height: 16.h),
                  Text(
                    "Upcoming Events",
                    style: GoogleFonts.outfit(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.heading,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff888888)),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        menuItem(
                          icon: Icons.person_outline,
                          title: "My Profile",
                          subtitle: "View and manage your resident information",
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ResidentMyprofile(),
                              ),
                            );
                          },
                        ),

                        Divider(height: 1, color: const Color(0xff555555)),

                        menuItem(
                          icon: Icons.home_outlined,
                          title: "My Apartment",
                          subtitle: "Green Valley · Building A · A-204",
                          onTap: () {},
                        ),

                        Divider(height: 1, color: const Color(0xff555555)),

                        menuItem(
                          icon: Icons.calendar_month_outlined,
                          title: "Community Contacts",
                          subtitle: "Caretaker & Association Representative",
                          onTap: () {},
                        ),

                        Divider(height: 1, color: const Color(0xff555555)),
                        menuItem(
                          icon: Icons.calendar_month_outlined,
                          title: "Visitor Pass Request",
                          subtitle: "Visitor Pass Request",
                          onTap: () {},
                        ),

                        Divider(height: 1, color: const Color(0xff555555)),

                        menuItem(
                          icon: Icons.person_outline,
                          title: "Association Calendar",
                          subtitle: "Property Owner & Association coordination",
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ResidentCalendarScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Current Access",
                    style: GoogleFonts.outfit(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.heading,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  residentAccess(),
                  SizedBox(height: 20.h),
                  Text(
                    "Preferences & Security",
                    style: GoogleFonts.outfit(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.heading,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff888888)),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        menuItem(
                          icon: Icons.notifications_none_sharp,
                          title: "Notification",
                          subtitle: "Association announcements & updates",
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    ResidentnotificationScreen(),
                              ),
                            );
                          },
                        ),

                        Divider(height: 1, color: const Color(0xff555555)),

                        menuItem(
                          icon: Icons.lock_outline,
                          title: "Security & Password",
                          subtitle: "Change password / account security",
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => Residentchangepassword(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  signOutCard(
                    onTap: () async {
                      var box = Hive.box("associationdata");
                      await box.delete("token");
                      await box.delete("role");
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const AssociationLogin(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text("Something went wrong"));
        },
        loading: () =>
            Center(child: CircularProgressIndicator(color: AppColors.heading)),
      ),
    );
  }

  Widget menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 38.w,
              width: 38.w,
              decoration: BoxDecoration(
                color: const Color(0xffEBD9A8),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Icon(icon, color: const Color(0xffB8860B), size: 22.sp),
            ),

            SizedBox(width: 8.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff101C16),
                    ),
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xff777777),
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right,
              size: 27.sp,
              color: const Color(0xff101C16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _accessItem(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7C9),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF666666),
              letterSpacing: -0.2,
            ),
          ),

          SizedBox(height: 3.h),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF101C16),
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget residentAccess() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF101C16), width: 1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  "Resident Access",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF101C16),
                    letterSpacing: -0.2,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8D4A0),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Text(
                  "ACTIVE",
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFB8860B),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 9.h),
          Row(
            children: [
              Expanded(child: _accessItem("Apartment", "A-204")),
              SizedBox(width: 20.w),
              Expanded(child: _accessItem("Building", "Building A")),
            ],
          ),

          SizedBox(height: 11.h),
          Row(
            children: [
              Expanded(child: _accessItem("Property", "Green Valley")),
              SizedBox(width: 20.w),
              Expanded(child: _accessItem("Role", "Resident")),
            ],
          ),
        ],
      ),
    );
  }

  Widget signOutCard({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffCCB4B4), width: 1.5.w),
          borderRadius: BorderRadius.circular(11.r),
        ),
        child: Row(
          children: [
            Container(
              height: 40.w,
              width: 40.w,
              decoration: BoxDecoration(
                color: Color.fromRGBO(210, 36, 36, 0.3),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.logout,
                size: 20.sp,
                color: const Color(0xffD22424),
              ),
            ),

            SizedBox(width: 15.w),

            Text(
              "Sign Out",
              style: GoogleFonts.inter(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xffD91F1F),
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
