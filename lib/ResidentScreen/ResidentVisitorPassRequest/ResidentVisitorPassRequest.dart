import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/Core/Utils/showMessage.dart';

import '../../Core/AuthService/AuthServiceProvider.dart';
import 'provider/getVisitorPassListProvider.dart';

class Residentvisitorpassrequest extends ConsumerStatefulWidget {
  const Residentvisitorpassrequest({super.key});

  @override
  ConsumerState<Residentvisitorpassrequest> createState() =>
      _ResidentvisitorpassrequestState();
}

class _ResidentvisitorpassrequestState
    extends ConsumerState<Residentvisitorpassrequest> {
  final visitorNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  int? selected;
  DateTime? selectedDate;
  TimeOfDay? selectedTime1;
  bool isVisitorLoading = false;

  String get dateText {
    if (selectedDate == null) {
      return "DD / MM / YYYY";
    }

    return "${selectedDate!.day.toString().padLeft(2, '0')} / "
        "${selectedDate!.month.toString().padLeft(2, '0')} / "
        "${selectedDate!.year}";
  }

  // Time Format
  String get timeText1 {
    if (selectedTime1 == null) {
      return "00:00";
    }

    return selectedTime1!.format(context);
  }

  Future<void> selectDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  // Time Picker
  Future<void> selectTime1() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime1 ?? TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        selectedTime1 = time;
      });
    }
  }

  String? selectedPurpose;
  final List<String> purposeList = [
    "Personal / Family Visit",
    "Delivery (Food / Parcel)",
    "Home Maintenance / Repair",
    "Housekeeping / Cleaning",
    "Cab / Taxi Pickup",
    "Official / Business",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getVisitorListProvider);
    final headers = state.valueOrNull?.data?.heroCard;
    final isLoading = state.isLoading;
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
                    "Visitor Pass Request",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Request entry access for your visitor",
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
              SizedBox(height: 16.h),
              isLoading
                  ? Container(
                      width: double.infinity,
                      height: 150.h,
                      decoration: BoxDecoration(
                        color: AppColors.heading,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.scaffoldBg,
                          strokeWidth: 1.w,
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.heading,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF514719),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Icon(
                              Icons.person_2_outlined,
                              color: Color(0xffB8860B),
                              size: 16.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            headers?.title ?? "Request a Visitor Pass",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            headers?.subtitle ??
                                "Create a visitor request for access to your registered apartment.",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 10.h),
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
                              headers?.registeredApartment?.text ??
                                  "Green Valley · Building A · A-204",
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
              SizedBox(height: 20.h),
              Text(
                "Visitor Details",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(17.w),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff101C16)),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Visitor Name",
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: visitorNameController,
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.2,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        hintText: "Enter Visitor Name",
                        hintStyle: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(42, 41, 51, 0.6),
                          letterSpacing: -0.2,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.r),
                          borderSide: const BorderSide(
                            color: Color(0xff101C16),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.r),
                          borderSide: const BorderSide(
                            color: Color(0xff101C16),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      "Mobile Number",
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: mobileNumberController,
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.2,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number",
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        hintStyle: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(42, 41, 51, 0.6),
                          letterSpacing: -0.2,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.r),
                          borderSide: const BorderSide(
                            color: Color(0xff101C16),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.r),
                          borderSide: const BorderSide(
                            color: Color(0xff101C16),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Visitor Type",
                      style: GoogleFonts.outfit(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = 0;
                              });
                            },
                            child: visitorType("Guest", selected == 0),
                          ),
                        ),

                        SizedBox(width: 20.w),

                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = 1;
                              });
                            },
                            child: visitorType("Service", selected == 1),
                          ),
                        ),
                      ],
                    ),

                    /*
                    // ==========================================================================
                    // [POINT 3] QUICK VISITOR TYPE & DELIVERY / CAB SELECTION CHIPS
                    // To enable, uncomment this section.
                    // Allows resident to quickly tap Swiggy, Zomato, Cab (Uber/Ola), Amazon, Guest, etc.
                    // ==========================================================================
                    SizedBox(height: 14.h),
                    Text(
                      "Quick Select Category",
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff777777),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        {
                          "name": "Swiggy / Zomato",
                          "icon": Icons.delivery_dining,
                          "color": const Color(0xffFF5200),
                        },
                        {
                          "name": "Amazon / Parcel",
                          "icon": Icons.local_shipping_outlined,
                          "color": const Color(0xff232F3E),
                        },
                        {
                          "name": "Cab (Uber / Ola)",
                          "icon": Icons.local_taxi,
                          "color": const Color(0xff000000),
                        },
                        {
                          "name": "Home Service / Repair",
                          "icon": Icons.build_outlined,
                          "color": const Color(0xff007665),
                        },
                        {
                          "name": "Family / Guest",
                          "icon": Icons.people_outline,
                          "color": const Color(0xffB8860B),
                        },
                      ].map((item) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: const Color(0xffD9D9D0)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(item["icon"] as IconData, size: 14.sp, color: item["color"] as Color),
                              SizedBox(width: 5.w),
                              Text(
                                item["name"] as String,
                                style: GoogleFonts.outfit(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.heading,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    */
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                "Visitor Details",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(17.w),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff101C16)),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: buildField(
                            title: "Visit Date",
                            value: dateText,
                            icon: Icons.calendar_month_outlined,
                            onTap: selectDate,
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: buildField(
                            title: "Visit Time",
                            value: timeText1,
                            icon: Icons.access_time_outlined,
                            onTap: selectTime1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Purpose of Visit",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    Container(
                      height: 48.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        border: Border.all(
                          color: Color(0xff101C16),
                          width: 1.5,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedPurpose,
                          isExpanded: true,
                          hint: Text(
                            "Select purpose",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF666666),
                              letterSpacing: -0.2,
                            ),
                          ),
                          isDense: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: const Color(0xFF101C16),
                            size: 22.sp,
                          ),
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff101C16),
                            letterSpacing: -0.2,
                          ),
                          items: purposeList.map((String purpose) {
                            return DropdownMenuItem<String>(
                              value: purpose,
                              child: Text(
                                purpose,
                                style: GoogleFonts.outfit(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPurpose = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () async {
                  if (visitorNameController.text.isEmpty) {
                    showErrorSnackBar("Please enter visitor name");
                    return;
                  }
                  if (mobileNumberController.text.isEmpty) {
                    showErrorSnackBar("Please enter mobile number");
                    return;
                  }
                  if (selected == null) {
                    showErrorSnackBar("Please select visitor type");
                    return;
                  }
                  if (dateText.isEmpty) {
                    showErrorSnackBar("Please select visit date");
                    return;
                  }
                  if (timeText1.isEmpty) {
                    showErrorSnackBar("Please select visit time");
                    return;
                  }

                  if (selectedPurpose == null) {
                    showErrorSnackBar("Please select purpose of visit");
                    return;
                  }

                  setState(() {
                    isVisitorLoading = true;
                  });

                  try {
                    final service = ref.read(authServiceProvider);
                    final res = await service.createVisitorPassRequest(
                      visitorName: visitorNameController.text,
                      mobileNumber: mobileNumberController.text,
                      visitorType: selected == 0 ? "guest" : "service",
                      visitDate: dateText,
                      visitTime: timeText1,
                      purposeOfVisit: selectedPurpose!,
                    );
                    if (res.status == true) {
                      visitorNameController.clear();
                      mobileNumberController.clear();
                      setState(() {
                        selected = null;
                        selectedDate = null;
                        selectedTime1 = null;
                        selectedPurpose = null;
                      });
                      ref.invalidate(getVisitorListProvider);
                      showSuccessSnackBar(
                        res.message ?? "Pass created successfully",
                      );
                    } else {
                      showErrorSnackBar(res.message ?? "Failed to create pass");
                    }
                  } catch (e) {
                    log(e.toString());
                  } finally {
                    setState(() {
                      isVisitorLoading = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45.h),
                  backgroundColor: const Color(0xff0D1C16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                child: isVisitorLoading
                    ? Center(
                        child: SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            color: AppColors.scaffoldBg,
                            strokeWidth: 1.5,
                          ),
                        ),
                      )
                    : Text(
                        "Submit Visitor Request",
                        style: GoogleFonts.outfit(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Recent Request",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 12.h),
              state.when(
                data: (data) {
                  final request = data.data!.recentRequests?.requests ?? [];
                  if (request.isEmpty) {
                    return Center(
                      child: Text(
                        "No recent requests",
                        style: GoogleFonts.outfit(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: request.length,
                    itemBuilder: (context, index) {
                      final item = request[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF8E2),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38.w,
                              height: 38.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFF101C16),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.check,
                                size: 20.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // "Visitor Request #VP-1024",
                                    item.title ?? "N/A",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF101C16),
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    // "Sarah Ahmed · Today, 06:30 PM",
                                    item.subtitle ?? "N/A",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF555555),
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEBD9A5),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                // "Pending",
                                item.status ?? "N/A",
                                style: GoogleFonts.outfit(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFB8860B),
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  return Text("Something went wrong");
                },
                loading: () => Center(
                  child: CircularProgressIndicator(color: AppColors.heading),
                ),
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget visitorType(String title, bool selected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: selected ? const Color(0xff0D1C16) : Colors.transparent,
        border: Border.all(color: const Color(0xff101C16)),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(7.w),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xff4A4510)
                  : const Color(0xffE8D39F),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(
              Icons.person_outline,
              color: const Color(0xffC49400),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 15.sp,
              color: selected ? Colors.white : const Color(0xff101C16),
              fontWeight: FontWeight.w500,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildField({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final isHint = value == "DD / MM / YYYY" || value == "00:00";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: TextEditingController(text: value),
          readOnly: true,
          onTap: onTap,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isHint ? const Color(0xFF666666) : const Color(0xFF101C16),
            letterSpacing: -0.2,
          ),
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 8.w),
              child: Icon(icon, size: 19.sp, color: const Color(0xFF777777)),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            hintText: "DD / MM / YYYY",
            hintStyle: GoogleFonts.outfit(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF666666),
              letterSpacing: -0.2,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.r),
              borderSide: const BorderSide(color: Color(0xFF777777), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.r),
              borderSide: const BorderSide(color: Colors.black, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}
