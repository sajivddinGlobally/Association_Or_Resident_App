import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:property_association_or_resident/AssociationScreen/AssociationHome/AssociationHome.dart';
import 'package:property_association_or_resident/AssociationScreen/Auth/register_screen.dart';
import 'package:property_association_or_resident/AssociationScreen/ForgotPassword/AssociationForgotPassword.dart';
import 'package:property_association_or_resident/Core/AuthService/AuthServiceProvider.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/Core/Utils/showMessage.dart';
import 'package:property_association_or_resident/ResidentScreen/ResidentHomeScreen/ResidentHomeScreen.dart';

class AssociationLogin extends ConsumerStatefulWidget {
  const AssociationLogin({super.key});

  @override
  ConsumerState<AssociationLogin> createState() => _AssociationLoginState();
}

class _AssociationLoginState extends ConsumerState<AssociationLogin> {
  bool isPasswordVisible = false;
  bool rememberMe = false;
  bool isLoading = false;
  int? selectIndex; // 0: Association Head, 1: Resident
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 170.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/circuler_img.png",
                      width: 146.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/circuler_img.png",
                      width: 177.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: ClipOval(
                child: Image.asset(
                  // "assets/property_img.png",
                  "assets/logo.png",
                  width: 75.w,
                  height: 75.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 70.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WELCOME BACK",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                      color: AppColors.heading,
                      fontSize: 18.sp,
                      letterSpacing: -0.39,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Sign in to manage and monitor your property.",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                      color: AppColors.heading,
                      fontSize: 14.sp,
                      letterSpacing: -0.39,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildRoleButton(
                          title: "Association Head",
                          backgroundColor: selectIndex == 0
                              ? const Color(0xFF101C16)
                              : Colors.transparent,
                          borderColor: const Color(0xFF101C16),
                          textColor: selectIndex == 0
                              ? Colors.white
                              : const Color(0xFF101C16),
                          onTap: () {
                            setState(() {
                              selectIndex = 0;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildRoleButton(
                          title: "Resident",
                          backgroundColor: selectIndex == 1
                              ? const Color(0xFF101C16)
                              : Colors.transparent,
                          borderColor: const Color(0xFF101C16),
                          textColor: selectIndex == 1
                              ? Colors.white
                              : const Color(0xFF101C16),
                          onTap: () {
                            setState(() {
                              selectIndex = 1;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "EMAIL OR MOBILE NUMBER",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                      color: AppColors.heading,
                      fontSize: 14.sp,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 44.h,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: TextField(
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        color: const Color(0xff101C16),
                        letterSpacing: -0.2,
                      ),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isDense: true,

                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Icon(
                            Icons.mail_outline,
                            color: const Color(0xff26332D),
                            size: 21.sp,
                          ),
                        ),

                        prefixIconConstraints: BoxConstraints(
                          minWidth: 41.w, // 10 left + 21 icon + 10 right
                          minHeight: 44.h,
                        ),

                        hintText: "Enter Email or mobile number",
                        hintStyle: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(16, 28, 22, 0.6),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.r),
                          borderSide: BorderSide(color: AppColors.heading),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.r),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(16, 28, 22, 0.6),
                          ),
                        ),

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "PASSWORD",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                      color: AppColors.heading,
                      fontSize: 14.sp,
                      letterSpacing: -0.39,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 44.h,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: TextField(
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        color: const Color(0xff101C16),
                        letterSpacing: -0.2,
                      ),
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Icon(
                            Icons.lock_outline,
                            color: const Color(0xff26332D),
                            size: 18.sp,
                          ),
                        ),

                        prefixIconConstraints: BoxConstraints(
                          minWidth: 38.w, // 10 left + 18 icon + 10 gap
                          minHeight: 44.h,
                        ),

                        hintText: "Enter your Password",
                        hintStyle: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(16, 28, 22, 0.6),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.r),
                          borderSide: BorderSide(color: AppColors.heading),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.r),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(16, 28, 22, 0.6),
                          ),
                        ),

                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(
                            minWidth: 40.w,
                            minHeight: 44.h,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.heading,
                            size: 16.sp,
                          ),
                        ),

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 12.w,
                              height: 12.h,
                              child: Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                },
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                                side: const BorderSide(
                                  color: AppColors.heading,
                                  width: 1.2,
                                ),
                              ),
                            ),

                            SizedBox(width: 10.w),

                            Text(
                              "Remember me",
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.heading,
                                letterSpacing: -0.39,
                              ),
                            ),
                          ],
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    AssociationForgotPasswordPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff101C16),
                              letterSpacing: -0.39,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    height: 41.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.heading,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),

                      onPressed: isLoading
                          ? null
                          : () async {
                              if (selectIndex == null) {
                                showErrorSnackBar("Please select role");
                                return;
                              }
                              if (emailController.text.trim().isEmpty) {
                                return;
                              }
                              if (passwordController.text.trim().isEmpty) {
                                return;
                              }
                              if (rememberMe == false) {
                                showErrorSnackBar("Please checked Remember Me");
                                return;
                              }

                              try {
                                setState(() {
                                  isLoading = true;
                                });
                                final service = ref.read(authServiceProvider);
                                final selectedRole = selectIndex == 0
                                    ? "association_head"
                                    : "apartment_resident";
                                final response = await service.login(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  role: selectedRole,
                                );
                                if (response.status == true) {
                                  var box = Hive.box("associationdata");
                                  await box.put("token", response.data!.token);
                                  await box.put("id", response.data!.user!.id);
                                  await box.put(
                                    "name",
                                    response.data!.user!.name,
                                  );
                                  final userRole = (response.data?.user?.role != null &&
                                          response.data!.user!.role!.toString().trim().isNotEmpty)
                                      ? response.data!.user!.role
                                      : selectedRole;
                                  await box.put(
                                    "role",
                                    userRole,
                                  );
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => selectIndex == 0
                                            ? const AssociationBottomNavBar()
                                            : const ResidentBottomNavBar(),
                                      ),
                                    );
                                  }
                                }
                              } catch (e) {
                                log(e.toString());
                              } finally {
                                if (mounted) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                      child: isLoading
                          ? Center(
                              child: SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: CircularProgressIndicator(
                                  color: AppColors.heading,
                                  strokeWidth: 1.5,
                                ),
                              ),
                            )
                          : Text(
                              "Login",
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w700,
                                fontSize: 13.sp,
                                color: Color(0xffFFFFFF),
                                letterSpacing: -0.24,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: GoogleFonts.outfit(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                              ),
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style: GoogleFonts.outfit(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 30.h),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Container(
                  //         margin: EdgeInsets.only(left: 38.w),
                  //         height: 2.h,
                  //         color: const Color(0xffB8BCB8),
                  //       ),
                  //     ),

                  //     SizedBox(width: 17.w),

                  //     Text(
                  //       "OR",
                  //       style: GoogleFonts.outfit(
                  //         fontSize: 17.sp,
                  //         fontWeight: FontWeight.w500,
                  //         color: const Color(0xff101C16),
                  //       ),
                  //     ),

                  //     SizedBox(width: 17.w),

                  //     Expanded(
                  //       child: Container(
                  //         margin: EdgeInsets.only(right: 38.w),
                  //         height: 2.h,
                  //         color: const Color(0xffB8BCB8),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 30.h),
                  // Container(
                  //   height: 41.h,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8.r),
                  //     border: Border.all(color: AppColors.heading),
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       "LOGIN WITH OTP",
                  //       style: GoogleFonts.outfit(
                  //         fontWeight: FontWeight.w700,
                  //         fontSize: 13.sp,
                  //         color: AppColors.heading,
                  //         letterSpacing: -0.24,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 80.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "SECURE PRIVATE PROPERTY MANAGEMENT",
                      style: GoogleFonts.outfit(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(16, 28, 22, 0.5),
                        letterSpacing: 2.16,
                      ),
                    ),
                  ),
                  SizedBox(height: 33.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required String title,
    required Color backgroundColor,
    required Color borderColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          side: BorderSide(color: borderColor, width: 1.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}
