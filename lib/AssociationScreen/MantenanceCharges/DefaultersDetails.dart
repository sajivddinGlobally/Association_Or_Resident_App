import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/AuthService/AuthServiceProvider.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/Core/Utils/showMessage.dart';
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
                          InkWell(
                            onTap: _isTogglingStatus ? null : _toggleStatus,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xff101C16).withOpacity(0.05),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_isTogglingStatus)
                                    SizedBox(
                                      width: 12.w,
                                      height: 12.w,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 1.5,
                                        color: Colors.black,
                                      ),
                                    )
                                  else
                                    Icon(
                                      Icons.swap_horiz,
                                      size: 13.sp,
                                      color: Colors.black87,
                                    ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    data.data?.unitCard?.statusBadge ?? "N/A",
                                    style: GoogleFonts.outfit(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
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
                SizedBox(height: 24.h),
                _buildActionButtons(data.data),
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

  bool _isSendingReminder = false;
  bool _isTogglingStatus = false;

  Future<void> _sendReminder(dynamic data) async {
    setState(() => _isSendingReminder = true);
    try {
      final res = await ref.read(authServiceProvider).sendDefaulterReminder(id: widget.id);
      String msg = "Payment reminder sent successfully!";
      if (res is Map && res['message'] != null) {
        msg = res['message'].toString();
      }
      showSuccessSnackBar(msg);
    } catch (e) {
      showErrorSnackBar("Failed to send reminder: $e");
    } finally {
      if (mounted) setState(() => _isSendingReminder = false);
    }
  }

  Future<void> _toggleStatus() async {
    setState(() => _isTogglingStatus = true);
    try {
      final res = await ref.read(authServiceProvider).toggleDefaulterStatus(id: widget.id);
      String msg = "Status toggled successfully!";
      if (res is Map && res['message'] != null) {
        msg = res['message'].toString();
      }
      ref.invalidate(getDefaulterDetailsProvider(widget.id));
      showSuccessSnackBar(msg);
    } catch (e) {
      showErrorSnackBar("Failed to toggle status: $e");
    } finally {
      if (mounted) setState(() => _isTogglingStatus = false);
    }
  }

  Widget _buildActionButtons(dynamic data) {
    final statusBadge = data?.unitCard?.statusBadge ?? "Defaulter";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Management Actions",
          style: GoogleFonts.outfit(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _isSendingReminder ? null : () => _sendReminder(data),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  side: BorderSide(color: const Color(0xFF101C16), width: 1.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  backgroundColor: Colors.white,
                ),
                child: _isSendingReminder
                    ? SizedBox(
                        width: 18.w,
                        height: 18.w,
                        child: const CircularProgressIndicator(color: Color(0xFF101C16), strokeWidth: 2),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications_active_outlined, size: 18.sp, color: const Color(0xFF101C16)),
                          SizedBox(width: 8.w),
                          Text(
                            "Send Reminder",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF101C16),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showRecordPaymentModal(context, data),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  backgroundColor: const Color(0xFF101C16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.payment_outlined, size: 18.sp, color: Colors.white),
                    SizedBox(width: 8.w),
                    Text(
                      "Receive Pay",
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _isTogglingStatus ? null : _toggleStatus,
            icon: _isTogglingStatus
                ? SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF101C16)),
                  )
                : Icon(Icons.swap_horiz, size: 18.sp, color: const Color(0xFF101C16)),
            label: Text(
              "Toggle Defaulter Status ($statusBadge)",
              style: GoogleFonts.outfit(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF101C16),
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              side: BorderSide(color: Colors.black26, width: 1.w),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _showRecordPaymentModal(BuildContext context, dynamic data) {
    String paidVia = 'UPI (Google Pay)';
    final methods = [
      'UPI (Google Pay)',
      'Cash',
      'Cheque',
      'Bank Transfer',
      'UPI (PhonePe)',
      'UPI (Paytm)',
    ];

    final now = DateTime.now();
    String paymentDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    String rawAmount = '';
    final formatted = data?.outstandingAmount?.formattedTotalOutstanding?.toString() ?? '';
    rawAmount = formatted.replaceAll(RegExp(r'[^0-9.]'), '');

    final amountController = TextEditingController(text: rawAmount);
    final notesController =
        TextEditingController(text: "Received payment via online transfer");
    final dateController = TextEditingController(text: paymentDate);
    bool isSubmitting = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.scaffoldBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 20.h,
                bottom: MediaQuery.of(context).viewInsets.bottom + 25.h,
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
                          "Receive Maintenance Pay",
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
                    SizedBox(height: 6.h),
                    Text(
                      "Unit: ${data?.unitCard?.unitNumber ?? ''} · Due: ${data?.outstandingAmount?.formattedTotalOutstanding ?? ''}",
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        color: const Color(0xFF666666),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Paid Via (Payment Method)",
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 6.h,
                      children: methods.map((m) {
                        final isSel = paidVia == m;
                        return ChoiceChip(
                          label: Text(
                            m,
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: isSel ? FontWeight.w600 : FontWeight.w400,
                              color: isSel ? Colors.white : Colors.black87,
                            ),
                          ),
                          selected: isSel,
                          selectedColor: const Color(0xFF101C16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            side: BorderSide(
                              color: isSel ? const Color(0xFF101C16) : Colors.black26,
                            ),
                          ),
                          onSelected: (val) {
                            if (val) setModalState(() => paidVia = m);
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      "Amount Received",
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: GoogleFonts.outfit(fontSize: 14.sp),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.currency_rupee, size: 16),
                        hintText: "e.g. 4250",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.black26),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Payment Date (yyyy-MM-dd)",
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      style: GoogleFonts.outfit(fontSize: 14.sp),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2035),
                        );
                        if (picked != null) {
                          final formattedDate =
                              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                          setModalState(() {
                            paymentDate = formattedDate;
                            dateController.text = formattedDate;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.calendar_today, size: 18),
                        hintText: "Select payment date",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.black26),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Payment Notes",
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: notesController,
                      maxLines: 2,
                      style: GoogleFonts.outfit(fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: "e.g. Received payment via online transfer",
                        hintStyle: GoogleFonts.outfit(fontSize: 13.sp, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.black26),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: isSubmitting
                            ? null
                            : () async {
                                final amt = amountController.text.trim();
                                if (amt.isEmpty) {
                                  showErrorSnackBar("Please enter received amount");
                                  return;
                                }
                                setModalState(() => isSubmitting = true);
                                try {
                                  final res = await ref.read(authServiceProvider).receiveDefaulterPay(
                                        id: widget.id,
                                        amount: amt,
                                        paidVia: paidVia,
                                        paymentDate: dateController.text.trim(),
                                        notes: notesController.text.trim(),
                                      );
                                  ref.invalidate(getDefaulterDetailsProvider(widget.id));
                                  String msg = "Payment received and recorded successfully";
                                  if (res is Map && res['message'] != null) {
                                    msg = res['message'].toString();
                                  }
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    showSuccessSnackBar(msg);
                                  }
                                } catch (e) {
                                  setModalState(() => isSubmitting = false);
                                  showErrorSnackBar("Failed to record payment: $e");
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF101C16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: isSubmitting
                            ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : Text(
                                "Submit Payment Record",
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
      },
    );
  }
}

