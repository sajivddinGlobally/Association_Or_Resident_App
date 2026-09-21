import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/AssociationScreen/AssociationProperty/AssociationPropertyUnitDetails.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'Provider/getPropeertyUnitListProvider.dart';

class AssociationProperty extends ConsumerStatefulWidget {
  const AssociationProperty({super.key});

  @override
  ConsumerState<AssociationProperty> createState() =>
      _AssociationPropertyState();
}

class _AssociationPropertyState extends ConsumerState<AssociationProperty> {
  int selectedFilter = 0;
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusFilter = "";
    String blockFilter = "";

    final dynamicFilters = [
      "All Units",
      "Occupied",
      "Vacant",
      "Block A",
      "Block B",
      "Block C",
      "Block D",
    ];

    if (selectedFilter == 1) {
      statusFilter = "occupied";
    } else if (selectedFilter == 2) {
      statusFilter = "vacant";
    } else if (selectedFilter == 3) {
      blockFilter = "A";
    } else if (selectedFilter == 4) {
      blockFilter = "B";
    } else if (selectedFilter == 5) {
      blockFilter = "C";
    } else if (selectedFilter == 6) {
      blockFilter = "D";
    }

    final filterParams = (
      status: statusFilter,
      block: blockFilter,
      search: searchQuery,
    );

    final state = ref.watch(getPropertyUnitListProvider(filterParams));
    final complex = state.valueOrNull?.data?.complex;
    final summary = state.valueOrNull?.data?.summary;
    final disclaimer = state.valueOrNull?.data?.disclaimer;
    final isLoading = state.isLoading;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.scaffoldBg,
        titleSpacing: 20.w,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Property / Unit List",
                  style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff292832),
                    letterSpacing: -0.64,
                  ),
                ),
                Text(
                  "View and monitor all units in your complex",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF2A2933),
                    letterSpacing: -0.24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return ref.refresh(getPropertyUnitListProvider(filterParams).future);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                height: 250.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: AppColors.heading, width: 0.2.w),
                ),
                clipBehavior: Clip.antiAlias,
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.heading,
                          strokeWidth: 1.3.w,
                        ),
                      )
                    : Stack(
                        children: [
                          Positioned.fill(
                            child:
                                (complex?.image != null &&
                                    complex!.image!.isNotEmpty)
                                ? Image.network(
                                    complex.image!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                              'assets/document_img.png',
                                              fit: BoxFit.cover,
                                            ),
                                  )
                                : Image.asset(
                                    'assets/document_img.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.0, 0.40, 0.72, 1.0],
                                  colors: [
                                    Colors.transparent,
                                    Colors.black12,
                                    Colors.black87,
                                    const Color(0xFF071A13),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 18.w,
                            right: 18.w,
                            bottom: 20.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 30.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.w,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          6.r,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.home_outlined,
                                        color: Colors.white,
                                        size: 16.sp,
                                      ),
                                    ),
                                    SizedBox(width: 7.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            complex?.name ??
                                                'Green Valley Residency',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.outfit(
                                              color: Colors.white,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w500,
                                              height: 1.1,
                                              letterSpacing: -0.2,
                                            ),
                                          ),
                                          Text(
                                            complex?.address ??
                                                'Sector 45 · Noida, Uttar Pradesh',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.outfit(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              height: 1.1,
                                              letterSpacing: -0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Container(
                                      width: 79.w,
                                      height: 28.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFF24B06A),
                                          width: 1.w,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          50.r,
                                        ),
                                      ),
                                      child: Text(
                                        complex?.status ?? 'Active',
                                        style: GoogleFonts.outfit(
                                          color: const Color(0xFF24B06A),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Container(
                                  height: 1.h,
                                  width: double.infinity,
                                  color: const Color(
                                    0xFFFFFFFF,
                                  ).withValues(alpha: 0.6),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _statItem(
                                        value: '${complex?.totalUnits ?? 0}',
                                        title: 'Total Units',
                                      ),
                                    ),
                                    Expanded(
                                      child: _statItem(
                                        value: '${complex?.occupiedUnits ?? 0}',
                                        title: 'Occupied',
                                      ),
                                    ),
                                    Expanded(
                                      child: _statItem(
                                        value: '${complex?.vacantUnits ?? 0}',
                                        title: 'Vacant',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                height: 45.h,
                width: double.infinity,
                padding: EdgeInsets.only(left: 16.w, right: 10.w),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xff101C16), width: 1),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 25.sp,
                      color: const Color(0xff8B8D8B),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (val) {
                          setState(() {
                            searchQuery = val.trim();
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: "Search service or provider...",
                          hintStyle: GoogleFonts.outfit(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff8B8D8B),
                            letterSpacing: -0.3,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    if (searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          searchController.clear();
                          setState(() {
                            searchQuery = "";
                          });
                        },
                        child: Icon(
                          Icons.close,
                          size: 18.sp,
                          color: const Color(0xff8B8D8B),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(dynamicFilters.length, (index) {
                    final bool isSelected = selectedFilter == index;
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            vertical: 6.h,
                            horizontal: 14.w,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xff101C16)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: const Color(0xff101C16),
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            dynamicFilters[index],
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xff101C16),
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      summary?.label ?? 'All Units',
                      style: GoogleFonts.outfit(
                        color: const Color(0xFF000000),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(
                      summary?.totalUnitsDisplay ??
                          '${complex?.totalUnits ?? 0} Units',
                      style: GoogleFonts.outfit(
                        color: const Color(0xFF000000),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              state.when(
                data: (data) {
                  final blocks = data.data?.blocks ?? [];
                  if (blocks.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 30.h,
                      ),
                      child: Center(
                        child: Text(
                          "No units found",
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final block in blocks) ...[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            top: 10.h,
                            bottom: 10.h,
                          ),
                          child: Text(
                            block.blockTitle?.toUpperCase() ??
                                '${block.blockName ?? "BLOCK"} · ${block.units?.length ?? 0} UNITS',
                            style: GoogleFonts.outfit(
                              color: const Color.fromRGBO(0, 0, 0, 0.7),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: block.units?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          itemBuilder: (context, index) {
                            final unit = block.units![index];

                            final displayStatus =
                                unit.occupancyStatus != null &&
                                    unit.occupancyStatus!.isNotEmpty
                                ? (unit.occupancyStatus![0].toUpperCase() +
                                      unit.occupancyStatus!
                                          .substring(1)
                                          .toLowerCase())
                                : "Occupied";
                            return _unitCard(
                              unitNumber: unit.badge ?? unit.unitNumber ?? "",
                              apartmentName: unit.unitNumber ?? "Apartment",
                              blockName:
                                  unit.subtitle ??
                                  "${unit.block ?? ""} · ${unit.floor ?? ""}",
                              status: displayStatus,
                              owner: unit.propertyOwner ?? "N/A",
                              residents: unit.residents ?? "N/A",
                              propertyStatus: unit.propertyStatus ?? "Good",
                              inspectionDate: 'N/A',
                              image: unit.image,
                              id: unit.id.toString(),
                            );
                          },
                        ),
                        SizedBox(height: 6.h),
                      ],
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Something went wrong",
                          style: GoogleFonts.outfit(color: AppColors.heading),
                        ),
                        SizedBox(height: 8.h),
                        ElevatedButton(
                          onPressed: () => ref.refresh(
                            getPropertyUnitListProvider(filterParams),
                          ),
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  );
                },
                loading: () => Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: CircularProgressIndicator(color: AppColors.heading),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: const Color(0xFF000000),
                    width: 1.w,
                  ),
                ),
                child: Center(
                  child: Text(
                    disclaimer ??
                        "Showing registered properties and units assigned to this association. Select any unit to view its details.",
                    style: GoogleFonts.outfit(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(0, 0, 0, 0.6),
                      letterSpacing: -0.2,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem({required String value, required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.2,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.outfit(
            color: const Color.fromRGBO(255, 255, 255, 0.6),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  Widget _unitCard({
    required String unitNumber,
    required String apartmentName,
    required String blockName,
    required String status,
    required String owner,
    required String residents,
    required String propertyStatus,
    required String inspectionDate,
    String? image,
    required String id,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      width: double.infinity,
      height: 220.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.black,
        border: Border.all(color: const Color(0xFF17221D), width: 1.w),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: (image != null && image.isNotEmpty)
                  ? Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/associationImage/propertyunitimage.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      'assets/associationImage/propertyunitimage.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.98),
                    Colors.black.withValues(alpha: 0.82),
                    Colors.black.withValues(alpha: 0.48),
                    Colors.black.withValues(alpha: 0.35),
                  ],
                  stops: const [0.0, 0.42, 0.75, 1.0],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Unit Number
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 6.h,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFEAD408),
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      child: Text(
                        unitNumber,
                        style: GoogleFonts.outfit(
                          color: const Color(0xFFEAD408),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apartmentName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.05,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            blockName,
                            style: GoogleFonts.outfit(
                              color: const Color.fromRGBO(255, 255, 255, 0.8),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      width: 84.w,
                      height: 24.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFEAD408),
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.outfit(
                          color: const Color(0xFFEAD408),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PROPERTY OWNER",
                            style: GoogleFonts.outfit(
                              color: const Color.fromRGBO(255, 255, 255, 0.5),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            owner,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              height: 1,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "RESIDENT",
                            style: GoogleFonts.outfit(
                              color: const Color.fromRGBO(255, 255, 255, 0.5),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            residents,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              height: 1,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PROPERTY STATUS",
                            style: GoogleFonts.outfit(
                              color: const Color.fromRGBO(255, 255, 255, 0.5),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            propertyStatus,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              height: 1,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            AssociationPropertyUnitDetails(id: id),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Report',
                        style: GoogleFonts.outfit(
                          color: const Color(0xFFEAD408),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '→',
                        style: GoogleFonts.outfit(
                          color: const Color(0xFFEAD408),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
