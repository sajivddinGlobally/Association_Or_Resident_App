import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/AssociationScreen/AssociationServiceMagagement/ServiceManagePerformance.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

import 'provider/serviceManagementProviderDetailsProvider.dart';

class ServiceManageProviderDetails extends ConsumerStatefulWidget {
  final String id;
  const ServiceManageProviderDetails({super.key, required this.id});

  @override
  ConsumerState<ServiceManageProviderDetails> createState() =>
      _ServiceManageProviderDetailsState();
}

class _ServiceManageProviderDetailsState
    extends ConsumerState<ServiceManageProviderDetails> {
  @override
  Widget build(BuildContext context) {
    final serviceProviderState = ref.watch(
      serviceManagementProviderDetailsProvider(widget.id),
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
                    "Service Details",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Service Management",
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
      body: serviceProviderState.when(
        data: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF000000), width: 1.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.data.registeredServiceProvider.tag,
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF000000),
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 6.h,
                                  width: 6.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF12A65A),
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  data.data.registeredServiceProvider.badge,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF24B06A),
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),
                        Text(
                          data.data.registeredServiceProvider.name,
                          style: GoogleFonts.outfit(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            letterSpacing: -0.2,
                            height: 1.h,
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          data.data.registeredServiceProvider.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                            height: 1.h,
                          ),
                        ),
                        SizedBox(height: 13.h),
                        Divider(
                          height: 1,
                          thickness: 0.8,
                          color: Color.fromRGBO(16, 28, 22, 0.5),
                        ),
                        SizedBox(height: 13.h),
                        Row(
                          children: [
                            Expanded(
                              child: _serviceStat(
                                label: "Services",
                                value: data
                                    .data
                                    .registeredServiceProvider
                                    .stats
                                    .services,
                                status: "assigned",
                              ),
                            ),
                            Expanded(
                              child: _serviceStat(
                                label: "Since",
                                value: data
                                    .data
                                    .registeredServiceProvider
                                    .stats
                                    .since,
                                status: "registered",
                              ),
                            ),
                            Expanded(
                              child: _serviceStat(
                                label: "Rating",
                                value: data
                                    .data
                                    .registeredServiceProvider
                                    .stats
                                    .rating,
                                status: "excellent",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Provider Information",
                    style: GoogleFonts.outfit(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000),
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF000000), width: 1.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _providerInfoItem(
                                label: "Provider Type",
                                value:
                                    data.data.providerInformation.providerType,
                              ),
                            ),
                            SizedBox(width: 25.w),
                            Expanded(
                              child: _providerInfoItem(
                                label: "Provider ID",
                                value: data.data.providerInformation.providerId,
                                valueColor: const Color(0xFFA97700),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 11.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _providerInfoItem(
                                label: "Registration Date",
                                value: data
                                    .data
                                    .providerInformation
                                    .registrationDate,
                              ),
                            ),
                            SizedBox(width: 25.w),
                            Expanded(
                              child: _providerInfoItem(
                                label: "Status",
                                value: data.data.providerInformation.status,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 11.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _providerInfoItem(
                                label: "Contract Status",
                                value: data
                                    .data
                                    .providerInformation
                                    .contractStatus,
                              ),
                            ),
                            SizedBox(width: 25.w),
                            Expanded(
                              child: _providerInfoItem(
                                label: "Service Area",
                                value:
                                    data.data.providerInformation.serviceArea,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.w),
                  Text(
                    "Primary Contact",
                    style: GoogleFonts.outfit(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000000),
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Color(0xFF000000), width: 1.w),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF000000),
                              width: 1.w,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              data.data.primaryContact.avatar,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 18.sp,
                                  color: Colors.black87,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.data.primaryContact.title,
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(42, 41, 52, 0.6),
                                  height: 1,
                                  letterSpacing: -0.1,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                data.data.primaryContact.contactPerson,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF101C16),
                                  letterSpacing: -0.1,
                                ),
                              ),
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                data.data.primaryContact.contactRole,
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(42, 41, 52, 0.6),
                                  height: 1,
                                  letterSpacing: -0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF2A2933),
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.w),
                  Text(
                    "Contact Details",
                    style: GoogleFonts.outfit(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000000),
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF000000), width: 1.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _providerInfoItem(
                                label: "Phone",
                                value: data.data.contactDetails.phone,
                              ),
                            ),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: _providerInfoItem(
                                label: "Email",
                                value: data.data.contactDetails.email,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _providerInfoItem(
                                label: "Working Hours",
                                value: data.data.contactDetails.workingHours,
                              ),
                            ),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: _providerInfoItem(
                                label: "Emergency Support",
                                value:
                                    data.data.contactDetails.emergencySupport,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Assigned Services",
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
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: data.data.assignedServices.services.length,
                      itemBuilder: (context, index) {
                        final service =
                            data.data.assignedServices.services[index];

                        return Column(
                          children: [
                            _serviceItem(
                              icon: Icons.cleaning_services_outlined,
                              title: service.title,
                              subtitle: service.subtitle,
                              status: service.status,
                            ),

                            if (index !=
                                data.data.assignedServices.services.length - 1)
                              _divider(),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Provider Performance",
                    style: GoogleFonts.outfit(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              ServiceManagePerformance(id: widget.id),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF101C16),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Service Performance",
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        height: 1.1,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      data.data.providerPerformance.headline,
                                      style: GoogleFonts.outfit(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        height: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                data.data.providerPerformance.score > 10
                                    ? "${(data.data.providerPerformance.score / 10).toStringAsFixed(1)}/10"
                                    : "${data.data.providerPerformance.score}/10",
                                style: GoogleFonts.outfit(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  height: 1.1,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: LinearProgressIndicator(
                              value:
                                  (data.data.providerPerformance.score > 10
                                          ? data
                                                    .data
                                                    .providerPerformance
                                                    .score /
                                                100
                                          : data
                                                    .data
                                                    .providerPerformance
                                                    .score /
                                                10)
                                      .clamp(0.0, 1.0),
                              minHeight: 3.h,
                              backgroundColor: const Color(0xFF919191),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF00BB5E),
                              ),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Current Performance",
                                  style: GoogleFonts.outfit(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                              Text(
                                data.data.providerPerformance.serviceQuality,
                                style: GoogleFonts.outfit(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Provider Documents",
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
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: data.data.providerDocuments.documents.length,
                      itemBuilder: (context, index) {
                        final document =
                            data.data.providerDocuments.documents[index];

                        return Column(
                          children: [
                            _documentItem(
                              icon: Icons.description_outlined,
                              title: document.title,
                              subtitle: document.format,
                              status: document.status,
                            ),

                            if (index !=
                                data.data.providerDocuments.documents.length -
                                    1)
                              _divider(),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          log(stackTrace.toString());
          log(error.toString());
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(vertical: 20.h),
            alignment: Alignment.center,
            child: Text(
              "Something went wrong",
              style: GoogleFonts.outfit(
                fontSize: 15.sp,
                color: AppColors.heading,
              ),
            ),
          );
        },
        loading: () {
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.heading),
            ),
          );
        },
      ),
    );
  }

  Widget _serviceStat({
    required String label,
    required String value,
    required String status,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(42, 41, 51, 0.6),
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF000000),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          status,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFFB8860B),
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _providerInfoItem({
    required String label,
    required String value,
    Color valueColor = Colors.black,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(42, 41, 51, 0.6),
            height: 1.1,
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: valueColor,
            height: 1.1,
            letterSpacing: -0.4,
          ),
        ),
      ],
    );
  }

  Widget _serviceItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.w),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: Icon(icon, size: 15.sp, color: Colors.black),
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
                    color: Colors.black,
                    height: 1.05,
                    letterSpacing: -0.2,
                  ),
                ),

                SizedBox(height: 2.h),

                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                    height: 1.05,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 3.h),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF11B262), width: 1.w),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              status,
              style: GoogleFonts.outfit(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF11B262),
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.w),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: Icon(icon, size: 15.sp, color: Colors.black),
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
                    color: Colors.black,
                    height: 1.05,
                    letterSpacing: -0.2,
                  ),
                ),

                SizedBox(height: 3.h),

                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                    height: 1.05,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          Text(
            status,
            style: GoogleFonts.outfit(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFB8860B),
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1.h,
      width: double.infinity,
      color: Color.fromRGBO(16, 28, 22, 0.5),
    );
  }
}
