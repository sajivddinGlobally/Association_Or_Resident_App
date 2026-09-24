import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/Core/Utils/showMessage.dart';

import 'Provider/ResidentMmcStatusProvider.dart';

class MmcStatusscreen extends ConsumerStatefulWidget {
  const MmcStatusscreen({super.key});

  @override
  ConsumerState<MmcStatusscreen> createState() => _MmcStatusscreenState();
}

class _MmcStatusscreenState extends ConsumerState<MmcStatusscreen> {
  @override
  Widget build(BuildContext context) {
    final mmcState = ref.watch(residentMmcStatusProvider);
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
                    "MMC Status",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Monthly Maintenance Charge",
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(42, 41, 51, 0.6),
                      letterSpacing: -0.24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: mmcState.when(
        data: (data) {
          final isPaid = data.data.currentMonth.currentStatus.value
                  .toLowerCase()
                  .contains("paid") &&
              !data.data.currentMonth.currentStatus.value
                  .toLowerCase()
                  .contains("unpaid");

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

                // Status Banner (Paid or Due Notice)
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isPaid
                        ? const Color(0xFF24B06A).withOpacity(0.08)
                        : const Color(0xFFB8860B).withOpacity(0.10),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isPaid
                          ? const Color(0xFF24B06A).withOpacity(0.3)
                          : const Color(0xFFB8860B).withOpacity(0.3),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPaid
                            ? Icons.check_circle_outline
                            : Icons.warning_amber_rounded,
                        color: isPaid
                            ? const Color(0xFF24B06A)
                            : const Color(0xFFB8860B),
                        size: 20.sp,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          isPaid
                              ? "Your maintenance charge for ${data.data.currentMonth.month.value} is fully paid."
                              : "Maintenance charge for ${data.data.currentMonth.month.value} is due. Please pay to avoid late charges.",
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 22.h),
                Text(
                  data.data.currentMonth.sectionTitle,
                  style: GoogleFonts.outfit(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.heading,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 14.h),
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.heading),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32.w,
                            height: 32.w,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(184, 134, 11, 0.2),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Icon(
                              Icons.currency_rupee,
                              size: 18.sp,
                              color: const Color(0xffB8860B),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              data.data.currentMonth.cardTitle,
                              style: GoogleFonts.outfit(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.heading,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        decoration: BoxDecoration(
                          color: const Color(0xffF7F7F7),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data.data.currentMonth.charge.label,
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff2A2933),
                                letterSpacing: -0.2,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: data
                                        .data.currentMonth.charge.currency,
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffB8860B),
                                      fontSize: 16.sp,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " ${data.data.currentMonth.charge.amount}",
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xffB8860B),
                                      fontSize: 24.sp,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.data.currentMonth.currentStatus.label,
                            style: GoogleFonts.outfit(
                              fontSize: 15.sp,
                              color: const Color.fromRGBO(16, 28, 22, 0.6),
                              letterSpacing: -0.2,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: isPaid
                                  ? const Color(0xFF24B06A).withOpacity(0.15)
                                  : const Color.fromRGBO(184, 134, 11, 0.25),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Text(
                              data.data.currentMonth.currentStatus.value,
                              style: GoogleFonts.outfit(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: isPaid
                                    ? const Color(0xFF24B06A)
                                    : const Color(0xffB8860B),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Divider(
                        thickness: 0.8.w,
                        color: const Color.fromRGBO(16, 28, 22, 0.2),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.data.currentMonth.month.label,
                            style: GoogleFonts.outfit(
                              fontSize: 15.sp,
                              color: const Color.fromRGBO(16, 28, 22, 0.6),
                              letterSpacing: -0.2,
                            ),
                          ),
                          Text(
                            data.data.currentMonth.month.value,
                            style: GoogleFonts.outfit(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.heading,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Divider(
                        thickness: 0.8.w,
                        color: const Color.fromRGBO(16, 28, 22, 0.2),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.data.currentMonth.paidOn.label,
                            style: GoogleFonts.outfit(
                              fontSize: 15.sp,
                              color: const Color.fromRGBO(16, 28, 22, 0.6),
                              letterSpacing: -0.2,
                            ),
                          ),
                          Text(
                            data.data.currentMonth.paidOn.value.isNotEmpty
                                ? data.data.currentMonth.paidOn.value
                                : (isPaid ? "Recorded" : "Pending Payment"),
                            style: GoogleFonts.outfit(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: isPaid
                                  ? AppColors.heading
                                  : Colors.orange.shade800,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Action Buttons
                if (isPaid) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showReceiptModal(context, data);
                      },
                      icon: Icon(Icons.receipt_long,
                          size: 18.sp, color: const Color(0xFF101C16)),
                      label: Text(
                        "View Payment Receipt",
                        style: GoogleFonts.outfit(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF101C16),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: const Color(0xFF101C16), width: 1.2.w),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ] else ...[
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showPaymentInfoModal(context, data);
                      },
                      icon: Icon(Icons.payment,
                          size: 18.sp, color: Colors.white),
                      label: Text(
                        "Pay Maintenance Charge",
                        style: GoogleFonts.outfit(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF101C16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],

                SizedBox(height: 35.h),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return const Center(child: Text("Something went wrong"));
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.heading),
          );
        },
      ),
    );
  }

  void _showPaymentInfoModal(BuildContext context, dynamic data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.scaffoldBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: MediaQuery.of(context).padding.bottom + 20.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Society Payment Details",
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.heading,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB8860B).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          size: 18.sp, color: const Color(0xFFB8860B)),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "Total Payable: ${data.data.currentMonth.charge.currency} ${data.data.currentMonth.charge.amount} for ${data.data.currentMonth.month.value}",
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                Text(
                  "Bank Transfer (NEFT / IMPS / RTGS)",
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.heading,
                  ),
                ),
                SizedBox(height: 10.h),
                _bankDetailRow("Account Name", "Green Valley Society Maintenance"),
                _bankDetailRow("Account Number", "918237465012", canCopy: true),
                _bankDetailRow("IFSC Code", "HDFC0001824", canCopy: true),
                _bankDetailRow("Bank & Branch", "HDFC Bank, Main Branch"),
                SizedBox(height: 16.h),
                Divider(thickness: 1, color: Colors.black12),
                SizedBox(height: 12.h),
                Text(
                  "Instant UPI Transfer",
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.heading,
                  ),
                ),
                SizedBox(height: 10.h),
                _bankDetailRow("UPI ID / VPA", "greenvalleysociety@hdfcbank",
                    canCopy: true),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    "Note: Once transfer is completed, please notify the Association Committee or submit the transaction reference to receive an updated receipt.",
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      color: const Color(0xFF555555),
                      height: 1.3,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF101C16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text(
                      "Done",
                      style: GoogleFonts.outfit(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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

  void _showReceiptModal(BuildContext context, dynamic data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.scaffoldBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: MediaQuery.of(context).padding.bottom + 20.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Receipt",
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.heading,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "STATUS",
                            style: GoogleFonts.outfit(
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF24B06A).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              "PAID & VERIFIED",
                              style: GoogleFonts.outfit(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF24B06A),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Divider(thickness: 0.8, color: Colors.black12),
                      SizedBox(height: 12.h),
                      _receiptRow("Billing Month",
                          data.data.currentMonth.month.value),
                      _receiptRow(
                          "Amount",
                          "${data.data.currentMonth.charge.currency} ${data.data.currentMonth.charge.amount}"),
                      _receiptRow("Paid On",
                          data.data.currentMonth.paidOn.value.isNotEmpty
                              ? data.data.currentMonth.paidOn.value
                              : "Verified"),
                      _receiptRow("Payment Method", "Online / Bank Recorded"),
                      _receiptRow("Receipt Reference",
                          "REC-${DateTime.now().year}-${data.data.currentMonth.month.value.replaceAll(' ', '')}"),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF101C16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text(
                      "Close Receipt",
                      style: GoogleFonts.outfit(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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

  Widget _bankDetailRow(String label, String value, {bool canCopy = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            if (canCopy)
              IconButton(
                icon: Icon(Icons.copy, size: 16.sp, color: const Color(0xFFB8860B)),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: value));
                  showSuccessSnackBar("$label copied to clipboard");
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _receiptRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 13.sp,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}