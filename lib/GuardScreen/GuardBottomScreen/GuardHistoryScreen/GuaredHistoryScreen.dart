import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';
import 'package:property_association_or_resident/Core/data/model/ResponseModel/addGuardResModel.dart';
import 'package:property_association_or_resident/GuardScreen/GuardBottomScreen/GuardHistoryScreen/Provider/HistoryRecordsProvider.dart';
import 'package:property_association_or_resident/GuardScreen/GuardBottomScreen/GuardHistoryScreen/Provider/historyGuardProvider.dart';

class Guaredhistoryscreen extends StatefulWidget {
  const Guaredhistoryscreen({super.key});

  @override
  State<Guaredhistoryscreen> createState() => _GuaredhistoryscreenState();
}

class _GuaredhistoryscreenState extends State<Guaredhistoryscreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              SizedBox(width: 20.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "History & Communication",
                    style: GoogleFonts.outfit(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Visits, parcels & guard communication",
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(42, 41, 51, 0.65),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: const Color(0xffDDDDDD),
            //     borderRadius: BorderRadius.circular(10.r),
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(child: _tabButton(title: "History", index: 0)),

            //       Expanded(child: _tabButton(title: "Guards", index: 1)),
            //     ],
            //   ),
            // ),
            Container(
              height: 60.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: const Color(0xff0B211A),
                  borderRadius: BorderRadius.circular(10.r),
                ),

                dividerColor: Colors.transparent,
                labelPadding: EdgeInsets.zero,
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.heading,

                labelStyle: GoogleFonts.outfit(
                  fontSize: 17.sp,
                  letterSpacing: -0.2,
                  fontWeight: FontWeight.w500,
                ),

                unselectedLabelStyle: GoogleFonts.outfit(
                  fontSize: 17.sp,
                  letterSpacing: -0.2,
                  fontWeight: FontWeight.w600,
                ),

                tabs: [
                  Tab(text: "History"),
                  Tab(text: "Guards"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [HistoryTab(), GuardsTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _tabButton({required String title, required int index}) {
  //   final bool isSelected = selectedIndex == index;

  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         selectedIndex = index;
  //       });
  //     },
  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 200),
  //       height: 36.h,
  //       margin: const EdgeInsets.symmetric(horizontal: 11),
  //       decoration: BoxDecoration(
  //         color: isSelected ? const Color(0xff0B1C15) : Colors.transparent,
  //         borderRadius: BorderRadius.circular(10.r),
  //       ),
  //       alignment: Alignment.center,
  //       child: Text(
  //         title,
  //         style: TextStyle(
  //           fontSize: 17.sp,
  //           fontWeight: FontWeight.w500,
  //           letterSpacing: -0.2,
  //           color: isSelected ? Colors.white : const Color(0xff101C16),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class HistoryTab extends ConsumerStatefulWidget {
  const HistoryTab({super.key});

  @override
  ConsumerState<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends ConsumerState<HistoryTab> {
  int index = 0;
  void showExitRecordedPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.65),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 40.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45.w,
                  height: 45.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffD1F4DE),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 25.sp,
                    color: const Color(0xff16B866),
                  ),
                ),

                SizedBox(height: 12.h),
                Text(
                  'EXIT RECORDED',
                  style: GoogleFonts.outfit(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.heading,
                    letterSpacing: -0.2,
                  ),
                ),

                SizedBox(height: 8.h),
                Text(
                  'Visitor exit has been successfully recorded for future history and reporting.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.heading,
                    letterSpacing: -0.2,
                  ),
                ),

                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IN-TIME
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffEEEEEE),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'IN-TIME',
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff777777),
                              letterSpacing: -0.2,
                            ),
                          ),

                          SizedBox(height: 1.h),

                          Text(
                            '10:32 AM',
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.heading,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffEEEEEE),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'OUT-TIME',
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff777777),
                              letterSpacing: -0.2,
                            ),
                          ),

                          SizedBox(height: 1.h),

                          Text(
                            '9:55 AM',
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.heading,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.heading,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Done',
                      style: GoogleFonts.outfit(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
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

  @override
  Widget build(BuildContext context) {
    final historyRecords = ref.watch(historyRecordsProvider);

    // final records = historyRecords.valueOrNull?.data?.records;
    return historyRecords.when(
      data: (data) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: const Color(0xffE1E1E1),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 0;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: index == 0
                                ? const Color(0xffE7F8ED)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: index == 0
                                  ? Colors.black
                                  : const Color(0xffE1E1E1),
                              width: index == 0 ? 1.2 : 1,
                            ),
                          ),
                          child: Text(
                            "All",
                            style: GoogleFonts.outfit(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff101C16),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: index == 1
                                ? const Color(0xffE7F8ED)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: index == 1
                                  ? Colors.black
                                  : const Color(0xffE1E1E1),
                              width: index == 1 ? 1.2 : 1,
                            ),
                          ),
                          child: Text(
                            "Visitor",
                            style: GoogleFonts.outfit(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff101C16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 2;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: index == 2
                                ? const Color(0xffE7F8ED)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: index == 2
                                  ? Colors.black
                                  : const Color(0xffE1E1E1),
                              width: index == 2 ? 1.2 : 1,
                            ),
                          ),
                          child: Text(
                            "Parcel",
                            style: GoogleFonts.outfit(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff101C16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              ListView.builder(
                itemCount: data.data?.records?.length ?? 0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = data.data?.records?[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.network(
                                item?.avatarUrl ?? "",
                                height: 60.h,
                                width: 60.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 58.w,
                                    height: 58.w,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 30.sp,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 9.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    item?.visitorName ?? "",
                                    style: GoogleFonts.outfit(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.heading,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    item?.categoryLabel ?? "",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromRGBO(
                                        42,
                                        41,
                                        51,
                                        0.65,
                                      ),
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15.w),
                            Container(
                              // width: 80.w,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(17, 197, 80, 0.2),
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: Center(
                                child: Text(
                                  item?.badge ?? "",
                                  style: GoogleFonts.outfit(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff24B06A),
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: _visitInfoCard(
                                title: 'IN-TIME',
                                value: item?.inTime ?? "",
                              ),
                            ),

                            SizedBox(width: 22.w),

                            Expanded(
                              child: _visitInfoCard(
                                title: 'OUT-TIME',
                                value: item?.outTime ?? "",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: _visitInfoCard(
                                title: 'DATE',
                                value: item?.date ?? "",
                              ),
                            ),

                            SizedBox(width: 22.w),

                            Expanded(
                              child: _visitInfoCard(
                                title: 'APPROVAL',
                                value: item?.statusNote ?? "",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          height: 37.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              showExitRecordedPopup(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D1C16),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                            child: Text(
                              'MARK EXIT',
                              style: GoogleFonts.outfit(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
    );
  }

  Widget _visitInfoCard({required String title, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0E9),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFD8D6D0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF666666),
              letterSpacing: -0.2,
            ),
          ),

          SizedBox(height: 3.h),

          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.heading,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class GuardsTab extends ConsumerStatefulWidget {
  const GuardsTab({super.key});

  @override
  ConsumerState<GuardsTab> createState() => _GuardsTabState();
}

class _GuardsTabState extends ConsumerState<GuardsTab> {
  @override
  Widget build(BuildContext context) {
    final guard = ref.watch(historyGuardProvider);
    return guard.when(
      data: (data) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Guards on Duty",
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 16.h),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.data?.guards?.length,
                itemBuilder: (context, index) {
                  final guard = data.data?.guards?[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xffE1E1E1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            guard?.avatarUrl ?? "",
                            height: 40.h,
                            width: 40.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30.sp,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                guard?.name ?? "",
                                style: GoogleFonts.outfit(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.heading,
                                  letterSpacing: -0.2,
                                ),
                              ),

                              SizedBox(height: 2.h),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${guard?.post ?? ''}  ",
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff555555),
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                    TextSpan(
                                      text: guard?.status ?? '',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff555555),
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              color: const Color(0xff0B211A),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Icon(
                              Icons.phone_outlined,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),

                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              color: const Color(0xff0B211A),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
    );
  }
}
