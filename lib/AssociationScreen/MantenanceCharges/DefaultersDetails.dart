import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'provider/getDefaulterDetailsProvider.dart';

class DefaultersDetails extends ConsumerStatefulWidget {
  final String id;
  const DefaultersDetails({super.key, required this.id});

  @override
  ConsumerState<DefaultersDetails> createState() => _DefaultersDetailsState();
}

class _DefaultersDetailsState extends ConsumerState<DefaultersDetails> {
  @override
  Widget build(BuildContext context) {
    final defaulterDetails = ref.watch(getDefaulterDetailsProvider(widget.id));
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.scaffoldBg,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DEFAULTER DETAILS",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Maintenance Charges / Defaulters",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2A2933),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: defaulterDetails.when(
        data: (data) {
          final timeline = data.data?.maintenanceHistory?.timeline ?? [];
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 11.h,
                    horizontal: 12.w,
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
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: Image.asset(
                                "assets/unit.png",
                                width: 34.w,
                                height: 34.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 34.w,
                                    height: 34.w,
                                    color: Colors.grey[200],
                                    child: Icon(
                                      Icons.home_work_outlined,
                                      size: 20.sp,
                                      color: Colors.black54,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // "Flat B-302",
                                  data.data?.unitCard?.unitNumber ?? "N/A",
                                  style: GoogleFonts.outfit(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  data.data?.unitCard?.propertyType ?? "N/A",
                                  style: GoogleFonts.outfit(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF666666),
                                    letterSpacing: -0.2,
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
                              border: Border.all(
                                color: Colors.black,
                                width: 1.w,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              data.data?.unitCard?.statusBadge ?? "N/A",
                              style: GoogleFonts.outfit(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      _divider(),
                      SizedBox(height: 14.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Owner",
                                  style: GoogleFonts.outfit(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF999999),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  data.data?.unitCard?.propertyOwner ?? "N/A",
                                  style: GoogleFonts.outfit(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
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
                                  "Due Date",
                                  style: GoogleFonts.outfit(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF999999),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  data.data?.unitCard?.dueDate ?? "N/A",
                                  style: GoogleFonts.outfit(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
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

                SizedBox(height: 20.h),
                Text(
                  "Outstanding Amount",
                  style: GoogleFonts.outfit(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.black, width: 1.w),
                  ),
                  child: Column(
                    children: [
                      _buildOutstandingRow(
                        "Total Outstanding",
                        data
                                .data
                                ?.outstandingAmount
                                ?.formattedTotalOutstanding ??
                            "0",
                        isBold: true,
                      ),
                      Divider(color: Color(0xFF7B7B7B)),
                      SizedBox(height: 10.h),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            data
                                .data
                                ?.outstandingAmount
                                ?.breakdownItems
                                ?.length ??
                            0,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return _buildOutstandingRow(
                            data
                                    .data
                                    ?.outstandingAmount
                                    ?.breakdownItems?[index]
                                    .title ??
                                "N/A",
                            data
                                    .data
                                    ?.outstandingAmount
                                    ?.breakdownItems?[index]
                                    .formattedAmount ??
                                "0",
                          );
                        },
                      ),
                      // SizedBox(height: 16.h),
                      // _buildOutstandingRow("Total Outstanding", "₹7,500"),
                      // SizedBox(height: 16.h),
                      // _buildOutstandingRow("Total Outstanding", "₹0"),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
                Text(
                  "Payment Information",
                  style: GoogleFonts.outfit(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.black, width: 1.w),
                  ),
                  child: Column(
                    children: [
                      _buildPaymentInfoItem(
                        icon: Icons.calendar_today_outlined,
                        label:
                            data
                                .data
                                ?.paymentInformation
                                ?.currentBillingMonth
                                ?.label ??
                            "Current Billing Month",
                        value:
                            data
                                .data
                                ?.paymentInformation
                                ?.currentBillingMonth
                                ?.monthYear ??
                            "N/A",
                        trailingText:
                            data
                                .data
                                ?.paymentInformation
                                ?.currentBillingMonth
                                ?.status ??
                            "Pending",
                      ),
                      _divider(),
                      _buildPaymentInfoItem(
                        icon: Icons.info_outline_rounded,
                        label:
                            data
                                .data
                                ?.paymentInformation
                                ?.overdueSince
                                ?.label ??
                            "Overdue Since",
                        value:
                            data.data?.paymentInformation?.overdueSince?.date ??
                            "N/A",
                        trailingText:
                            data
                                .data
                                ?.paymentInformation
                                ?.overdueSince
                                ?.daysText ??
                            "N/A",
                      ),
                      _divider(),
                      _buildPaymentInfoItem(
                        icon: Icons.warning_amber_rounded,
                        label:
                            data
                                .data
                                ?.paymentInformation
                                ?.lastRecordedPayment
                                ?.label ??
                            "Last Recorded Payment",
                        value:
                            data
                                .data
                                ?.paymentInformation
                                ?.lastRecordedPayment
                                ?.monthYear ??
                            "July 2026",
                        trailingText:
                            data
                                .data
                                ?.paymentInformation
                                ?.lastRecordedPayment
                                ?.formattedAmount ??
                            "0",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Maintenance History",
                      style: GoogleFonts.outfit(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(
                      "ACTIVITY",
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 19.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.black, width: 1.w),
                  ),
                  child: Column(
                    children: [
                      if (timeline.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Text(
                            "No timeline available",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      else
                        ...List.generate(timeline.length, (index) {
                          final item = timeline[index];

                          return _buildTimelineItem(
                            title: item.monthYear ?? "",
                            subtitle: item.description ?? "",
                            amount: item.formattedAmount ?? "",
                            status: item.status ?? "",
                            isFirst: index == 0,
                            isLast: index == timeline.length - 1,
                          );
                        }),
                      // _buildTimelineItem(
                      //   title: "June 2026",
                      //   subtitle: "Maintenance charge recorded as paid",
                      //   isFirst: false,
                      //   isLast: false,
                      // ),
                      // _buildTimelineItem(
                      //   title: "May 2026",
                      //   subtitle: "Maintenance charge recorded as paid",
                      //   isFirst: false,
                      //   isLast: true,
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text("something went wrong"));
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(color: AppColors.heading),
          );
        },
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1.h,
      thickness: 0.8.w,
      color: const Color.fromRGBO(42, 41, 51, 0.4),
    );
  }

  Widget _buildOutstandingRow(
    String label,
    String amount, {
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.w500 : FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.outfit(
              fontSize: isBold ? 16.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w500 : FontWeight.w400,
              color: const Color(0xFFC18A00),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required String trailingText,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.w),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Center(
              child: Icon(icon, size: 15.sp, color: Colors.black),
            ),
          ),
          SizedBox(width: 7.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF666666),
                    letterSpacing: -0.2,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
          Text(
            trailingText,
            style: GoogleFonts.outfit(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required String amount,
    required String status,
    required bool isFirst,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 242, 165, 0.8),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC18A00),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.w,
                    color: const Color(0xFFC18A00).withOpacity(0.5),
                  ),
                ),
            ],
          ),

          SizedBox(width: 14.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: -0.2,
                    ),
                  ),

                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF666666),
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: status.toLowerCase() == "paid"
                              ? Colors.green.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          status.toUpperCase(),
                          style: GoogleFonts.outfit(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: status.toLowerCase() == "paid"
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
