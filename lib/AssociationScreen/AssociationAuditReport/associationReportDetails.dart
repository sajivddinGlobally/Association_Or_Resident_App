import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/Core/Utils/showMessage.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/AssociationReportResModel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AssociationReportDetails extends StatefulWidget {
  final ReportsListItem? reportItem;
  final QuickReportsItem? quickReportItem;
  final String? complexName;
  final String? headerSubtitle;
  final String? footerNote;

  const AssociationReportDetails({
    super.key,
    this.reportItem,
    this.quickReportItem,
    this.complexName,
    this.headerSubtitle,
    this.footerNote,
  });

  @override
  State<AssociationReportDetails> createState() =>
      _AssociationReportDetailsState();
}

class _AssociationReportDetailsState extends State<AssociationReportDetails> {
  bool _isDownloading = false;
  bool _isViewing = false;

  String get reportTitle =>
      widget.reportItem?.title ??
      widget.quickReportItem?.title ??
      "Report Details";

  String get reportSubtitle =>
      widget.reportItem?.subtitle ??
      widget.quickReportItem?.subtitle ??
      "Association Management Report";

  String get reportCategory =>
      widget.reportItem?.category ??
      (categoryKey == "financial"
          ? "Finance"
          : categoryKey == "complaints"
          ? "Complaints"
          : categoryKey == "management"
          ? "Inspection Report"
          : "Maintenance");

  String get categoryKey =>
      widget.reportItem?.categoryKey ??
      (widget.quickReportItem?.route.contains("charges") == true
          ? "financial"
          : widget.quickReportItem?.route.contains("maintenance") == true
          ? "maintenance"
          : reportTitle.toLowerCase().contains("financ") ||
                reportTitle.toLowerCase().contains("charge")
          ? "financial"
          : reportTitle.toLowerCase().contains("complaint")
          ? "complaints"
          : reportTitle.toLowerCase().contains("inspect")
          ? "management"
          : "maintenance");

  Color get categoryColor {
    switch (categoryKey) {
      case "financial":
        return const Color(0xFFB58A16); // Gold / Amber
      case "complaints":
        return const Color(0xFFE65100); // Orange
      case "management":
        return const Color(0xFF0284C7); // Sky Blue
      case "maintenance":
      default:
        return const Color(0xFF101C16); // Primary Charcoal / Forest
    }
  }

  Color get categoryBgColor {
    switch (categoryKey) {
      case "financial":
        return const Color(0xFFFFF7DC);
      case "complaints":
        return const Color(0xFFFFF3E0);
      case "management":
        return const Color(0xFFE0F2FE);
      case "maintenance":
      default:
        return const Color(0xFFEFF3F1);
    }
  }

  IconData get categoryIcon {
    switch (categoryKey) {
      case "financial":
        return Icons.account_balance_wallet_outlined;
      case "complaints":
        return Icons.chat_bubble_outline_rounded;
      case "management":
        return Icons.fact_check_outlined;
      case "maintenance":
      default:
        return Icons.build_outlined;
    }
  }

  String get reportPeriod => widget.reportItem?.period ?? "Current";

  String get reportStatBadge =>
      widget.reportItem?.statBadge ??
      (widget.quickReportItem != null ? "Quick Summary" : "Official Report");

  String get reportStatus =>
      widget.reportItem?.statusBadge ?? widget.reportItem?.status ?? "READY";

  String get reportFormat => widget.reportItem?.format ?? "PDF";

  String? get downloadUrl =>
      widget.reportItem?.downloadUrl ?? widget.quickReportItem?.apiUrl;

  String? get viewUrl =>
      widget.reportItem?.viewUrl ??
      widget.quickReportItem?.apiUrl ??
      downloadUrl;

  String get complexName => widget.complexName ?? "Blue Sky Towers";

  String get formattedDate {
    if (widget.reportItem?.createdAt != null) {
      try {
        return DateFormat("dd MMM yyyy").format(widget.reportItem!.createdAt);
      } catch (_) {
        return widget.reportItem!.createdAt.toString();
      }
    }
    return DateFormat("dd MMM yyyy").format(DateTime.now());
  }

  Future<void> _shareReport() async {
    final url = downloadUrl ?? viewUrl;
    if (url == null || url.trim().isEmpty) {
      showErrorSnackBar("Share URL is not available");
      return;
    }

    try {
      await Share.share(
        "$reportTitle - $complexName\n\nDownload Link:\n$url",
        subject: reportTitle,
      );
    } catch (e) {
      log("Error sharing report: $e");
      showErrorSnackBar("Failed to share report");
    }
  }

  Future<void> _downloadAndOpenFile({bool openAfter = false}) async {
    final url = downloadUrl ?? viewUrl;
    if (url == null || url.trim().isEmpty) {
      showErrorSnackBar("Download URL is not available");
      return;
    }

    setState(() {
      _isDownloading = true;
    });

    try {
      showSuccessSnackBar(
        openAfter ? "Opening report..." : "Downloading report...",
      );

      String cleanTitle = reportTitle
          .replaceAll(RegExp(r'[^\w\s\-]+'), '')
          .trim()
          .replaceAll(RegExp(r'\s+'), '_');
      String periodStr = (widget.reportItem?.period ?? "")
          .replaceAll(RegExp(r'[^\w\s\-]+'), '')
          .trim()
          .replaceAll(RegExp(r'\s+'), '_');
      String fileName =
          "$cleanTitle${periodStr.isNotEmpty ? '_$periodStr' : ''}.pdf";

      Directory? targetDir;
      if (Platform.isAndroid) {
        final publicDownloads = Directory('/storage/emulated/0/Download');
        if (await publicDownloads.exists()) {
          targetDir = publicDownloads;
        } else {
          targetDir = await getExternalStorageDirectory();
        }
      }
      targetDir ??= await getApplicationDocumentsDirectory();

      final savePath = "${targetDir.path}/$fileName";

      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 60),
          headers: {"Accept": "application/pdf, application/json, */*"},
        ),
      );

      try {
        final box = Hive.isBoxOpen("associationdata")
            ? Hive.box("associationdata")
            : await Hive.openBox("associationdata");
        final token = box.get("token");
        if (token != null && token.toString().isNotEmpty) {
          dio.options.headers["Authorization"] = "Bearer $token";
        }
      } catch (e) {
        log("Hive token error: $e");
      }

      await dio.download(url, savePath);

      if (openAfter) {
        showSuccessSnackBar("Report saved to Downloads. Opening...");
        final result = await OpenFilex.open(savePath);
        if (result.type != ResultType.done) {
          log("OpenFilex message: ${result.message}");
        }
      } else {
        showSuccessSnackBar(
          "Report downloaded successfully to Downloads folder",
        );
      }
    } catch (e) {
      log("Download Error: $e");
      try {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          showSuccessSnackBar("Opening download in browser...");
          return;
        }
      } catch (_) {}
      showErrorSnackBar(
        "Failed to download report. Please check your internet connection.",
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  Future<void> _viewPdfOnlineOrOffline() async {
    final url = viewUrl ?? downloadUrl;
    if (url == null || url.trim().isEmpty) {
      showErrorSnackBar("Report URL is not available");
      return;
    }

    setState(() {
      _isViewing = true;
    });

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await _downloadAndOpenFile(openAfter: true);
      }
    } catch (e) {
      log("View PDF error: $e, falling back to download & open");
      await _downloadAndOpenFile(openAfter: true);
    } finally {
      if (mounted) {
        setState(() {
          _isViewing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Report Details",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    complexName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(42, 41, 51, 0.7),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _shareReport,
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
                  Icons.share_outlined,
                  color: const Color(0xff101C16),
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Hero Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xff101C16), width: 1.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: categoryBgColor,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: categoryColor,
                            width: 0.8.w,
                          ),
                        ),
                        child: Text(
                          reportCategory.toUpperCase(),
                          style: GoogleFonts.outfit(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: categoryColor,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: const Color(0xFF2E7D32),
                            width: 0.8.w,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6.w,
                              height: 6.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF2E7D32),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              reportStatus,
                              style: GoogleFonts.outfit(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2E7D32),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),

                  // Main Title & Icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: categoryBgColor,
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: categoryColor,
                            width: 0.8.w,
                          ),
                        ),
                        child: Icon(
                          categoryIcon,
                          size: 22.sp,
                          color: categoryColor,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reportTitle,
                              style: GoogleFonts.outfit(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.heading,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              reportSubtitle,
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(42, 41, 51, 0.75),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  const Divider(height: 1, color: Color(0x33101C16)),
                  SizedBox(height: 14.h),

                  // 3 Key Metrics Row
                  Row(
                    children: [
                      Expanded(
                        child: _heroMetric(
                          title: "Period",
                          value: reportPeriod,
                          icon: Icons.calendar_today_outlined,
                        ),
                      ),
                      Container(
                        height: 32.h,
                        width: 1.w,
                        color: const Color(0x33101C16),
                      ),
                      Expanded(
                        child: _heroMetric(
                          title: "Scope",
                          value: reportStatBadge,
                          icon: Icons.groups_outlined,
                        ),
                      ),
                      Container(
                        height: 32.h,
                        width: 1.w,
                        color: const Color(0x33101C16),
                      ),
                      Expanded(
                        child: _heroMetric(
                          title: "Format",
                          value: reportFormat,
                          icon: Icons.picture_as_pdf_outlined,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),

            // Document Preview & Direct Actions Box
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDF2),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xff101C16), width: 1.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: const Color(0xFFD32F2F),
                            width: 0.8.w,
                          ),
                        ),
                        child: Icon(
                          Icons.picture_as_pdf_rounded,
                          color: const Color(0xFFD32F2F),
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${reportTitle.replaceAll(' ', '_')}.pdf",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.heading,
                                letterSpacing: -0.2,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              "Official Certified Society Document · PDF",
                              style: GoogleFonts.outfit(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(42, 41, 51, 0.65),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isViewing
                              ? null
                              : _viewPdfOnlineOrOffline,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: const Color(0xff101C16),
                              width: 1.w,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          icon: _isViewing
                              ? SizedBox(
                                  width: 16.w,
                                  height: 16.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xff101C16),
                                  ),
                                )
                              : Icon(
                                  Icons.visibility_outlined,
                                  size: 18.sp,
                                  color: const Color(0xff101C16),
                                ),
                          label: Text(
                            _isViewing ? "Opening..." : "View PDF",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff101C16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isDownloading
                              ? null
                              : () => _downloadAndOpenFile(openAfter: false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF101C16),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          icon: _isDownloading
                              ? SizedBox(
                                  width: 16.w,
                                  height: 16.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  Icons.download_outlined,
                                  size: 18.sp,
                                  color: Colors.white,
                                ),
                          label: Text(
                            _isDownloading ? "Downloading..." : "Download",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Report Details Breakdown Table
            Text(
              "Report Information",
              style: GoogleFonts.outfit(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.heading,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: 12.h),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFF101C16), width: 1.w),
              ),
              child: Column(
                children: [
                  _infoRow(
                    label: "Category",
                    value: reportCategory,
                    isFirst: true,
                  ),
                  _infoRow(label: "Reporting Period", value: reportPeriod),
                  _infoRow(label: "Coverage / Scope", value: reportStatBadge),
                  _infoRow(
                    label: "Status",
                    value: reportStatus,
                    valueColor: const Color(0xFF2E7D32),
                  ),
                  _infoRow(label: "Generation Date", value: formattedDate),
                  _infoRow(label: "Society / Complex", value: complexName),
                  _infoRow(
                    label: "Document Format",
                    value: "$reportFormat Document",
                    isLast: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),

            // Operational Notice / Compliance Note
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEA),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFF101C16),
                  width: 0.8.w,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 20.sp,
                    color: const Color(0xFFB58A16),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Certified Society Operations Report",
                          style: GoogleFonts.outfit(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF8C6B0D),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.footerNote ??
                              "Reports are generated based on real-time society operations, vendor maintenance, complaint tickets, and financial billing logs.",
                          style: GoogleFonts.outfit(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6B530A),
                            height: 1.3,
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: const Color(0xFF101C16), width: 1.w),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 8,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 48.h,
                  child: OutlinedButton.icon(
                    onPressed: _shareReport,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xff101C16), width: 1.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    icon: Icon(
                      Icons.share_outlined,
                      size: 18.sp,
                      color: const Color(0xff101C16),
                    ),
                    label: Text(
                      "Share",
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff101C16),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 48.h,
                  child: ElevatedButton.icon(
                    onPressed: _isDownloading
                        ? null
                        : () => _downloadAndOpenFile(openAfter: false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF101C16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    icon: _isDownloading
                        ? SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            Icons.download_rounded,
                            size: 20.sp,
                            color: Colors.white,
                          ),
                    label: Text(
                      _isDownloading ? "Downloading..." : "Download Report",
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroMetric({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, size: 16.sp, color: const Color(0xFF6B7280)),
        SizedBox(height: 4.h),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(42, 41, 51, 0.6),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.heading,
          ),
        ),
      ],
    );
  }

  Widget _infoRow({
    required String label,
    required String value,
    Color? valueColor,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0x22101C16), width: 0.8),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(42, 41, 51, 0.7),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: valueColor ?? AppColors.heading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
