import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

import '../ResidentBottomScreen/ResidentRequestScreen/provider/getComplaintTrackingProvider.dart';

class Residentcomplantstatus extends ConsumerStatefulWidget {
  final String complainID;
  const Residentcomplantstatus({super.key, required this.complainID});

  @override
  ConsumerState<Residentcomplantstatus> createState() =>
      _ResidentcomplantstatusState();
}

class _ResidentcomplantstatusState
    extends ConsumerState<Residentcomplantstatus> {
  final List<Map<String, dynamic>> statusList = [
    {
      "title": "Complaint Raised",
      "description": "Your complaint was submitted",
      "status": "completed",
    },
    {
      "title": "Token Generated",
      "description": "Token #RES-1048 assigned",
      "status": "completed",
    },
    {
      "title": "Under Review",
      "description": "Complaint reviewed by association",
      "status": "completed",
    },
    {
      "title": "In Progress",
      "description": "Issue is currently being resolved",
      "status": "current",
    },
    {
      "title": "Resolved",
      "description": "Complaint will be marked resolved",
      "status": "pending",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final getComplaintStatus = ref.watch(
      getComplaintTrackingProvider(widget.complainID),
    );
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
                    "Complain Status",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Track Your Complain",
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
      body: getComplaintStatus.when(
        data: (data) {
          final timeline = data.data?.complaintProgress?.timeline ?? [];
          final tokenCard = data.data?.complaintTokenCard;
          final isOverdue = tokenCard?.isOverdue == true ||
              (tokenCard?.statusBadge ?? "")
                  .toLowerCase()
                  .contains("overdue") ||
              (tokenCard?.statusBadge ?? "")
                  .toLowerCase()
                  .contains("emergency");

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: isOverdue ? const Color(0xFFFFFBFB) : Colors.white,
                      border: Border.all(
                        color: isOverdue
                            ? const Color(0xFFD32F2F)
                            : const Color(0xff15221C),
                        width: isOverdue ? 1.5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Complaint Token\n",
                                      style: GoogleFonts.outfit(
                                        fontSize: 13.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: tokenCard?.tokenTitle ?? "N/A",
                                      style: GoogleFonts.outfit(
                                        fontSize: 19.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _status(
                              tokenCard?.statusBadge ?? "N/A",
                              isOverdue: isOverdue,
                            ),
                          ],
                        ),

                        Divider(),

                        Text(
                          tokenCard?.issueTitle ?? "N/A",
                          style: GoogleFonts.outfit(fontSize: 19.sp),
                        ),

                        // _info(
                        //   Icons.home_outlined,
                        //   "Apartment Number",
                        //   "A-204",
                        // ),
                        // _info(Icons.home_outlined, "Status", "In Progress"),
                        // _info(
                        //   Icons.calendar_month_outlined,
                        //   "Submitted",
                        //   "01 Sep 2026 · 10:42 AM",
                        // ),
                        ...?(data.data?.complaintTokenCard?.details?.map((
                          item,
                        ) {
                          final label = item.label ?? "";
                          final value = item.value ?? "N/A";

                          IconData icon;

                          switch (label.toLowerCase()) {
                            case "apartment number":
                              icon = Icons.home_outlined;
                              break;

                            case "status":
                              icon = Icons.info_outline;
                              break;

                            case "submitted":
                              icon = Icons.calendar_month_outlined;
                              break;

                            default:
                              icon = Icons.description_outlined;
                          }

                          return _info(icon, label, value);
                        }).toList()),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 18.h),
                    decoration: BoxDecoration(
                      color: const Color(0xffF8F6ED),
                      border: Border.all(
                        color: const Color(0xff071811),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Complaint Progress",
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff071811),
                          ),
                        ),

                        SizedBox(height: 25.h),

                        ...List.generate(timeline.length, (index) {
                          final item = timeline[index];

                          return _TimelineItem(
                            title: item.title ?? "N/A",
                            description: item.description ?? "N/A",
                            status: item.statusState ?? "N/A",
                            isLast: index == timeline.length - 1,
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: isOverdue
                          ? const Color(0xFFFFEBEE)
                          : const Color.fromRGBO(184, 134, 11, 0.2),
                      border: isOverdue
                          ? Border.all(color: const Color(0xFFFFCDD2))
                          : null,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: isOverdue
                                ? const Color(0xFFFFCDD2)
                                : const Color.fromRGBO(184, 134, 11, 0.3),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            isOverdue
                                ? Icons.warning_amber_rounded
                                : Icons.build,
                            size: 20.sp,
                            color: isOverdue
                                ? const Color(0xFFD32F2F)
                                : const Color(0xffB8860B),
                          ),
                        ),

                        SizedBox(width: 10.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isOverdue
                                    ? "OVERDUE / EMERGENCY ACTION"
                                    : (data.data?.currentStatusBanner?.label ??
                                        "CURRENT STATUS"),
                                style: GoogleFonts.outfit(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isOverdue
                                      ? const Color(0xFFD32F2F)
                                      : AppColors.heading,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                isOverdue
                                    ? "Action deadline has passed without resolution. Escalated to Association Committee for emergency intervention."
                                    : (data.data?.currentStatusBanner?.message ??
                                        "Your complaint is In Progress"),
                                style: GoogleFonts.outfit(
                                  fontSize: isOverdue ? 13.sp : 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isOverdue
                                      ? const Color(0xFFD32F2F)
                                      : AppColors.heading,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text("Something went wrong $error"));
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(color: AppColors.heading),
          );
        },
      ),
    );
  }

  Widget _info(IconData icon, String title, String value) {
    return Column(
      children: [
        Divider(),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(9.w),
              decoration: BoxDecoration(
                color: const Color(0xffE9D8A9),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Icon(icon, color: const Color(0xffC29424)),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                ),
                Text(value, style: GoogleFonts.outfit(fontSize: 18.sp)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _status(String text, {bool isOverdue = false}) {
    final lower = text.toLowerCase();
    final overdue = isOverdue || lower.contains("overdue") || lower.contains("emergency");
    final resolved = lower.contains("resolved") || lower.contains("completed");

    Color bg;
    Color textColor;
    Border? border;
    String label = text;

    if (overdue) {
      bg = const Color(0xFFFFEBEE);
      textColor = const Color(0xFFD32F2F);
      border = Border.all(color: const Color(0xFFEF9A9A));
      label = "OVERDUE / EMERGENCY 🔴";
    } else if (resolved) {
      bg = const Color(0xFFE8F5E9);
      textColor = const Color(0xFF2E7D32);
      border = Border.all(color: const Color(0xFFA5D6A7));
    } else {
      bg = const Color(0xffE8D39A);
      textColor = const Color(0xffA77A12);
      border = null;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bg,
        border: border,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final bool isLast;

  const _TimelineItem({
    required this.title,
    required this.description,
    required this.status,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final completed = status == "completed";
    final current = status == "current";

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              _circle(completed, current),
              if (!isLast)
                Expanded(
                  child: Container(width: 1.w, color: const Color(0xff707070)),
                ),
            ],
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.2,
                      color: current
                          ? const Color(0xffB8860B)
                          : status == "pending"
                          ? const Color(0xff777777)
                          : const Color(0xff071811),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      color: const Color(0xff666666),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(bool completed, bool current) {
    if (completed) {
      return Container(
        width: 25.w,
        height: 25.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff071811),
        ),
        child: Icon(Icons.check, color: Colors.white, size: 17.sp),
      );
    }

    if (current) {
      return Container(
        width: 25.w,
        height: 25.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xffB8860B), width: 1.5),
        ),
        child: Center(
          child: Container(
            width: 11.w,
            height: 11.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffB8860B),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 25.w,
      height: 25.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xff777777), width: 1),
      ),
    );
  }
}
