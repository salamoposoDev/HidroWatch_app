import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.camNumber,
    required this.onTap,
    required this.name,
    required this.time,
    required this.image,
    required this.shoot,
    required this.onCapture,
  });
  final int camNumber;
  final String name;
  final String time;
  final VoidCallback onTap;
  final String image;
  final VoidCallback shoot;
  final int onCapture;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.w / 10.h,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(2, 2),
                blurRadius: 2,
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: image.isNotEmpty
                      ? Image.network(
                          image,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey.shade200,
                        ),
                ),
              ),
              Center(
                child:
                    onCapture == 1 ? CircularProgressIndicator() : Container(),
              ),
              blurWidget(camNumber: camNumber, onTap: onTap),
            ],
          )),
    );
  }

  Positioned blurWidget({int? camNumber, VoidCallback? onTap}) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$name',
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, color: Colors.white),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: onCapture == 0 ? shoot : null,
                      child: Container(
                          padding: EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "lib/icons/camera.svg",
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          )),
                    ),
                    ElevatedButton(
                      onPressed: onTap,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Atur radius sudut di sini
                        ),
                        side: const BorderSide(
                            color: Colors.white,
                            width: 1), // Atur warna border di sini
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Detail',
                            style: GoogleFonts.roboto(
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 18.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
