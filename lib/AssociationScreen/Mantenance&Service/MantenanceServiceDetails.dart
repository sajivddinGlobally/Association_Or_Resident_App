import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/AssociationScreen/Mantenance&Service/Provider/maintananceDetailsProvider.dart';
import 'package:property_association_or_resident/Core/AuthService/AuthServiceProvider.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/Core/Utils/showMessage.dart';

class MantenanceServiceDetails extends ConsumerStatefulWidget {
  final String id;
  const MantenanceServiceDetails({super.key, required this.id});

  @override
  ConsumerState<MantenanceServiceDetails> createState() =>
      _MantenanceServiceDetailsState();
}

class _MantenanceServiceDetailsState
    extends ConsumerState<MantenanceServiceDetails> {
  @override
  Widget build(BuildContext context) {
    final maintananceState = ref.watch(maintananceDetailsProvider(widget.id));
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MAINTENANCE DETAILS",
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff292832),
                          letterSpacing: -0.64,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Maintenance Management",
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
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: maintananceState.whenOrNull(
              data: (data) => InkWell(
                onTap: () {
                  _showUpdateStatusModal(
                    context,
                    data.data?.header?.statusBadge ??
                        data.data?.maintenanceDetails?.status ??
                        "Pending",
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff101C16),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit_note, color: Colors.white, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        "Status",
                        style: GoogleFonts.outfit(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: maintananceState.when(
        data: (data) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: 11.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.black, width: 1.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // "MAINTENANCE REQUEST · MR-2048",
                            data.data?.header?.badgeRequest ?? "N/A",
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              letterSpacing: -0.2,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 13.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
                              border: Border.all(
                                color: const Color(0xFFB8860B),
                                width: 1.w,
                              ),
                            ),
                            child: Text(
                              // "In Progress",
                              data.data?.header?.statusBadge ?? "N/A",
                              style: GoogleFonts.outfit(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFC18A00),
                                height: 1,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        // "Water Leakage Repair",
                        data.data?.header?.title ?? "N/A",
                        style: GoogleFonts.outfit(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.05,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        // "Plumbing maintenance request",
                        data.data?.header?.screenTitle ?? "N/A",
                        style: GoogleFonts.outfit(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF4A4A4A),
                          height: 1.05,
                          letterSpacing: -0.15,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      _divider(),
                      SizedBox(height: 20.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _InfoItem(
                              label: 'Priority',
                              value: data.data?.header?.priority ?? "N/A",
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: _InfoItem(
                              label: 'Raised On',
                              value: data.data?.header?.raisedOn ?? "N/A",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _InfoItem(
                              label: 'Expected Completion',
                              value:
                                  data.data?.header?.expectedCompletion ??
                                  "N/A",
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: _InfoItem(
                              label: 'Actual Completion',
                              value:
                                  data.data?.header?.actualCompletion ?? "N/A",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                _buildProgressStepper(
                  data.data?.header?.statusBadge ??
                      data.data?.maintenanceDetails?.status ??
                      "Pending",
                ),
                SizedBox(height: 24.h),
                _sectionHeader("Request Information", "DETAILS"),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(21.w, 20.h, 21.w, 18.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.black, width: 1.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 35.w,
                            height: 35.w,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 242, 165, 0.55),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Icon(
                              Icons.edit_outlined,
                              size: 19.sp,
                              color: const Color(0xFF9D8422),
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // "Maintenance Request",
                                  data.data?.requestInformation?.title ?? "N/A",
                                  style: GoogleFonts.outfit(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    height: 1.05,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  // "Repair required in apartment plumbing area",
                                  data.data?.requestInformation?.subtitle ??
                                      "N/A",
                                  style: GoogleFonts.outfit(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF4A4A4A),
                                    height: 1.05,
                                    letterSpacing: -0.15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      _divider(),
                      SizedBox(height: 14.h),
                      Text(
                        "Description",
                        style: GoogleFonts.outfit(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(42, 41, 51, 0.60),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        // "Water leakage reported from the bathroom plumbing connection. Maintenance team has been assigned to inspect and complete the required repair.",
                        data.data?.requestInformation?.description ?? "N/A",
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                // Property / Unit Section
                SizedBox(height: 19.h),
                _sectionHeader("Property / Unit", "LOCATION"),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 9.h,
                    horizontal: 14.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.black, width: 1.w),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.w),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.home_outlined,
                          size: 20.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Property / Unit",
                              style: GoogleFonts.outfit(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(42, 41, 51, 0.60),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              // "Apartment A-204",
                              data.data?.propertyUnit?.unitName ?? "N/A",
                              style: GoogleFonts.outfit(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                height: 1.05,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              // "Green Valley Residency · Jaipur",
                              data.data?.propertyUnit?.fullLocation ?? "N/A",
                              style: GoogleFonts.outfit(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF4A4A4A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Icon(
                      //   Icons.chevron_right,
                      //   color: Colors.black,
                      //   size: 20.sp,
                      // ),
                    ],
                  ),
                ),

                // Maintenance Details Section
                SizedBox(height: 20.h),
                _sectionHeader("Maintenance Details", "ACTIVE"),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 17.h,
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.black, width: 1.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _InfoItem(
                              label: 'Category',
                              value:
                                  data.data?.maintenanceDetails?.category ??
                                  "N/A",
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: _InfoItem(
                              label: 'Priority',
                              value:
                                  data.data?.maintenanceDetails?.priority ??
                                  "N/A",
                              valueColor: const Color(0xFFB8860B),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _InfoItem(
                              label: 'Status',
                              value:
                                  data.data?.maintenanceDetails?.status ??
                                  "N/A",
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: _InfoItem(
                              label: 'Raised Date',
                              value:
                                  data.data?.maintenanceDetails?.raisedDate ??
                                  "N/A",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _InfoItem(
                              label: 'Expected Completion',
                              value:
                                  data
                                      .data
                                      ?.maintenanceDetails
                                      ?.expectedCompletion ??
                                  "N/A",
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: _InfoItem(
                              label: 'Actual Completion',
                              value:
                                  data
                                      .data
                                      ?.maintenanceDetails
                                      ?.actualCompletion ??
                                  "-",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _InfoItem(
                              label: 'Cost / Reference',
                              value:
                                  data
                                      .data
                                      ?.maintenanceDetails
                                      ?.costReference ??
                                  "N/A",
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: _InfoItem(
                              label: 'Request Reference',
                              value:
                                  data
                                      .data
                                      ?.maintenanceDetails
                                      ?.requestReference ??
                                  "N/A",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (data.data?.maintenanceDetails != null) ...[
                  // Assigned Person Section
                  SizedBox(height: 20.h),
                  Text(
                    "Assigned Person / Vendor",
                    style: GoogleFonts.outfit(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 15.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.black, width: 1.w),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 45.w,
                          height: 45.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 1.w),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              // 'assets/images/provider.png',
                              data.data?.assignedVendor?.avatar ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 24.sp,
                                  color: Colors.black87,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Assigned Person / Vendor",
                                style: GoogleFonts.outfit(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(42, 41, 51, 0.60),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                // "Raj Kumar",
                                data.data?.assignedVendor?.name ?? "",
                                style: GoogleFonts.outfit(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  height: 1.05,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                // "Plumbing Maintenance",
                                data.data?.assignedVendor?.role ?? "",
                                style: GoogleFonts.outfit(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF4A4A4A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Icon(
                        //   Icons.chevron_right,
                        //   color: Colors.black,
                        //   size: 20.sp,
                        // ),
                      ],
                    ),
                  ),
                ],
                // Maintenance History Section
                SizedBox(height: 18.h),
                _sectionHeader("Maintenance History", "ACTIVITY"),
                SizedBox(height: 16.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 19.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.black, width: 1.w),
                  ),
                  // child: Column(
                  //   children: [
                  //     _timelineTile(
                  //       title: "Maintenance Request Raised",
                  //       subtitle: "Water leakage repair request created.",
                  //       date: "20 Aug 2026 · 10:25 AM",
                  //       isFirst: true,
                  //       isLast: false,
                  //       isActive: false,
                  //     ),
                  //     _timelineTile(
                  //       title: "Maintenance Request Raised",
                  //       subtitle: "Water leakage repair request created.",
                  //       date: "20 Aug 2026 · 10:25 AM",
                  //       isFirst: false,
                  //       isLast: false,
                  //       isActive: false,
                  //     ),
                  //     _timelineTile(
                  //       title: "Maintenance Request Raised",
                  //       subtitle: "Water leakage repair request created.",
                  //       date: "20 Aug 2026 · 10:25 AM",
                  //       isFirst: false,
                  //       isLast: true,
                  //       isActive: true,
                  //     ),
                  //   ],
                  // ),
                  child: Column(
                    children: List.generate(
                      data.data?.activityHistory?.timeline?.length ?? 0,
                      (index) {
                        final item =
                            data.data?.activityHistory!.timeline![index];
                        return _timelineTile(
                          title: item?.title ?? "N/A",
                          subtitle: item?.status ?? "N/A",
                          date: item?.timestamp.toString() ?? "N/A",
                          isFirst: index == 0,
                          isLast:
                              index ==
                              data.data!.activityHistory!.timeline!.length - 1,
                          isActive: item?.status?.toLowerCase() == "completed",
                        );
                      },
                    ),
                  ),
                ),

                // Supporting Documents
                SizedBox(height: 20.h),
                _sectionHeader("Supporting Documents", "ATTACHMENTS"),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 15.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.black, width: 1.w),
                  ),
                  child: Row(
                    children:
                        (data.data?.supportingDocuments?.files != null &&
                            data.data!.supportingDocuments!.files!.isNotEmpty)
                        ? List.generate(
                            data.data!.supportingDocuments!.files!.length,
                            (index) {
                              final file =
                                  data.data!.supportingDocuments!.files![index];
                              final isLast =
                                  index ==
                                  data
                                          .data!
                                          .supportingDocuments!
                                          .files!
                                          .length -
                                      1;
                              final isImg =
                                  (file.fileType?.toLowerCase().contains(
                                        "img",
                                      ) ==
                                      true ||
                                  file.title?.toLowerCase().contains("img") ==
                                      true ||
                                  file.fileName?.toLowerCase().contains(
                                        "img",
                                      ) ==
                                      true);
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: isLast ? 0 : 19.w,
                                  ),
                                  child: _documentCard(
                                    file.title ?? file.fileName ?? "N/A",
                                    "${file.fileType ?? 'PDF'} · ${file.fileSize ?? '1 file'}",
                                    isImg
                                        ? Icons.image_outlined
                                        : Icons.description_outlined,
                                  ),
                                ),
                              );
                            },
                          )
                        : [
                            // Expanded(
                            //   child: _documentCard(
                            //     "Work Reference",
                            //     "PDF · 1 file",
                            //     Icons.description_outlined,
                            //   ),
                            // ),
                            // SizedBox(width: 19.w),
                            // Expanded(
                            //   child: _documentCard(
                            //     "Work img",
                            //     "PDF · 1 file",
                            //     Icons.image_outlined,
                            //   ),
                            // ),
                          ],
                  ),
                ),
                SizedBox(height: 20.h),
                _sectionHeader("Supporting Image", "ATTACHMENTS"),
                SizedBox(height: 16.h),
                Row(
                  children:
                      (data.data?.supportingDocuments?.images != null &&
                          data.data!.supportingDocuments!.images!.isNotEmpty)
                      ? List.generate(
                          data.data!.supportingDocuments!.images!.length,
                          (index) {
                            final image =
                                data.data!.supportingDocuments!.images![index];
                            final isLast =
                                index ==
                                data.data!.supportingDocuments!.images!.length -
                                    1;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: isLast ? 0 : 20.w,
                                ),
                                child: _imageAttachmentCard(
                                  image.label ??
                                      (index == 0 ? "BEFORE" : "AFTER"),
                                  image.imageUrl ?? image.placeholder ?? "",
                                  placeholder: image.placeholder,
                                ),
                              ),
                            );
                          },
                        )
                      : [
                          // Expanded(
                          //   child: _imageAttachmentCard(
                          //     "BEFORE",
                          //     "assets/before.png",
                          //   ),
                          // ),
                          // SizedBox(width: 20.w),
                          // Expanded(
                          //   child: _imageAttachmentCard(
                          //     "AFTER - PENDING",
                          //     "assets/after.png",
                          //   ),
                          // ),
                        ],
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: const Color(0xFFC18A00)),
                  ),
                  child: Text(
                    data.data?.supportingDocuments?.imageNote ??
                        "Maintenance records can include supporting documents, before/after images and maintenance history. Actual completion information will appear once the work is completed.",
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFC18A00),
                      letterSpacing: -0.1,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),
                // Bottom Bar
                // Row(
                //   children: [
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             "CURRENT STATUS",
                //             style: GoogleFonts.outfit(
                //               fontSize: 12.sp,
                //               fontWeight: FontWeight.w500,
                //               color: Colors.black,
                //             ),
                //           ),
                //           SizedBox(height: 4.h),
                //           Text(
                //             // "Maintenance work in progress",
                //             data.data?.currentStatusBar?.statusText ?? "N/A",
                //             style: GoogleFonts.outfit(
                //               fontSize: 14.sp,
                //               fontWeight: FontWeight.w500,
                //               color: Colors.black,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: 10.w,
                //         vertical: 4.h,
                //       ),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(40.r),
                //         border: Border.all(color: Colors.black, width: 1.w),
                //       ),
                //       child: Text(
                //         "View Full History →",
                //         style: GoogleFonts.outfit(
                //           fontSize: 12.sp,
                //           fontWeight: FontWeight.w500,
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 30.h),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(
              "No Data Found",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          );
        },
        loading: () =>
            Center(child: CircularProgressIndicator(color: AppColors.heading)),
      ),
    );
  }

  Widget _sectionHeader(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            letterSpacing: -0.2,
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Divider(
      height: 1.h,
      thickness: 0.8.w,
      color: const Color.fromRGBO(42, 41, 51, 0.6),
    );
  }

  Widget _timelineTile({
    required String title,
    required String subtitle,
    required String date,
    required bool isFirst,
    required bool isLast,
    required bool isActive,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16.w,
                height: 16.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: const Color(0xFFF2E6C6),
                  color: isActive
                      ? const Color(0xFFF2E6C6)
                      : Colors.grey.shade200,
                ),
                child: Center(
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: const Color(0xFFC18A00),
                      color: isActive
                          ? const Color(0xFFC18A00)
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.w,
                    // color: const Color(0xFFC18A00).withOpacity(0.5),
                    color: isActive
                        ? const Color(0xFFC18A00).withOpacity(0.5)
                        : Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 0.h, bottom: isLast ? 0 : 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.h,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF4A4A4A),
                      height: 1.h,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    date,
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF999999),
                      height: 1.h,
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

  Widget _documentCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, top: 5.h, bottom: 5.h),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.black, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 242, 165, 0.4),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Icon(icon, size: 16.sp, color: const Color(0xFF9D8422)),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: GoogleFonts.outfit(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF4A4A4A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageAttachmentCard(
    String label,
    String imagePath, {
    String? placeholder,
  }) {
    final bool isNetwork =
        imagePath.startsWith('http') ||
        (placeholder != null && placeholder.startsWith('http'));
    final String mainUrl = imagePath.isNotEmpty
        ? imagePath
        : (placeholder ?? "");

    return Stack(
      children: [
        Container(
          height: 103.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.grey[300],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: isNetwork
                ? Image.network(
                    mainUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      if (placeholder != null &&
                          placeholder.isNotEmpty &&
                          placeholder != mainUrl) {
                        return Image.network(
                          placeholder,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 40.sp,
                          ),
                        );
                      }
                      return Icon(Icons.image, color: Colors.grey, size: 40.sp);
                    },
                  )
                : Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image, color: Colors.grey, size: 40.sp);
                    },
                  ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          left: 10.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: const Color(0xFF292832),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  int _getActiveStep(String? status) {
    final s = (status ?? '').toLowerCase().trim();
    if (s.contains('complete') ||
        s.contains('resolve') ||
        s.contains('closed')) {
      return 2;
    } else if (s.contains('progress')) {
      return 1;
    }
    return 0;
  }

  Widget _buildProgressStepper(String currentStatus) {
    final activeStep = _getActiveStep(currentStatus);
    final steps = [
      {'title': 'Requested', 'sub': 'Pending review'},
      {'title': 'In Progress', 'sub': 'Work underway'},
      {'title': 'Completed', 'sub': 'Work finished'},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.black, width: 1.w),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.timeline,
                    size: 18.sp,
                    color: const Color(0xFFB8860B),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "WORK ORDER PROGRESS",
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => _showUpdateStatusModal(context, currentStatus),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101C16),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit_note, size: 14.sp, color: Colors.white),
                      SizedBox(width: 4.w),
                      Text(
                        "Update",
                        style: GoogleFonts.outfit(
                          fontSize: 12.sp,
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
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(steps.length, (index) {
              final isPassed = index < activeStep;
              final isCurrent = index == activeStep;
              final isLast = index == steps.length - 1;

              return Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 2.h,
                            color: index == 0
                                ? Colors.transparent
                                : (isPassed || isCurrent
                                      ? const Color(0xFF24B06A)
                                      : Colors.grey.shade300),
                          ),
                        ),
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPassed
                                ? const Color(0xFF24B06A)
                                : isCurrent
                                ? const Color(0xFFB8860B)
                                : Colors.grey.shade200,
                            border: Border.all(
                              color: isPassed
                                  ? const Color(0xFF24B06A)
                                  : isCurrent
                                  ? const Color(0xFFB8860B)
                                  : Colors.grey.shade400,
                              width: 1.5.w,
                            ),
                          ),
                          child: Center(
                            child: isPassed
                                ? Icon(
                                    Icons.check,
                                    size: 16.sp,
                                    color: Colors.white,
                                  )
                                : isCurrent
                                ? Container(
                                    width: 10.w,
                                    height: 10.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "${index + 1}",
                                    style: GoogleFonts.outfit(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 2.h,
                            color: isLast
                                ? Colors.transparent
                                : (isPassed
                                      ? const Color(0xFF24B06A)
                                      : Colors.grey.shade300),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      steps[index]['title']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 12.sp,
                        fontWeight: isCurrent
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: isCurrent
                            ? const Color(0xFFB8860B)
                            : isPassed
                            ? const Color(0xFF24B06A)
                            : Colors.black87,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      steps[index]['sub']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 10.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showUpdateStatusModal(BuildContext context, String currentStatus) {
    String selectedStatus = 'in_progress';
    final cur = currentStatus.toLowerCase();
    if (cur.contains('complete') || cur.contains('resolve')) {
      selectedStatus = 'completed';
    } else if (cur.contains('progress')) {
      selectedStatus = 'in_progress';
    } else {
      selectedStatus = 'pending';
    }

    final notesController = TextEditingController();
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Update Status",
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
                  SizedBox(height: 12.h),
                  Text(
                    "Select current maintenance work order status:",
                    style: GoogleFonts.outfit(
                      fontSize: 13.sp,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  ...[
                    {
                      'key': 'pending',
                      'label': 'Pending / Requested',
                      'icon': Icons.pending_actions,
                    },
                    {
                      'key': 'in_progress',
                      'label': 'In Progress',
                      'icon': Icons.construction,
                    },
                    {
                      'key': 'completed',
                      'label': 'Completed',
                      'icon': Icons.check_circle_outline,
                    },
                  ].map((item) {
                    final isSel = selectedStatus == item['key'];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: InkWell(
                        onTap: () {
                          setModalState(() {
                            selectedStatus = item['key'] as String;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: isSel
                                  ? const Color(0xFF101C16)
                                  : Colors.black26,
                              width: isSel ? 1.5.w : 1.w,
                            ),
                            color: isSel
                                ? const Color(0xFF101C16).withOpacity(0.06)
                                : Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                item['icon'] as IconData,
                                size: 18.sp,
                                color: isSel
                                    ? const Color(0xFF101C16)
                                    : Colors.black54,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  item['label'] as String,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    fontWeight: isSel
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              if (isSel)
                                Icon(
                                  Icons.radio_button_checked,
                                  size: 18.sp,
                                  color: const Color(0xFF101C16),
                                )
                              else
                                Icon(
                                  Icons.radio_button_off,
                                  size: 18.sp,
                                  color: Colors.black38,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 8.h),
                  Text(
                    "Remark Notes (Optional)",
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
                      hintText:
                          "Enter remarks (e.g. Work inspected and verified)...",
                      hintStyle: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Colors.black26),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Colors.black26),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF101C16),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: isSubmitting
                          ? null
                          : () async {
                              setModalState(() => isSubmitting = true);
                              try {
                                await ref
                                    .read(authServiceProvider)
                                    .updateMaintenanceStatus(
                                      id: widget.id,
                                      status: selectedStatus,
                                      notes: notesController.text.trim(),
                                    );
                                ref.invalidate(
                                  maintananceDetailsProvider(widget.id),
                                );
                                if (context.mounted) {
                                  Navigator.pop(context);
                                  showSuccessSnackBar(
                                    "Work order status updated successfully",
                                  );
                                }
                              } catch (e) {
                                setModalState(() => isSubmitting = false);
                                showErrorSnackBar(
                                  "Failed to update status: $e",
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF101C16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: isSubmitting
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              "Save & Update Status",
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
            );
          },
        );
      },
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoItem({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(42, 41, 51, 0.6),
            height: 1,
            letterSpacing: -0.15,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: valueColor ?? Colors.black,
            height: 1,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}
