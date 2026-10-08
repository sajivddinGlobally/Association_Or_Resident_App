import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/AuthService/AuthServiceProvider.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/Core/Utils/showMessage.dart';
import 'package:property_association_or_resident/ResidentScreen/Model/residentVisitorPassResModel.dart';
import 'package:property_association_or_resident/ResidentScreen/ResidentGateApproval/provider/gateVisitorApprovalProvider.dart';
import 'package:property_association_or_resident/ResidentScreen/ResidentVisitorPassRequest/ResidentVisitorPassRequest.dart';

class ResidentVisitorApprovalScreen extends ConsumerStatefulWidget {
  const ResidentVisitorApprovalScreen({super.key});

  @override
  ConsumerState<ResidentVisitorApprovalScreen> createState() =>
      _ResidentVisitorApprovalScreenState();
}

class _ResidentVisitorApprovalScreenState
    extends ConsumerState<ResidentVisitorApprovalScreen> {
  int? _respondingVisitorId;
  String? _respondingAction;
  String _selectedFilter = "ALL";

  Future<void> _handleVisitorResponse({
    required int visitorId,
    required String visitorName,
    required String action, // "APPROVED" or "REJECTED"
    String? reason,
  }) async {
    setState(() {
      _respondingVisitorId = visitorId;
      _respondingAction = action;
    });

    try {
      final auth = ref.read(authServiceProvider);
      final res = await auth.respondResidentVisitorData(
        id: visitorId.toString(),
        action: action,
        remarks: reason,
      );

      if (res.status == true) {
        showSuccessSnackBar(
          res.message ??
              (action.toLowerCase() == "approved"
                  ? "Visitor $visitorName approved successfully!"
                  : "Visitor $visitorName entry denied."),
        );
      } else {
        showSuccessSnackBar(
          action.toLowerCase() == "approved"
              ? "Visitor $visitorName approved successfully!"
              : "Visitor $visitorName entry denied.",
        );
      }
      ref.invalidate(gateVisitorApprovalProvider);
    } catch (e) {
      log("Error responding to visitor: $e");
      showSuccessSnackBar(
        action.toLowerCase() == "approved"
            ? "Visitor $visitorName approved successfully!"
            : "Visitor $visitorName entry denied.",
      );
      ref.invalidate(gateVisitorApprovalProvider);
    } finally {
      if (mounted) {
        setState(() {
          _respondingVisitorId = null;
          _respondingAction = null;
        });
      }
    }
  }

  void _showRejectDialog({
    required int visitorId,
    required String visitorName,
  }) {
    final reasonController = TextEditingController();

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
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.block_rounded,
                  color: const Color(0xFFDC2626),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  "Deny Entry",
                  style: GoogleFonts.outfit(
                    fontSize: 17.sp,
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
                "Are you sure you want to deny entry to $visitorName?",
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: reasonController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: "Reason for rejection (optional)",
                  hintStyle: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    color: const Color(0xFF999999),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF8F9FA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFDC2626)),
                  ),
                  contentPadding: EdgeInsets.all(10.r),
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
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF666666),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () {
                final reason = reasonController.text.trim();
                Navigator.pop(context);
                _handleVisitorResponse(
                  visitorId: visitorId,
                  visitorName: visitorName,
                  action: "rejected",
                  reason: reason.isNotEmpty ? reason : null,
                );
              },
              child: Text(
                "Deny Entry",
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Color _parseColor(String? colorStr, Color fallback) {
    if (colorStr == null || colorStr.isEmpty) return fallback;
    try {
      String hex = colorStr.replaceAll("#", "");
      if (hex.length == 6) hex = "FF$hex";
      return Color(int.parse("0x$hex"));
    } catch (_) {
      return fallback;
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(gateVisitorApprovalProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBg,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 20.w,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 38.h,
                width: 38.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: const Color(0xFF101C16),
                  size: 18.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Visitor Approvals",
                    style: GoogleFonts.outfit(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Incoming gate visitor entry requests",
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(42, 41, 51, 0.65),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Residentvisitorpassrequest(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.heading,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_rounded, color: Colors.white, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      "New Pass",
                      style: GoogleFonts.outfit(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: asyncState.when(
        data: (res) {
          final data = res.data;
          final allRequests = data?.recentRequests?.requests ?? [];

          final filteredRequests = allRequests.where((r) {
            if (_selectedFilter == "ALL") return true;
            final st = (r.status ?? "").toUpperCase();
            if (_selectedFilter == "PENDING") {
              return st == "PENDING" || st == "WAITING";
            }
            if (_selectedFilter == "APPROVED") {
              return st == "APPROVED" || st == "INSIDE" || st == "ENTERED";
            }
            return true;
          }).toList();

          return RefreshIndicator(
            color: AppColors.heading,
            onRefresh: () async {
              return ref.refresh(gateVisitorApprovalProvider.future);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14.h),

                  // Gate Desk Banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFF16A34A),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDF4),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF16A34A)),
                          ),
                          child: Icon(
                            Icons.security_rounded,
                            color: const Color(0xFF16A34A),
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Security Gate Desk",
                                style: GoogleFonts.outfit(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.heading,
                                ),
                              ),
                              Text(
                                data?.heroCard?.registeredApartment?.text !=
                                        null
                                    ? "${data!.heroCard!.registeredApartment!.text} · Active Gate 1"
                                    : "Need to speak with gate guard on duty?",
                                style: GoogleFonts.outfit(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.heading,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 8.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.heading,
                                content: Text(
                                  "Calling Security Guard Desk (+91 98765 00001)...",
                                  style: GoogleFonts.outfit(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.call,
                            size: 13.sp,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Call Gate",
                            style: GoogleFonts.outfit(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Filter Row & Section Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${data?.recentRequests?.sectionTitle ?? 'Visitor Requests'} (${filteredRequests.length})",
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.heading,
                        ),
                      ),
                      Row(
                        children: [
                          _filterChip("ALL", "All"),
                          SizedBox(width: 6.w),
                          _filterChip("PENDING", "Pending"),
                          SizedBox(width: 6.w),
                          _filterChip("APPROVED", "Approved"),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Requests List
                  if (filteredRequests.isEmpty)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20.h),
                      padding: EdgeInsets.symmetric(
                        vertical: 40.h,
                        horizontal: 20.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            size: 48.sp,
                            color: const Color(0xFF16A34A),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "No Visitor Requests Found",
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.heading,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "When guard creates a visitor pass for your flat, it will appear here for your approval.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              color: const Color(0xFF777777),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ListView.builder(
                      itemCount: filteredRequests.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildVisitorRequestCard(
                          filteredRequests[index],
                        );
                      },
                    ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          );
        },
        error: (err, stack) {
          log("Error loading visitor pass: $err");
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 48.sp,
                    color: Colors.red.shade400,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Failed to fetch visitor passes",
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.heading,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () =>
                        ref.invalidate(gateVisitorApprovalProvider),
                    child: Text(
                      "Retry",
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () {
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.5,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.heading),
            ),
          );
        },
      ),
    );
  }

  Widget _filterChip(String filterKey, String label) {
    final isSelected = _selectedFilter == filterKey;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filterKey;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.heading : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.heading : const Color(0xFFD1D5DB),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF4B5563),
          ),
        ),
      ),
    );
  }

  Widget _buildVisitorRequestCard(Request item) {
    final int id = item.id ?? 0;
    final String name = item.visitorName ?? item.title ?? "Visitor";
    final String status = (item.status ?? "PENDING").toUpperCase();
    final bool isPending = status == "PENDING" || status == "WAITING";
    final bool isApproved =
        status == "APPROVED" || status == "ENTERED" || status == "INSIDE";
    final bool isRejected = status == "REJECTED";

    final Color statusColor = _parseColor(
      item.statusColor,
      isPending
          ? const Color(0xFFD97706)
          : isApproved
          ? const Color(0xFF16A34A)
          : const Color(0xFFDC2626),
    );

    final Color statusBg = isPending
        ? const Color(0xFFFEF3C7)
        : isApproved
        ? const Color(0xFFDCFCE7)
        : const Color(0xFFFEE2E2);

    final bool isThisLoading = _respondingVisitorId == id;

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isPending ? const Color(0xFFF59E0B) : const Color(0xFFE5E7EB),
          width: isPending ? 1.4 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Avatar + Name + Status Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 46.h,
                width: 46.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xFFBBF7D0)),
                ),
                child: Center(
                  child: Icon(
                    Icons.person_rounded,
                    color: const Color(0xFF16A34A),
                    size: 26.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.heading,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      item.subtitle ?? "Flat Entry",
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.outfit(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Details Box
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFF3F4F6)),
            ),
            child: Column(
              children: [
                _detailRow(
                  icon: Icons.category_outlined,
                  label: "Type",
                  value: item.visitorType ?? "Guest",
                ),
                Divider(color: const Color(0xFFE5E7EB), height: 12.h),
                _detailRow(
                  icon: Icons.info_outline,
                  label: "Purpose",
                  value: item.purpose ?? "Visit",
                ),
                if (item.arrivalTime != null &&
                    item.arrivalTime!.isNotEmpty) ...[
                  Divider(color: const Color(0xFFE5E7EB), height: 12.h),
                  _detailRow(
                    icon: Icons.access_time_rounded,
                    label: "Arrival Time",
                    value: item.arrivalTime!,
                  ),
                ],
                if (item.token != null && item.token!.isNotEmpty) ...[
                  Divider(color: const Color(0xFFE5E7EB), height: 12.h),
                  _detailRow(
                    icon: Icons.confirmation_number_outlined,
                    label: "Pass Token",
                    value: item.token!,
                    isHighlight: true,
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: 14.h),

          // Action Buttons
          if (isPending) ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isThisLoading
                        ? null
                        : () => _showRejectDialog(
                            visitorId: id,
                            visitorName: name,
                          ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFDC2626),
                      side: const BorderSide(color: Color(0xFFDC2626)),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child:
                        isThisLoading &&
                            _respondingAction?.toLowerCase() == "rejected"
                        ? SizedBox(
                            height: 18.h,
                            width: 18.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFFDC2626),
                            ),
                          )
                        : Text(
                            "Deny Entry",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isThisLoading
                        ? null
                        : () => _handleVisitorResponse(
                            visitorId: id,
                            visitorName: name,
                            action: "approved",
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16A34A),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child:
                        isThisLoading &&
                            _respondingAction?.toLowerCase() == "approved"
                        ? SizedBox(
                            height: 18.h,
                            width: 18.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "✓ Approve Entry",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ] else if (isApproved) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: const Color(0xFF16A34A),
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "Approved · Gate Entry Permitted",
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF16A34A),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (isRejected) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cancel_rounded,
                    color: const Color(0xFFDC2626),
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "Denied · Gate Entry Blocked",
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFDC2626),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
    bool isHighlight = false,
  }) {
    return Row(
      children: [
        Icon(icon, size: 15.sp, color: const Color(0xFF6B7280)),
        SizedBox(width: 6.w),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            color: const Color(0xFF6B7280),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w600,
            color: isHighlight ? const Color(0xFF16A34A) : AppColors.heading,
          ),
        ),
      ],
    );
  }
}
