import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

class GuardScanPassScreen extends StatefulWidget {
  const GuardScanPassScreen({super.key});

  @override
  State<GuardScanPassScreen> createState() => _GuardScanPassScreenState();
}

class _GuardScanPassScreenState extends State<GuardScanPassScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController passCodeController = TextEditingController();
  bool isFlashOn = false;
  late AnimationController _animController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    passCodeController.dispose();
    super.dispose();
  }

  void _showPassDetailsModal({
    required String passCode,
    required String visitorName,
    required String visitorPhone,
    required String flatNumber,
    required String passType,
    required String validDate,
    required String status,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 28.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22.r),
              topRight: Radius.circular(22.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pass Verification",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                      letterSpacing: -0.2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4F5E1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.outfit(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF16A765),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                "QR Code verified successfully against pre-approved pass.",
                style: GoogleFonts.outfit(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F5EE),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFE4DFD3)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 46.w,
                          height: 46.w,
                          decoration: BoxDecoration(
                            color: AppColors.heading,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                visitorName,
                                style: GoogleFonts.outfit(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.heading,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                visitorPhone,
                                style: GoogleFonts.outfit(
                                  fontSize: 13.sp,
                                  color: const Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD2F3DF),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            "Flat $flatNumber",
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF16A765),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    const Divider(height: 1, color: Color(0xFFE0DDD5)),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _passMetaCol("Pass Type", passType),
                        _passMetaCol("Pass Code", passCode),
                        _passMetaCol("Valid Until", validDate),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.heading,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xFF16A765),
                              content: Text(
                                "Entry confirmed! IN-Time recorded at 11:24 AM.",
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Mark IN-Time (Allow Entry)",
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  SizedBox(
                    height: 44.h,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.heading),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.heading,
                            content: Text(
                              "Visitor marked OUT! Visit closed.",
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Mark OUT",
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.heading,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _passMetaCol(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 12.sp,
            color: const Color(0xFF777777),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
          ),
        ),
      ],
    );
  }

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
                onTap: () => Navigator.pop(context),
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
                    "Scan Visitor Pass",
                    style: GoogleFonts.outfit(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Scan QR code or enter pass code",
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),

              // Scanner Viewport Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1E18),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF16A765),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "Camera Active",
                              style: GoogleFonts.outfit(
                                fontSize: 13.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isFlashOn = !isFlashOn;
                            });
                          },
                          icon: Icon(
                            isFlashOn
                                ? Icons.flash_on_rounded
                                : Icons.flash_off_rounded,
                            color: isFlashOn
                                ? const Color(0xFFE8B900)
                                : Colors.white70,
                            size: 22.sp,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // QR Viewfinder target box
                    GestureDetector(
                      onTap: () {
                        // Simulate scanning a visitor pass
                        _showPassDetailsModal(
                          passCode: "VP-84920",
                          visitorName: "Rahul Verma",
                          visitorPhone: "+91 98765 43210",
                          flatNumber: "B-402",
                          passType: "Guest / Visitor",
                          validDate: "Today, 11:59 PM",
                          status: "PRE-APPROVED",
                        );
                      },
                      child: Container(
                        width: 220.w,
                        height: 220.w,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: const Color(0xFFE8B900),
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // 4 Corner Brackets
                            Positioned(
                              top: 8,
                              left: 8,
                              child: _cornerBracket(isTop: true, isLeft: true),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: _cornerBracket(isTop: true, isLeft: false),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: _cornerBracket(isTop: false, isLeft: true),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: _cornerBracket(
                                isTop: false,
                                isLeft: false,
                              ),
                            ),

                            // Animated Laser Line
                            AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Positioned(
                                  top: _animation.value * 200,
                                  left: 10,
                                  right: 10,
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8B900),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFFE8B900,
                                          ).withOpacity(0.7),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.qr_code_scanner_rounded,
                                    size: 42.sp,
                                    color: Colors.white30,
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    "Tap to simulate scan",
                                    style: GoogleFonts.outfit(
                                      fontSize: 12.sp,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),
                    Text(
                      "Point camera at visitor's pass QR code",
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Manual Code Input Option
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Or Enter Pass Code Manually",
                      style: GoogleFonts.outfit(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.heading,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Use 6-digit pass code shared by resident",
                      style: GoogleFonts.outfit(
                        fontSize: 12.sp,
                        color: const Color(0xFF777777),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: passCodeController,
                            textCapitalization: TextCapitalization.characters,
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.heading,
                              letterSpacing: 2,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "e.g. VP-84920",
                              hintStyle: GoogleFonts.outfit(
                                fontSize: 13.sp,
                                color: const Color(0xFF999999),
                                letterSpacing: 0,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.h,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF9F9F9),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: const BorderSide(
                                  color: Color(0xFFCCCCCC),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: AppColors.heading,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          height: 44.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.heading,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            onPressed: () {
                              final code =
                                  passCodeController.text.trim().isEmpty
                                  ? "VP-84920"
                                  : passCodeController.text.trim();
                              _showPassDetailsModal(
                                passCode: code,
                                visitorName: "Sanjay Singhania",
                                visitorPhone: "+91 99887 76655",
                                flatNumber: "A-204",
                                passType: "Pre-Approved Visitor",
                                validDate: "Today, 10:00 PM",
                                status: "ACTIVE",
                              );
                            },
                            child: Text(
                              "Verify",
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Recent Scanned Passes Quick List
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's Scanned Passes",
                          style: GoogleFonts.outfit(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.heading,
                          ),
                        ),
                        Text(
                          "4 Verified",
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF16A765),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    _recentPassRow(
                      name: "Zomato Delivery",
                      flat: "Flat C-104",
                      time: "10:45 AM",
                      type: "Delivery",
                      isIn: true,
                    ),
                    const Divider(height: 18, color: Color(0xFFEEEEEE)),
                    _recentPassRow(
                      name: "Dr. Ananya Roy",
                      flat: "Flat A-301",
                      time: "09:30 AM",
                      type: "Visitor",
                      isIn: true,
                    ),
                    const Divider(height: 18, color: Color(0xFFEEEEEE)),
                    _recentPassRow(
                      name: "Amazon Courier",
                      flat: "Flat D-202",
                      time: "08:15 AM",
                      type: "Delivery",
                      isIn: false,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cornerBracket({required bool isTop, required bool isLeft}) {
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        border: Border(
          top: isTop
              ? const BorderSide(color: Color(0xFFE8B900), width: 3)
              : BorderSide.none,
          bottom: !isTop
              ? const BorderSide(color: Color(0xFFE8B900), width: 3)
              : BorderSide.none,
          left: isLeft
              ? const BorderSide(color: Color(0xFFE8B900), width: 3)
              : BorderSide.none,
          right: !isLeft
              ? const BorderSide(color: Color(0xFFE8B900), width: 3)
              : BorderSide.none,
        ),
      ),
    );
  }

  Widget _recentPassRow({
    required String name,
    required String flat,
    required String time,
    required String type,
    required bool isIn,
  }) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F0E9),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            type == "Delivery" ? Icons.inventory_2_outlined : Icons.person_outline,
            size: 18.sp,
            color: AppColors.heading,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.heading,
                ),
              ),
              Text(
                "$flat · $time",
                style: GoogleFonts.outfit(
                  fontSize: 12.sp,
                  color: const Color(0xFF777777),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: isIn
                ? const Color(0xFFD4F5E1)
                : const Color(0xFFFFF0D4),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            isIn ? "INSIDE" : "EXITED",
            style: GoogleFonts.outfit(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: isIn
                  ? const Color(0xFF16A765)
                  : const Color(0xFFB8860B),
            ),
          ),
        ),
      ],
    );
  }
}
