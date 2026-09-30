import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/GuardScreen/GuardBottomScreen/GuardHistoryScreen/guardHistoryScreen.dart';
import 'package:property_association_or_resident/GuardScreen/GuardBottomScreen/GuardParcelScreen/guardparcelscreen.dart';
import 'package:property_association_or_resident/GuardScreen/GuardBottomScreen/GuardVisitorScreen/guardvisitorScreen.dart';
import 'package:property_association_or_resident/GuardScreen/GuardBottomScreen/GuradProfileScreen/GuardProfileScreen.dart';
import 'package:svg_flutter/svg.dart';

class GuardBottomNavState extends StatefulWidget {
  const GuardBottomNavState({super.key});

  @override
  State<GuardBottomNavState> createState() => _GuardBottomNavStateState();
}

class _GuardBottomNavStateState extends State<GuardBottomNavState> {
  int selectedBottomIndex = 0;
  List<Widget> get pages => [
    GuardBottomNavState(
      // onDocumentTap: () {
      //   setState(() {
      //     selectedBottomIndex = 3;
      //   });
      // },
      // onProfileTap: () {
      //   setState(() {
      //     selectedBottomIndex = 4;
      //   });
      // },
    ),
    Guardvisitorscreen(),
    Guardparcelscreen(),
    Guardhistoryscreen(),
    Guardprofilescreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedBottomIndex != 0) {
          setState(() {
            selectedBottomIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBg,
        body: pages[selectedBottomIndex],
        bottomNavigationBar: SafeArea(
          top: false,
          child: Container(
            width: double.infinity,
            height: 70.h,
            decoration: BoxDecoration(
              color: Color(0xFFFFFCEB),
              border: Border(
                top: BorderSide(color: const Color(0xFF17221D), width: 1.w),
              ),
            ),
            child: Row(
              children: [
                _bottomItem(
                  index: 0,
                  // image: "assets/bottam_img.png",
                  image: "assets/SvgImage/homeicon.svg",
                  title: "Home",
                ),

                _bottomItem(
                  index: 1,
                  // image: "assets/bottom_img2.png",
                  image: "assets/SvgImage/propertyicon.svg",
                  title: "Visitor",
                ),

                _bottomItem(
                  index: 2,
                  // image: "assets/bottom_img3.png",
                  image: "assets/SvgImage/serviceicon.svg",
                  title: "Parcel",
                ),

                _bottomItem(
                  index: 3,
                  // image: "assets/bottom_img4.png",
                  image: "assets/SvgImage/documenticon.svg",
                  title: "History",
                ),

                _bottomItem(
                  index: 4,
                  // image: "assets/bottom_img5.png",
                  image: "assets/SvgImage/profileicon.svg",
                  title: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomItem({
    required int index,
    required String image,
    required String title,
  }) {
    final bool isSelected = selectedBottomIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedBottomIndex = index;
          });
        },
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.08 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: SvgPicture.asset(
                  image,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? const Color(0xff101C16)
                        : const Color(0xFF6F7672),
                    BlendMode.srcIn,
                  ),
                  width: 30.w,
                  height: 30.h,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 18.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? Color(0xFF17221D)
                      : const Color(0xffA0A5A2),
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Guardhomescreen extends StatefulWidget {
  const Guardhomescreen({super.key});

  @override
  State<Guardhomescreen> createState() => _GuardhomescreenState();
}

class _GuardhomescreenState extends State<Guardhomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
