import 'package:flutter/cupertino.dart' hide Banner;
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/AssociationScreen/AssociationInspectionReport/InspectionReport_Screen.dart';
import 'package:property_association_or_resident/AssociationScreen/AssociationProperty/Provider/getPropertyUnitDetailsProvider.dart';
import 'package:property_association_or_resident/AssociationScreen/AssociatoinComplaint/Complaint.dart';
import 'package:property_association_or_resident/AssociationScreen/Mantenance&Service/MantenanceService.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/getPropertyUnitDetailsModel.dart';

import '../AssociationDocument/AssociationDocument.dart';

class AssociationPropertyUnitDetails extends ConsumerStatefulWidget {
  final String id;
  const AssociationPropertyUnitDetails({super.key, required this.id});

  @override
  ConsumerState<AssociationPropertyUnitDetails> createState() =>
      _AssociationPropertyUnitDetailsState();
}

class _AssociationPropertyUnitDetailsState
    extends ConsumerState<AssociationPropertyUnitDetails> {
  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(getPropertyUnitDetailsProvider(widget.id));
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
                    "Property / Unit Details",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Complete information for this unit",
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
      body: detailState.when(
        data: (detailsModel) {
          final data = detailsModel.data;
          final banner = data?.banner;
          final statsCards = data?.statsCards;
          final infoList = data?.propertyInformation ?? [];
          final owner = data?.assignedPropertyOwner;
          final activities = data?.recentPropertyActivity ?? [];
          final records = data?.propertyRecords ?? [];

          // final scoreVal =
          //     double.tryParse(
          //       statsCards?.propertyScore?.value?.toString() ?? "86",
          //     ) ??
          //     86.0;
          // final scoreInt = scoreVal.toInt();

          return RefreshIndicator(
            onRefresh: () async {
              return ref.refresh(
                getPropertyUnitDetailsProvider(widget.id).future,
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    _propertyImageCard(banner),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: _statCard(
                            icon: _mapIcon(
                              statsCards?.unitNumber?.icon,
                              Icons.grid_view_rounded,
                            ),
                            value: statsCards?.unitNumber?.value ?? "N/A",
                            title:
                                statsCards?.unitNumber?.label ?? "Unit Number",
                          ),
                        ),
                        SizedBox(width: 11.w),
                        Expanded(
                          child: _statCard(
                            icon: _mapIcon(
                              statsCards?.propertyType?.icon,
                              Icons.home_outlined,
                            ),
                            value: statsCards?.propertyType?.value ?? "N/A",
                            title:
                                statsCards?.propertyType?.label ??
                                "Property Type",
                          ),
                        ),
                        SizedBox(width: 11.w),
                        Expanded(
                          child: _statCard(
                            icon: _mapIcon(
                              statsCards?.propertyScore?.icon,
                              Icons.diamond_outlined,
                            ),
                            value: "${statsCards?.propertyScore?.value ?? 0}",
                            title:
                                statsCards?.propertyScore?.label ??
                                "Property Score",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Property Information",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 13.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF000000),
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        children: [
                          if (infoList.isNotEmpty) ...[
                            for (int i = 0; i < infoList.length; i++) ...[
                              if (i > 0) _divider(),
                              _informationRow(
                                icon: _mapIcon(
                                  infoList[i].icon,
                                  Icons.info_outline,
                                ),
                                label: infoList[i].title ?? "",
                                value: infoList[i].value ?? "",
                                action: infoList[i].actionText,
                                bottomPadding: i == infoList.length - 1
                                    ? 10
                                    : 8,
                              ),
                            ],
                          ] else ...[
                            // _informationRow(
                            //   icon: Icons.grid_view_rounded,
                            //   label: "Unit Number",
                            //   value: banner?.title ?? "Apartment A-204",
                            // ),
                            // _divider(),
                            // _informationRow(
                            //   icon: Icons.receipt_long_outlined,
                            //   label: "Block / Building",
                            //   value: "Block A",
                            //   action: "View ›",
                            // ),
                            // _divider(),
                            // _informationRow(
                            //   icon: Icons.home_outlined,
                            //   label: "Complex",
                            //   value: "Green Valley Residency",
                            // ),
                            // _divider(),
                            // _informationRow(
                            //   icon: Icons.location_on_outlined,
                            //   label: "Location",
                            //   value: "Jaipur, Rajasthan",
                            // ),
                            // _divider(),
                            // _informationRow(
                            //   icon: Icons.diamond_outlined,
                            //   label: "Property Type",
                            //   value: "Residential Apartment · 3 BHK",
                            // ),
                            // _divider(),
                            // _informationRow(
                            //   icon: Icons.radio_button_checked,
                            //   label: "Property Status",
                            //   value: "Active / Good Condition",
                            //   bottomPadding: 10,
                            // ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 13.h),
                    Text(
                      data?.assignedPropertyOwner?.roleLabel ??
                          "Assigned Owner",
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF000000),
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFD9D9D9),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child:
                                    (owner?.avatar != null &&
                                        owner!.avatar!.isNotEmpty)
                                    ? Image.network(
                                        owner.avatar!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.person,
                                                  color: Colors.grey,
                                                ),
                                      )
                                    : const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      owner?.name ?? "Arjun Sharma",
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                    Text(
                                      owner?.propertyOwnership ??
                                          owner?.roleLabel ??
                                          "Registered Property Owner",
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromRGBO(
                                          0,
                                          0,
                                          0,
                                          0.6,
                                        ),
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (owner?.isVerified == true)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                    vertical: 5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF24B06A),
                                      width: 1.w,
                                    ),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    "Verified",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF24B06A),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          const Divider(height: 1, color: Color(0xFF101C16)),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                child: _ownerInfo(
                                  title: "CONTACT",
                                  value:
                                      owner?.contact ??
                                      owner?.fullContact ??
                                      "",
                                ),
                              ),
                              Expanded(
                                child: _ownerInfo(
                                  title: "OWNERSHIP",
                                  value:
                                      owner?.propertyOwnership ??
                                      owner?.tag ??
                                      "Registered Owner",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Occupancy Status",
                    //       style: GoogleFonts.outfit(
                    //         fontSize: 17.sp,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.black,
                    //         letterSpacing: -0.2,
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         // Navigator.push(
                    //         //   context,
                    //         //   CupertinoPageRoute(
                    //         //     builder: (context) =>
                    //         //         const AssociationOccupancePropertyStatus(),
                    //         //   ),
                    //         // );
                    //       },
                    //       child: Text(
                    //         "View Status ›",
                    //         style: GoogleFonts.outfit(
                    //           fontSize: 14.sp,
                    //           fontWeight: FontWeight.w500,
                    //           color: const Color(0xFF000000),
                    //           letterSpacing: -0.2,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 16.h),
                    // Container(
                    //   width: double.infinity,
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 9.w,
                    //     vertical: 12.h,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: const Color(0xFF000000),
                    //       width: 1.w,
                    //     ),
                    //     borderRadius: BorderRadius.circular(10.r),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Container(
                    //             height: 33.h,
                    //             width: 33.w,
                    //             decoration: BoxDecoration(
                    //               border: Border.all(
                    //                 color: const Color(0xFF000000),
                    //                 width: 1.w,
                    //               ),
                    //               borderRadius: BorderRadius.circular(4.r),
                    //             ),
                    //             child: Center(
                    //               child: Image.asset(
                    //                 "assets/associationImage/currently.png",
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(width: 6.w),
                    //           Expanded(
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   banner?.isActive == true ||
                    //                           banner?.status?.toLowerCase() ==
                    //                               "active"
                    //                       ? "Currently Occupied"
                    //                       : "Currently Vacant",
                    //                   style: GoogleFonts.outfit(
                    //                     fontSize: 17.sp,
                    //                     fontWeight: FontWeight.w500,
                    //                     color: Colors.black,
                    //                     letterSpacing: -0.2,
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   "Unit occupancy information",
                    //                   style: GoogleFonts.outfit(
                    //                     fontSize: 14.sp,
                    //                     fontWeight: FontWeight.w500,
                    //                     color: const Color.fromRGBO(
                    //                       0,
                    //                       0,
                    //                       0,
                    //                       0.7,
                    //                     ),
                    //                     letterSpacing: -0.2,
                    //                     height: 1.1,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //           Container(
                    //             padding: EdgeInsets.symmetric(
                    //               horizontal: 10.w,
                    //               vertical: 4.h,
                    //             ),
                    //             decoration: BoxDecoration(
                    //               border: Border.all(
                    //                 color: const Color(0xFF1E5993),
                    //                 width: 1.w,
                    //               ),
                    //               borderRadius: BorderRadius.circular(7.r),
                    //             ),
                    //             child: Text(
                    //               banner?.status ?? "Occupied",
                    //               style: GoogleFonts.outfit(
                    //                 fontSize: 14.sp,
                    //                 fontWeight: FontWeight.w500,
                    //                 color: const Color(0xFF1E5993),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(height: 24.h),
                    //       Row(
                    //         children: [
                    //           Expanded(
                    //             child: Container(
                    //               height: 3.h,
                    //               decoration: BoxDecoration(
                    //                 color: const Color(0xFF101C16),
                    //                 borderRadius: BorderRadius.circular(10.r),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(height: 5.h),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             "Occupancy",
                    //             style: GoogleFonts.outfit(
                    //               fontSize: 12.sp,
                    //               fontWeight: FontWeight.w500,
                    //               color: Colors.black,
                    //               letterSpacing: -0.2,
                    //             ),
                    //           ),
                    //           Text(
                    //             banner?.status ?? "Active",
                    //             style: GoogleFonts.outfit(
                    //               fontSize: 12.sp,
                    //               fontWeight: FontWeight.w500,
                    //               color: Colors.black,
                    //               letterSpacing: -0.2,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 20.h),
                    // Row(
                    //   children: [
                    //     Text(
                    //       "Property Performance",
                    //       style: GoogleFonts.outfit(
                    //         fontSize: 17.sp,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.black,
                    //         letterSpacing: -0.2,
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     Text(
                    //       "View Details",
                    //       style: GoogleFonts.outfit(
                    //         fontSize: 14.sp,
                    //         fontWeight: FontWeight.w500,
                    //         color: const Color(0xFF000000),
                    //         letterSpacing: -0.2,
                    //       ),
                    //     ),
                    //     SizedBox(width: 2.w),
                    //     Icon(
                    //       Icons.chevron_right,
                    //       size: 17.sp,
                    //       color: Colors.black,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 16.h),
                    // Container(
                    //   width: double.infinity,
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 14.w,
                    //     vertical: 18.h,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: const Color(0xFF000000),
                    //       width: 1.w,
                    //     ),
                    //     borderRadius: BorderRadius.circular(10.r),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //         width: 60.w,
                    //         height: 60.w,
                    //         child: Stack(
                    //           alignment: Alignment.center,
                    //           children: [
                    //             SizedBox(
                    //               width: 55.w,
                    //               height: 55.w,
                    //               child: CircularProgressIndicator(
                    //                 value: (scoreVal / 100).clamp(0.0, 1.0),
                    //                 strokeWidth: 5.w,
                    //                 backgroundColor: const Color(0xFF101C16),
                    //                 color: const Color(0xFF4A8266),
                    //               ),
                    //             ),
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Text(
                    //                   "$scoreInt",
                    //                   style: GoogleFonts.outfit(
                    //                     fontSize: 17.sp,
                    //                     fontWeight: FontWeight.w500,
                    //                     color: const Color(0xFF101C16),
                    //                     letterSpacing: -0.2,
                    //                     height: 1.h,
                    //                   ),
                    //                 ),
                    //                 SizedBox(height: 2.h),
                    //                 Text(
                    //                   "/100",
                    //                   style: GoogleFonts.outfit(
                    //                     fontSize: 12.sp,
                    //                     fontWeight: FontWeight.w500,
                    //                     color: const Color(0xFF101C16),
                    //                     letterSpacing: -0.2,
                    //                     height: 1.h,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(width: 10.w),
                    //       Expanded(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Property Score",
                    //               style: GoogleFonts.outfit(
                    //                 fontSize: 17.sp,
                    //                 fontWeight: FontWeight.w500,
                    //                 color: const Color(0xFF101C16),
                    //                 letterSpacing: -0.2,
                    //               ),
                    //             ),
                    //             SizedBox(height: 3.h),
                    //             Text(
                    //               "Overall property performance based on maintenance, cleanliness, security and inspections",
                    //               style: GoogleFonts.outfit(
                    //                 fontSize: 14.sp,
                    //                 fontWeight: FontWeight.w500,
                    //                 height: 1.1,
                    //                 color: const Color.fromRGBO(
                    //                   42,
                    //                   41,
                    //                   51,
                    //                   0.7,
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(height: 3.h),
                    //             Row(
                    //               children: [
                    //                 Container(
                    //                   height: 7.h,
                    //                   width: 7.w,
                    //                   decoration: const BoxDecoration(
                    //                     shape: BoxShape.circle,
                    //                     color: Color(0xFF24B06A),
                    //                   ),
                    //                 ),
                    //                 SizedBox(width: 3.w),
                    //                 Text(
                    //                   scoreVal >= 80
                    //                       ? "Good Performance"
                    //                       : (scoreVal >= 50
                    //                             ? "Average Performance"
                    //                             : "Needs Attention"),
                    //                   style: GoogleFonts.outfit(
                    //                     fontSize: 12.sp,
                    //                     fontWeight: FontWeight.w700,
                    //                     color: const Color(0xFF24B06A),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Text(
                          "Recent Property Activity",
                          style: GoogleFonts.outfit(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "View All",
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000),
                            letterSpacing: -0.2,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Icon(
                          Icons.chevron_right,
                          size: 17.sp,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF000000),
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (activities.isNotEmpty) ...[
                            for (int i = 0; i < activities.length; i++) ...[
                              if (i > 0) _divider(),
                              _activityItem(
                                icon: _mapActivitySymbol(activities[i].icon),
                                title: activities[i].title ?? "",
                                subtitle: activities[i].subtitle ?? "",
                                date: activities[i].date ?? "",
                              ),
                            ],
                          ] else ...[
                            // _activityItem(
                            //   icon: "!",
                            //   title: "Inspection Completed",
                            //   subtitle: "Latest property inspection recorded",
                            //   date: "15 Aug",
                            // ),
                            // _divider(),
                            // _activityItem(
                            //   icon: "▣",
                            //   title: "Maintenance Updated",
                            //   subtitle: "Property maintenance record updated",
                            //   date: "12 Aug",
                            // ),
                            // _divider(),
                            // _activityItem(
                            //   icon: "₹",
                            //   title: "Document Added",
                            //   subtitle: "New property document available",
                            //   date: "09 Aug",
                            // ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Property Records",
                      style: GoogleFonts.outfit(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    if (records.isNotEmpty)
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 1.3,
                        ),
                        itemCount: records.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final rec = records[index];
                          return _recordCard(
                            icon: _mapRecordSymbol(rec.icon, rec.id),
                            title: rec.title ?? "",
                            description: rec.subtitle ?? "",
                            buttonText: rec.actionText ?? "View Records →",
                            onTap: () {
                              if (rec.id == "inspection" ||
                                  (rec.title?.toLowerCase().contains(
                                        "inspection",
                                      ) ??
                                      false)) {
                                // Navigator.push(
                                //   context,
                                //   CupertinoPageRoute(
                                //     builder: (context) =>
                                //         const InspectionreportScreen(),
                                //   ),
                                // );
                              } else if (rec.id == "maintenance" ||
                                  (rec.title?.toLowerCase().contains(
                                        "maintenance",
                                      ) ??
                                      false)) {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const MantenanceService(),
                                  ),
                                );
                              } else if (rec.id == "documents" ||
                                  (rec.title?.toLowerCase().contains(
                                        "documents",
                                      ) ??
                                      false)) {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const AssociationDocument(
                                          isShowIcons: true,
                                        ),
                                  ),
                                );
                              } else if (rec.id == "complaints" ||
                                  (rec.title?.toLowerCase().contains(
                                        "complaints",
                                      ) ??
                                      false)) {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const Complaint(),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      )
                    else
                      GridView.count(
                        padding: EdgeInsets.zero,
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 1.3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _recordCard(
                            icon: "✓",
                            title: "Inspection",
                            description:
                                "View inspection records and findings.",
                            buttonText: "View Records →",
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const InspectionreportScreen(),
                                ),
                              );
                            },
                          ),
                          _recordCard(
                            icon: "⚒",
                            title: "Maintenance",
                            description:
                                "View maintenance activity and history.",
                            buttonText: "View Records →",
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const MantenanceService(),
                                ),
                              );
                            },
                          ),
                          _recordCard(
                            icon: "◌",
                            title: "Complaints",
                            description:
                                "View property-related complaints and issues.",
                            buttonText: "View Records →",
                            onTap: () {},
                          ),
                          _recordCard(
                            icon: "▤",
                            title: "Documents",
                            description:
                                "Access documents linked to this property.",
                            buttonText: "View Documents →",
                            onTap: () {},
                          ),
                        ],
                      ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () =>
            Center(child: CircularProgressIndicator(color: AppColors.heading)),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Something went wrong",
                style: GoogleFonts.outfit(color: AppColors.heading),
              ),
              SizedBox(height: 8.h),
              ElevatedButton(
                onPressed: () =>
                    ref.refresh(getPropertyUnitDetailsProvider(widget.id)),
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _propertyImageCard(Banner? banner) {
    final imageUrl = banner?.image;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF17221D), width: 1.w),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: hasImage
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      "assets/property_img (2).png",
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset("assets/property_img (2).png", fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.10),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 17.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        banner?.tag ?? "PROPERTY UNIT",
                        style: GoogleFonts.outfit(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFFFFFFF),
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        banner?.title ?? "Apartment A-204",
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        banner?.subtitle ??
                            "Block A · Green Valley Residency · Jaipur",
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(255, 255, 255, 0.6),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
                    border: Border.all(
                      color: const Color(0xFF24B06A),
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    banner?.status ?? "Active",
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF24B06A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _mapIcon(String? iconKey, IconData defaultIcon) {
    if (iconKey == null) return defaultIcon;
    switch (iconKey.toLowerCase()) {
      case "door_sliding":
      case "grid_view":
        return Icons.grid_view_rounded;
      case "home":
        return Icons.home_outlined;
      case "verified_star":
      case "diamond":
        return Icons.diamond_outlined;
      case "domain":
        return Icons.receipt_long_outlined;
      case "location_city":
        return Icons.home_outlined;
      case "location_on":
      case "location":
        return Icons.location_on_outlined;
      case "apartment":
        return Icons.apartment;
      case "check_circle":
        return Icons.radio_button_checked;
      default:
        return defaultIcon;
    }
  }

  String _mapActivitySymbol(String? iconKey) {
    if (iconKey == null) return "▣";
    switch (iconKey.toLowerCase()) {
      case "build_wrench":
      case "maintenance":
        return "⚒";
      case "description_file":
      case "document":
        return "▤";
      case "inspection":
        return "!";
      case "payment":
        return "₹";
      default:
        return "▣";
    }
  }

  String _mapRecordSymbol(String? iconKey, String? id) {
    final key = (iconKey ?? id ?? "").toLowerCase();
    if (key.contains("inspection")) return "✓";
    if (key.contains("wrench") || key.contains("maintenance")) return "⚒";
    if (key.contains("chat") || key.contains("complaint")) return "◌";
    if (key.contains("file") || key.contains("doc")) return "▤";
    return "▤";
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String title,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 8.w, top: 7.h, right: 8.w, bottom: 7.h),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF000000), width: 1.w),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF000000), width: 1.w),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Icon(icon, size: 13.sp, color: Colors.black),
          ),
          SizedBox(height: 3.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              letterSpacing: -0.2,
            ),
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              letterSpacing: -0.2,
              height: 1.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _informationRow({
    required IconData icon,
    required String label,
    required String value,
    String? action,
    double bottomPadding = 8,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 36.h,
          width: 38.w,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF000000), width: 1.w),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Icon(icon, size: 13.sp, color: Colors.black),
        ),
        SizedBox(width: 7.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(42, 41, 51, 0.7),
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF101C16),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
        if (action != null)
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Text(
              action,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2A2933),
                letterSpacing: -0.2,
              ),
            ),
          ),
      ],
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.only(top: 14.h, bottom: 10.h),
      child: Divider(height: 1.h, color: Color.fromRGBO(41, 42, 51, 0.6)),
    );
  }

  Widget _ownerInfo({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(42, 41, 51, 0.7),
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF101C16),
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  Widget _activityItem({
    required String icon,
    required String title,
    required String subtitle,
    required String date,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 36.h,
            width: 36.w,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF171717), width: 1.w),
              borderRadius: BorderRadius.circular(5.r),
            ),
            alignment: Alignment.center,
            child: Text(
              icon,
              style: GoogleFonts.outfit(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF000000),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF101C16),
                    letterSpacing: -0.2,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    color: Color.fromRGBO(42, 41, 51, 0.7),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            date,
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2A2933),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recordCard({
    required String icon,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF171717), width: 1.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30.h,
              width: 30.w,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF000000), width: 1.w),
                borderRadius: BorderRadius.circular(4.r),
              ),
              alignment: Alignment.center,
              child: Text(
                icon,
                style: GoogleFonts.outfit(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000),
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              description,
              style: GoogleFonts.outfit(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(42, 41, 51, 0.7),
                letterSpacing: -0.2,
              ),
            ),
            Spacer(),
            Text(
              buttonText,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF101C16),
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
