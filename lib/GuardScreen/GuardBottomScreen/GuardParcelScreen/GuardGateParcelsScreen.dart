import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

class GuardGateParcelsScreen extends StatefulWidget {
  const GuardGateParcelsScreen({super.key});

  @override
  State<GuardGateParcelsScreen> createState() => _GuardGateParcelsScreenState();
}

class _GuardGateParcelsScreenState extends State<GuardGateParcelsScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  int selectedFilter = 0; // 0: All, 1: At Gate, 2: Collected

  final List<Map<String, dynamic>> gateParcels = [
    {
      "id": "GP-101",
      "company": "Amazon",
      "flatNumber": "A-204",
      "residentName": "Amit Sharma",
      "inTime": "10:15 AM",
      "date": "Today",
      "status": "HELD_AT_GATE",
      "pickupOtp": "4921",
      "tracking": "TKR-8492041",
    },
    {
      "id": "GP-102",
      "company": "Flipkart",
      "flatNumber": "B-302",
      "residentName": "Pooja Mehta",
      "inTime": "11:00 AM",
      "date": "Today",
      "status": "HELD_AT_GATE",
      "pickupOtp": "8319",
      "tracking": "FK-9921045",
    },
    {
      "id": "GP-103",
      "company": "Zomato",
      "flatNumber": "C-101",
      "residentName": "Rohan Gupta",
      "inTime": "09:40 AM",
      "date": "Today",
      "status": "COLLECTED",
      "outTime": "10:10 AM",
      "pickupOtp": "1104",
      "tracking": "ZOM-772910",
    },
    {
      "id": "GP-104",
      "company": "Blinkit",
      "flatNumber": "D-405",
      "residentName": "Vikram Sethi",
      "inTime": "08:30 AM",
      "date": "Today",
      "status": "COLLECTED",
      "outTime": "09:00 AM",
      "pickupOtp": "5532",
      "tracking": "BLK-110294",
    },
  ];

  void _showReleaseParcelDialog(Map<String, dynamic> parcel) {
    otpController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F0E9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.lock_open_rounded,
                  color: AppColors.heading,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  "Release Parcel",
                  style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.heading,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify resident's 4-digit pickup code or scan QR to release parcel for Flat ${parcel['flatNumber']}.",
                style: GoogleFonts.outfit(
                  fontSize: 13.sp,
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF9F4),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xFFE5E0D5)),
                ),
                child: Row(
                  children: [
                    Text(
                      parcel['company'],
                      style: GoogleFonts.outfit(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.heading,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Expected OTP: ${parcel['pickupOtp']}",
                      style: GoogleFonts.outfit(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFB8860B),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Enter 4-Digit Pickup OTP",
                style: GoogleFonts.outfit(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                ),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 8,
                  color: AppColors.heading,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  hintText: "••••",
                  hintStyle: GoogleFonts.outfit(
                    fontSize: 22.sp,
                    color: Colors.grey,
                    letterSpacing: 8,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: GoogleFonts.outfit(
                  color: const Color(0xFF666666),
                  fontSize: 14.sp,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.heading,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () {
                setState(() {
                  parcel['status'] = "COLLECTED";
                  parcel['outTime'] = "Just now";
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF16A765),
                    content: Text(
                      "Parcel released to collector for Flat ${parcel['flatNumber']}!",
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                "Verify & Hand Over",
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = gateParcels.where((p) {
      if (selectedFilter == 1) return p['status'] == "HELD_AT_GATE";
      if (selectedFilter == 2) return p['status'] == "COLLECTED";
      return true;
    }).toList();

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
                    "Gate Held Parcels",
                    style: GoogleFonts.outfit(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Leave-at-gate locker & pickup verification",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // Overview Stats Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFE8B900),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "📦",
                                style: TextStyle(fontSize: 18.sp),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF7D9),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  "Locker",
                                  style: GoogleFonts.outfit(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFB8860B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "2 Held",
                            style: GoogleFonts.outfit(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.heading,
                            ),
                          ),
                          Text(
                            "Waiting for pickup",
                            style: GoogleFonts.outfit(
                              fontSize: 12.sp,
                              color: const Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "✅",
                                style: TextStyle(fontSize: 18.sp),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4F5E1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  "Today",
                                  style: GoogleFonts.outfit(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF16A765),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "2 Handed Over",
                            style: GoogleFonts.outfit(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.heading,
                            ),
                          ),
                          Text(
                            "Delivered to collector",
                            style: GoogleFonts.outfit(
                              fontSize: 12.sp,
                              color: const Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 18.h),

              // Filter Chips
              Row(
                children: [
                  _filterChip(label: "All Parcels", index: 0),
                  SizedBox(width: 8.w),
                  _filterChip(label: "At Gate (2)", index: 1),
                  SizedBox(width: 8.w),
                  _filterChip(label: "Collected (2)", index: 2),
                ],
              ),

              SizedBox(height: 16.h),

              // List of Parcels
              ListView.builder(
                itemCount: filteredList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final parcel = filteredList[index];
                  final isHeld = parcel['status'] == "HELD_AT_GATE";

                  return Container(
                    margin: EdgeInsets.only(bottom: 14.h),
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: isHeld
                            ? const Color(0xFFE8B900)
                            : const Color(0xFFE2E2E2),
                        width: isHeld ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F0E9),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                Icons.inventory_2_outlined,
                                color: AppColors.heading,
                                size: 22.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        parcel['company'],
                                        style: GoogleFonts.outfit(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.heading,
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                          vertical: 2.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF3F0E9),
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        child: Text(
                                          parcel['tracking'],
                                          style: GoogleFonts.outfit(
                                            fontSize: 11.sp,
                                            color: const Color(0xFF666666),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "Flat ${parcel['flatNumber']} · ${parcel['residentName']}",
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
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: isHeld
                                    ? const Color(0xFFFFF4D1)
                                    : const Color(0xFFD4F5E1),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                isHeld ? "AT GATE" : "RELEASED",
                                style: GoogleFonts.outfit(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isHeld
                                      ? const Color(0xFFB8860B)
                                      : const Color(0xFF16A765),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),
                        const Divider(height: 1, color: Color(0xFFEEEEEE)),
                        SizedBox(height: 10.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "In-Time: ${parcel['inTime']}",
                              style: GoogleFonts.outfit(
                                fontSize: 13.sp,
                                color: const Color(0xFF777777),
                              ),
                            ),
                            if (isHeld)
                              SizedBox(
                                height: 34.h,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.heading,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14.w,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                  ),
                                  onPressed: () =>
                                      _showReleaseParcelDialog(parcel),
                                  icon: Icon(Icons.qr_code_2, size: 16.sp),
                                  label: Text(
                                    "Verify & Release",
                                    style: GoogleFonts.outfit(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            else
                              Text(
                                "Handed Over: ${parcel['outTime']}",
                                style: GoogleFonts.outfit(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF16A765),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterChip({required String label, required int index}) {
    final isSelected = selectedFilter == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.heading : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.heading : const Color(0xFFDDDDDD),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.heading,
          ),
        ),
      ),
    );
  }
}
