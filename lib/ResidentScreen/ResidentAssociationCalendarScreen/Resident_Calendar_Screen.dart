import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:property_association_or_resident/Core/Constant/appColor.dart';

class ResidentCalendarScreen extends StatefulWidget {
  const ResidentCalendarScreen({super.key});

  @override
  State<ResidentCalendarScreen> createState() => _ResidentCalendarScreenState();
}

class _ResidentCalendarScreenState extends State<ResidentCalendarScreen> {
  DateTime currentMonth = DateTime.now();
  DateTime selectedDate = DateTime.now();

  final Set<int> eventDates = {3, 9, 18};

  final List<String> weekDays = [
    "SUN",
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT",
  ];

  void previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  String get monthName {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return months[currentMonth.month - 1];
  }

  List<DateTime> getCalendarDates() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);

    final lastDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    );

    final startOffset = firstDayOfMonth.weekday % 7;

    final List<DateTime> dates = [];

    // Previous month's dates
    for (int i = startOffset - 1; i >= 0; i--) {
      dates.add(DateTime(currentMonth.year, currentMonth.month, -i));
    }

    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      dates.add(DateTime(currentMonth.year, currentMonth.month, i));
    }
    int nextDay = 1;

    while (dates.length < 35) {
      dates.add(DateTime(currentMonth.year, currentMonth.month + 1, nextDay++));
    }

    return dates;
  }

  bool isCurrentMonth(DateTime date) {
    return date.month == currentMonth.month && date.year == currentMonth.year;
  }

  bool isSelected(DateTime date) {
    return date.year == selectedDate.year &&
        date.month == selectedDate.month &&
        date.day == selectedDate.day;
  }

  bool hasEvent(DateTime date) {
    return isCurrentMonth(date) && eventDates.contains(date.day);
  }

  @override
  Widget build(BuildContext context) {
    final dates = getCalendarDates();
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
                    "Association Calendar",
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292832),
                      letterSpacing: -0.64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "View upcoming community events",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "Calender",
                style: GoogleFonts.outfit(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 45.w,
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffEAF6F3),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            size: 23.sp,
                            color: const Color(0xff007C6B),
                          ),
                        ),

                        SizedBox(width: 13.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$monthName ${currentMonth.year}",
                                style: GoogleFonts.inter(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff101C16),
                                ),
                              ),

                              SizedBox(height: 3.h),

                              Text(
                                "Community Calendar",
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff777777),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: previousMonth,
                          child: Container(
                            height: 44.w,
                            width: 44.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffF8FAF9),
                              border: Border.all(
                                color: const Color(0xffE5EAE7),
                              ),
                              borderRadius: BorderRadius.circular(11.r),
                            ),
                            child: Icon(
                              Icons.chevron_left,
                              size: 28.sp,
                              color: const Color(0xff49635C),
                            ),
                          ),
                        ),

                        SizedBox(width: 7.w),
                        GestureDetector(
                          onTap: nextMonth,
                          child: Container(
                            height: 44.w,
                            width: 44.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffF8FAF9),
                              border: Border.all(
                                color: const Color(0xffE5EAE7),
                              ),
                              borderRadius: BorderRadius.circular(11.r),
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              size: 28.sp,
                              color: const Color(0xff49635C),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),
                    Row(
                      children: weekDays.map((day) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff8A9692),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 8.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dates.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 2,
                            childAspectRatio: 0.95,
                          ),
                      itemBuilder: (context, index) {
                        final date = dates[index];

                        final bool selected = isSelected(date);
                        final bool current = isCurrentMonth(date);
                        final bool event = hasEvent(date);

                        return GestureDetector(
                          onTap: current
                              ? () {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                }
                              : null,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xff007665)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${date.day}",
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: selected
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: !current
                                        ? const Color(0xffC7CDCA)
                                        : selected
                                        ? Colors.white
                                        : event
                                        ? const Color(0xff007665)
                                        : const Color(0xff4D5552),
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                if (selected)
                                  Container(
                                    width: 5.w,
                                    height: 5.w,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                else
                                  SizedBox(width: 5.w, height: 5.w),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Upcoming Events",
                style: GoogleFonts.outfit(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heading,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 16.h),
              eventCard(
                title: "Association Committee Meeting",
                date: "03 September 2026",
                time: "06:30 PM",
              ),
              SizedBox(height: 16.h),
              eventCard(
                title: "Community Maintenance Day",
                date: "09 September 2026",
                time: "09:00 AM",
              ),
              SizedBox(height: 16.h),
              eventCard(
                title: "Residents Community Gathering",
                date: "18 September 2026",
                time: "07:00 PM",
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget eventCard({
    required String title,
    required String date,
    required String time,
  }) {
    Widget info(IconData icon, String text) {
      return Row(
        children: [
          Icon(icon, size: 17.sp, color: const Color(0xff101C16)),
          SizedBox(width: 11.w),
          Text(
            text,
            style: GoogleFonts.outfit(
              fontSize: 15.sp,
              color: const Color(0xff101C16),
              fontWeight: FontWeight.w500,
              letterSpacing: -0.2,
            ),
          ),
        ],
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff969696)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(7.w),
                decoration: const BoxDecoration(
                  color: Color(0xffEBD9A8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.groups_outlined,
                  size: 18.sp,
                  color: const Color(0xffA77900),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),
          Divider(height: 1, color: const Color(0xff8D8D8D)),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            child: info(Icons.calendar_today_outlined, date),
          ),

          Divider(height: 1, color: const Color(0xff8D8D8D)),

          Padding(
            padding: EdgeInsets.only(top: 13.h),
            child: info(Icons.access_time_outlined, time),
          ),
        ],
      ),
    );
  }
}
