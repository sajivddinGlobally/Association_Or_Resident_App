import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/ResidentScreen/ResidentBottomScreen/ResidentRequestScreen/ResidentRequestScreen.dart';

import '../../Core/AuthService/AuthServiceProvider.dart';
import '../../Core/Utils/showMessage.dart';

class Raisecomplaint extends ConsumerStatefulWidget {
  const Raisecomplaint({super.key});

  @override
  ConsumerState<Raisecomplaint> createState() => _RaisecomplaintState();
}

class _RaisecomplaintState extends ConsumerState<Raisecomplaint> {
  File? image;
  bool isLoading = false;
  String? selectedCategory;

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<Map<String, dynamic>> issueCategories = [
    {
      "key": "water_leakage",
      "icon": Icons.water_drop_outlined,
      "title": "WATER LEAKAGE",
      "subtitle": "Apartment or common-area leakage",
    },
    {
      "key": "electrical",
      "icon": Icons.bolt_outlined,
      "title": "ELECTRICAL",
      "subtitle": "Apartment or common-area issue",
    },
    {
      "key": "lift",
      "icon": Icons.elevator_outlined,
      "title": "LIFT PROBLEM",
      "subtitle": "Common building lift issue",
    },
    {
      "key": "plumbing",
      "icon": Icons.plumbing_outlined,
      "title": "PLUMBING",
      "subtitle": "Apartment plumbing problem",
    },
    {
      "key": "ac_cooling",
      "icon": Icons.ac_unit_outlined,
      "title": "AC / COOLING",
      "subtitle": "AC / Cooling",
    },
    {
      "key": "other",
      "icon": Icons.grain_outlined,
      "title": "OTHER",
      "subtitle": "Other issue",
    },
  ];

  @override
  void dispose() {
    subjectController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: const Color(0xFFF5F2E9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              SizedBox(height: 15.h),

              Text(
                "Add Photo",
                style: GoogleFonts.outfit(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF101C16),
                ),
              ),

              SizedBox(height: 18.h),

              Row(
                children: [
                  Expanded(
                    child: _photoOption(
                      icon: Icons.camera_alt_outlined,
                      title: "Camera",
                      onTap: () => Navigator.pop(context, ImageSource.camera),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _photoOption(
                      icon: Icons.photo_library_outlined,
                      title: "Gallery",
                      onTap: () => Navigator.pop(context, ImageSource.gallery),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );

    if (source != null) {
      final picked = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80,
      );

      if (picked != null) {
        setState(() {
          image = File(picked.path);
        });
      }
    }
  }

  void showComplaintSuccessPopup(BuildContext context, String token) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20.w, 32.h, 20.w, 31.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Circle
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffD8EEE5),
                    border: Border.all(
                      color: const Color(0xff16A36B),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      size: 35.sp,
                      color: const Color(0xff009B62),
                    ),
                  ),
                ),

                SizedBox(height: 14.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 17.w,
                    vertical: 7.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffD5EEE5),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 13.sp,
                        color: const Color(0xff009B62),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "COMPLAINT SUBMITTED",
                        style: GoogleFonts.outfit(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff009B62),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),

                Text(
                  "Complaint Raised Successfully",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.heading,
                    letterSpacing: -0.2,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  "Your complaint has been submitted successfully. A\n"
                  "unique token number has been generated for tracking\n"
                  "your complaint.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    height: 1.25,
                    color: AppColors.heading,
                    letterSpacing: -0.2,
                  ),
                ),

                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Complaint Token",
                        style: GoogleFonts.outfit(
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        // "#CMP-1048",
                        token,
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff009B62),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15.h),
                SizedBox(
                  width: double.infinity,
                  height: 36.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Residentrequestscreen par jao
                      // Aur Home Screen ko stack mein rehne do
                      Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (context) =>
                              Residentrequestscreen(showBackButton: true),
                        ),
                        (route) => route.isFirst,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff071811),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    child: Text(
                      "View Complaint Status →",
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
                    "Raise Complaint",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Tell us what needs attention",
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
              SizedBox(height: 30.h),
              Text(
                "Issue Category",
                style: GoogleFonts.outfit(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 16.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: issueCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.70,
                ),
                itemBuilder: (context, index) {
                  final cat = issueCategories[index];
                  final isSelected = selectedCategory == cat["key"];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = cat["key"] as String;
                        subjectController.text = cat["title"] as String;
                      });
                    },
                    child: _issueCard(
                      icon: cat["icon"] as IconData,
                      title: cat["title"] as String,
                      subtitle: cat["subtitle"] as String,
                      isSelected: isSelected,
                    ),
                  );
                },
              ),
              SizedBox(height: 18.h),
              // Subject Field
              Text(
                "Subject",
                style: GoogleFonts.outfit(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: subjectController,
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF101C16),
                ),
                decoration: InputDecoration(
                  hintText: "e.g. Bathroom Water Leakage",
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF888888),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFF999999)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFF999999)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(
                      color: Color(0xFF101C16),
                      width: 1.4,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Description",
                style: GoogleFonts.outfit(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                height: 169.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13.r),
                ),
                child: TextField(
                  maxLines: null,
                  expands: true,
                  controller: descriptionController,
                  textAlignVertical: TextAlignVertical.top,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF101C16),
                  ),
                  decoration: InputDecoration(
                    hintText: "Tell us what's wrong...",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF888888),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 19.w,
                      right: 15.w,
                      top: 18.h,
                      bottom: 15.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Color(0xFF999999),
                        width: 1.2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Color(0xFF999999),
                        width: 1.2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Color(0xFF101C16),
                        width: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Add Photo (Optional)",
                style: GoogleFonts.outfit(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBD9A5),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: image == null
                            ? Icon(
                                Icons.camera_alt_outlined,
                                color: const Color(0xFFB8860B),
                                size: 20.sp,
                              )
                            : Image.file(image!, fit: BoxFit.cover),
                      ),

                      SizedBox(width: 15.w),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              image == null ? "Add Photo" : "Change Photo",
                              style: GoogleFonts.outfit(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.2,
                                color: AppColors.heading,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Attach a photo to help us understand the issue",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Icon(Icons.arrow_forward_ios, size: 18.sp),
                    ],
                  ),
                ),
              ),
              /*
              // ==========================================================================
              // [POINT 2] PRIORITY SELECTION & HIGH PRIORITY ALERT TO COMMITTEE/ADMIN
              // To enable, uncomment this section.
              // Allows resident to mark urgency (Low, Medium, High).
              // When High Priority is marked, an alert indicates that Committee & Admin
              // are instantly notified for emergency action.
              // ==========================================================================
              SizedBox(height: 18.h),
              Text(
                "Priority Level",
                style: GoogleFonts.outfit(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: const Color(0xFFD9D9D0)),
                      ),
                      child: Center(
                        child: Text(
                          "Low",
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff1E88E5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: const Color(0xFFD9D9D0)),
                      ),
                      child: Center(
                        child: Text(
                          "Medium",
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffFB8C00),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: const Color(0xFFE53935), width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          "High (Urgent)",
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFE53935),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // High Priority Alert Notification Box
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF2F2),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFFFCDD2)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: const Color(0xFFD32F2F),
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "High Priority Alert Enabled",
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFD32F2F),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Submitting as High Priority immediately alerts the Association Head and Admin team via push notification and SMS for emergency action.",
                            style: GoogleFonts.outfit(
                              fontSize: 11.sp,
                              color: const Color(0xFF555555),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              */

              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 36.h,
                child: ElevatedButton(
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
                  onPressed: () async {
                    if (selectedCategory == null) {
                      showErrorSnackBar("Please select an issue category");
                      return;
                    }
                    if (subjectController.text.trim().isEmpty) {
                      showErrorSnackBar("Please enter a subject");
                      return;
                    }
                    if (descriptionController.text.trim().isEmpty) {
                      showErrorSnackBar("Please enter a description");
                      return;
                    }
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      MultipartFile? photoFile;
                      if (image != null) {
                        final fileName = image!.path
                            .split(Platform.pathSeparator)
                            .last;
                        photoFile = await MultipartFile.fromFile(
                          image!.path,
                          filename: fileName,
                        );
                      }
                      final authService = ref.read(authServiceProvider);
                      final response = await authService
                          .addResidentComplaintData(
                            category: selectedCategory!,
                            subject: subjectController.text.trim(),
                            description: descriptionController.text.trim(),
                            // priority: selectedPriority,
                            photo: photoFile,
                          );
                      if (response.status == true) {
                        if (mounted) {
                          showComplaintSuccessPopup(
                            context,
                            response.data?.complaint?.token ?? 'N/A',
                          );
                        }
                      } else {
                        showErrorSnackBar(
                          response.message ?? "Failed to raise complaint",
                        );
                      }
                    } catch (e) {
                      showErrorSnackBar(
                        "Failed to raise complaint: ${e.toString()}",
                      );
                    } finally {
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  child: isLoading
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Submit Complaint",
                          style: GoogleFonts.outfit(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _issueCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 11.w, right: 8.w, top: 10.h, bottom: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF1EADB) : Colors.transparent,
        border: Border.all(
          color: isSelected ? const Color(0xFFB8860B) : const Color(0xFF101C16),
          width: isSelected ? 2.0 : 1.2,
        ),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32.h,
            width: 32.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEBD9A5),
              borderRadius: BorderRadius.circular(6.r),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 19.sp, color: const Color(0xFFB8860B)),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF101C16),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
          color: const Color(0xFFEBD9A5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFB8860B)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 30.sp, color: const Color(0xFFB8860B)),
            SizedBox(height: 7.h),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF101C16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
