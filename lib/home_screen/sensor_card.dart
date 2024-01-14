import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SensorCard extends StatelessWidget {
  const SensorCard(
      {super.key, required this.formatedDate, this.temp, this.hum});
  final String formatedDate;
  final dynamic temp;
  final dynamic hum;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset('lib/icons/cloud_icon.png'),
                Text(
                  'Good morning',
                  style: GoogleFonts.poppins(fontSize: 16.sp),
                ),
              ],
            ),
            const VerticalDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatedDate.toString(),
                  style: GoogleFonts.poppins(fontSize: 16.sp),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$temp°C',
                        style: GoogleFonts.roboto(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 60.w),
                      Text(
                        '$hum%',
                        style: GoogleFonts.roboto(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Temperature',
                          style: GoogleFonts.poppins(fontSize: 16.sp),
                        ),
                        SizedBox(width: 40.h),
                        Text(
                          'Humidity',
                          style: GoogleFonts.poppins(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
