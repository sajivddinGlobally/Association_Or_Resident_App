import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

import 'Provider/getServiceRequestStatusProvider.dart';

class ServiceRequestStatus extends ConsumerStatefulWidget {
  final String id;
  const ServiceRequestStatus({super.key, required this.id});

  @override
  ConsumerState<ServiceRequestStatus> createState() =>
      _ServiceRequestStatusState();
}

class _ServiceRequestStatusState extends ConsumerState<ServiceRequestStatus> {
  final List<Map<String, dynamic>> timeline = const [
    {
      'title': 'Request Raised',
      'description': 'Service request was submitted by the resident.',
      'date': '24 Aug 2026',
      'completed': true,
    },
    {
      'title': 'Request Reviewed',
      'description':
          'Association reviewed the request and approved it for service action.',
      'date': '24 Aug 2026',
      'completed': true,
    },
    {
      'title': 'Service Assigned',
      'description': 'Request assigned to the plumbing service provider.',
      'date': '24 Aug 2026',
      'completed': true,
    },
    {
      'title': 'Request Resolved',
      'description':
          'This step will be updated once the service work is completed.',
      'date': '',
      'completed': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final getServiceRequestStatusState = ref.watch(
      getServiceRequestStatusProvider(widget.id),
    );
    final headers = getServiceRequestStatusState.valueOrNull?.data?.header;

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
                    "Ticket Status Tracking",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    // "Service Request · SR-1024",
                    headers?.subtitle ?? "Service Request · SR-1024",
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
      body: getServiceRequestStatusState.when(
        data: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.black, width: 1.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                // "TICKET · SR-1024",
                                data.data?.ticketBanner?.tag ?? "N/A",
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFB8860B),
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: Text(
                                // "In Progress",
                                data.data?.ticketBanner?.status ?? "N/A",
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFB8860B),
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 242, 165, 0.3),
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: Icon(
                                Icons.trending_up,
                                color: Color(0xFFB8860B),
                                size: 15.sp,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // "Water Leakage",
                                    data.data?.ticketBanner?.title ?? "N/A",
                                    style: GoogleFonts.outfit(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF000000),
                                      height: 1.05,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    // "Plumbing Service Request",
                                    data.data?.ticketBanner?.subtitle ?? "N/A",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(0, 0, 0, 0.6),
                                      height: 1.1,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Container(
                          height: 1.h,
                          width: double.infinity,
                          color: Color(0xFFC6C6C6),
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Raised On",
                                    style: GoogleFonts.outfit(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(42, 41, 51, 0.6),
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    // "24 Aug 2026",
                                    data.data?.ticketBanner?.raisedDate ??
                                        "N/A",
                                    style: GoogleFonts.outfit(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Last Updated",
                                    style: GoogleFonts.outfit(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(42, 41, 51, 0.6),
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    // "05 Aug 2026",
                                    data.data?.ticketBanner?.lastUpdate ??
                                        "N/A",
                                    style: GoogleFonts.outfit(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Priority",
                                    style: GoogleFonts.outfit(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(42, 41, 51, 0.6),
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    // "High",
                                    data.data?.ticketBanner?.priority ?? "N/A",
                                    style: GoogleFonts.outfit(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Current Status",
                    style: GoogleFonts.outfit(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000),
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.black, width: 1.w),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(36, 176, 106, 0.1),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: const Color(0xFF24B06A),
                                  size: 18.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "TICKET PROGRESS",
                                    style: GoogleFonts.outfit(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      height: 1,
                                      color: Color.fromRGBO(0, 0, 0, 0.6),
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "Service Work In Progress",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      height: 1,
                                      color: Colors.black,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 68.w,
                              height: 21.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF24B06A),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Text(
                                // "ACTIVE",
                                data.data?.ticketProgress?.statusBadge ?? "N/A",
                                style: GoogleFonts.outfit(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          height: 4.h,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC6C6C6),
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor:
                                    double.parse(
                                      data
                                              .data
                                              ?.ticketProgress
                                              ?.progressPercentage
                                              .toString() ??
                                          "0",
                                    ) /
                                    100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFB8860B),
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     _statusLabel(
                        //       title: "Raised",
                        //       alignment: Alignment.centerLeft,
                        //     ),
                        //     _statusLabel(
                        //       title: "In Progress",
                        //       alignment: Alignment.center,
                        //     ),
                        //     _statusLabel(
                        //       title: "Resolved",
                        //       alignment: Alignment.centerRight,
                        //     ),
                        //   ],
                        // ),
                        Row(
                          children: List.generate(
                            data.data!.ticketProgress!.steps!.length,
                            (index) {
                              final step =
                                  data.data!.ticketProgress!.steps![index];

                              return _statusLabel(
                                title: step,
                                alignment: index == 0
                                    ? Alignment.centerLeft
                                    : index ==
                                          data
                                                  .data!
                                                  .ticketProgress!
                                                  .steps!
                                                  .length -
                                              1
                                    ? Alignment.centerRight
                                    : Alignment.center,
                                isActive:
                                    index <=
                                    data.data!.ticketProgress!.steps!.indexOf(
                                      data.data!.ticketProgress!.currentStep ??
                                          "N/A",
                                    ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Current Status",
                    style: GoogleFonts.outfit(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000),
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 19.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.black, width: 1.w),
                    ),
                    // child: Column(
                    //   children: List.generate(timeline.length, (index) {
                    //     final item = timeline[index];
                    //     return _TimelineItem(
                    //       title: item['title'],
                    //       description: item['description'],
                    //       date: item['date'],
                    //       completed: item['completed'],
                    //       isLast: index == timeline.length - 1,
                    //     );
                    //   }),
                    // ),
                    child: Column(
                      children: List.generate(
                        data.data!.lifecycleStages!.length,
                        (index) {
                          final item = data.data!.lifecycleStages![index];
                          return _TimelineItem(
                            title: item.title ?? "N/A",
                            description: item.description ?? "N/A",
                            date: item.date ?? "Pending",
                            completed: item.isCompleted ?? false,
                            isLast:
                                index == data.data!.lifecycleStages!.length - 1,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 26.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.2.w),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 242, 165, 0.3),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.push_pin,
                              color: const Color(0xFFC38A00),
                              size: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // 'ABC Plumbing Services',
                                data
                                        .data
                                        ?.assignedServiceProvider
                                        ?.providerName ??
                                    "N/A",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  height: 1,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              SizedBox(height: 4.h),

                              Text(
                                // 'Assigned for SR-1024',
                                data.data?.assignedServiceProvider?.subtitle ??
                                    "N/A",
                                style: GoogleFonts.outfit(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(0, 0, 0, 0.6),
                                  height: 1,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF1E5993),
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            // 'ACTIVE',
                            data.data?.assignedServiceProvider?.status ?? "N/A",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF1E5993),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 26.h),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text('Error loading service request details'));
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(color: AppColors.heading),
          );
        },
      ),
    );
  }

  Widget _statusLabel({
    required final String title,
    required final Alignment alignment,
    bool isActive = false,
  }) {
    return Expanded(
      child: Align(
        alignment: alignment,
        child: Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            // fontWeight: FontWeight.w500,
            // color: Colors.black,
            color: isActive ? Colors.green : Colors.grey,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            letterSpacing: -0.1,
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final bool completed;
  final bool isLast;

  const _TimelineItem({
    required this.title,
    required this.description,
    required this.date,
    required this.completed,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: completed
                      ? const Color(0xFFF1DFAC)
                      : const Color(0xFFF0E1B6),
                ),
                child: Center(
                  child: completed
                      ? Icon(
                          Icons.check,
                          size: 17.sp,
                          color: const Color(0xFF111111),
                        )
                      : Container(
                          width: 5.w,
                          height: 5.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFC38A00),
                          ),
                        ),
                ),
              ),
          
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.w,
                    color: Color.fromRGBO(16, 28, 22, 0.5),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 0.h, bottom: isLast ? 0 : 9.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.h,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                  ),
                  if (date.isNotEmpty) ...[
                    SizedBox(height: 3.h),
                    Text(
                      date,
                      style: GoogleFonts.outfit(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
