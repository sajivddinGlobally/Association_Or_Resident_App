import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:svg_flutter/svg.dart';

class ResidentAiPropertyassistant extends StatefulWidget {
  const ResidentAiPropertyassistant({super.key});

  @override
  State<ResidentAiPropertyassistant> createState() => _ResidentAiPropertyassistantState();
}

class _ResidentAiPropertyassistantState extends State<ResidentAiPropertyassistant> {
   final TextEditingController messageController = TextEditingController();

  List<String> messages = [];

  void sendMessage() {
    String message = messageController.text.trim();

    if (message.isEmpty) return;

    setState(() {
      messages.add(message);
      messageController.clear();
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
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
                    "AI Property Assistant",
                    style: GoogleFonts.outfit(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Your property information assistant",
                    style: GoogleFonts.outfit(
                      fontSize: 15.sp,
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.heading),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "AI Assistant is",
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.heading,
                          letterSpacing: -0.24,
                        ),
                      ),
                      TextSpan(
                        text: " Ready",
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffAE8130),
                          letterSpacing: -0.24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF101C16),
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Container(
                          width: 39.w,
                          height: 39.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF101C16),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/SvgImage/vector.svg",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Hello, how can I help?",
                      style: GoogleFonts.outfit(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff292832),
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Ask questions about your property, inspections, maintenance,\n complaints, service requests and property status.",
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff292832),
                        letterSpacing: -0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.heading),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: AppColors.heading),
                      ),
                      child: Center(
                        child:
                            // Image.asset(
                            //   "assets/auditImg.png",
                            //   height: 18.h,
                            //   width: 18.w,
                            // ),
                            Icon(Icons.apartment_outlined, size: 18.r),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Apartment A-204",
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            color: AppColors.heading,
                            fontSize: 17.sp,
                            letterSpacing: -0.2,
                          ),
                        ),
                        Text(
                          "Green Valley Residency",
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(42, 41, 51, 0.5),
                            fontSize: 13.sp,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      "Active",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w500,
                        color: AppColors.heading,
                        fontSize: 15.sp,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Suggested Questions",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  fontSize: 17.sp,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                color: const Color(0xFFFFFCEF),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _questionCard(
                            icon: Icons.crop_square,
                            title: "What is my current property status?",
                            isSelected: true,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: _questionCard(
                            icon: Icons.check,
                            title: "Show my latest inspection status",
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        Expanded(
                          child: _questionCard(
                            icon: Icons.settings,
                            title: "What maintenance is pending?",
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: _questionCard(
                            icon: Icons.priority_high,
                            title: "Do I have any open complaints?",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 17.h),
              Text(
                "Assistant",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  fontSize: 17.sp,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                width: double.infinity,
                constraints: BoxConstraints(minHeight: 145.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFCEF),
                  border: Border.all(color: const Color(0xFF222222), width: 1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 17.h,
                          width: 17.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB78932),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          child: Text(
                            "AI",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Expanded(
                          child: Text(
                            "Your property score is 86/100. There are currently 2 open "
                            "issues recorded for your property.",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              color: AppColors.heading,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 216.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 9.w,
                          vertical: 7.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFCEF),
                          border: Border.all(
                            color: AppColors.heading,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          "What maintenance is currently pending?",
                          style: GoogleFonts.outfit(
                            fontSize: 12.sp,
                            color: AppColors.heading,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 17.h,
                          width: 17.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB78932),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          child: Text(
                            "AI",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Expanded(
                          child: Text(
                            "Based on the available maintenance records, there is "
                            "currently 1 pending maintenance activity. You can view "
                            "its complete details in Maintenance History.",
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              color: AppColors.heading,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (messages.isNotEmpty) ...[
                      SizedBox(height: 10.h),

                      ...messages.map((message) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 216.w),
                              padding: EdgeInsets.symmetric(
                                horizontal: 9.w,
                                vertical: 7.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.heading,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                message,
                                style: GoogleFonts.outfit(
                                  fontSize: 12.sp,
                                  color: AppColors.heading,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,

                      // Text ko vertically center rakhega
                      textAlignVertical: TextAlignVertical.center,

                      cursorHeight: 23.h,
                      cursorColor: AppColors.heading,
                      cursorWidth: 1.5.w,

                      textInputAction: TextInputAction.send,

                      onSubmitted: (_) {
                        sendMessage();
                      },

                      decoration: InputDecoration(
                        isDense: true,

                        hintText: "Ask about your property...",
                        hintStyle: GoogleFonts.outfit(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(16, 28, 22, 0.6),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(color: AppColors.heading),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(16, 28, 22, 0.6),
                          ),
                        ),

                        // Important
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 9.w),

                  GestureDetector(
                    onTap: sendMessage,
                    child: Container(
                      height: 47.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10201A),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Text(
                "What I Can Help With",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  fontSize: 15.sp,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 12.h),
              Column(
                children: [
                  propertyOption(
                    icon: Icons.home_outlined,
                    title: "Property details and current property status",
                  ),

                  propertyOption(
                    icon: Icons.check,
                    title: "Inspection and audit information",
                  ),

                  propertyOption(
                    icon: Icons.settings,
                    title: "Maintenance and service request updates",
                  ),

                  propertyOption(
                    icon: Icons.priority_high,
                    title: "Maintenance and service request updates",
                  ),

                  propertyOption(
                    icon: Icons.radio_button_checked,
                    title: "Maintenance and service request updates",
                  ),
                ],
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
   Widget _questionCard({
    required IconData icon,
    required String title,
    bool isSelected = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF8C8C8C)),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 15.sp, color: const Color(0xFF777777)),
          SizedBox(height: 10.h),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF777777),
            ),
          ),
        ],
      ),
    );
  }

  Widget propertyOption({required IconData icon, required String title}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Container(
                height: 29.h,
                width: 29.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 16.sp, color: Colors.black),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.heading,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, thickness: 1.2, color: Colors.grey),
      ],
    );
  }
}