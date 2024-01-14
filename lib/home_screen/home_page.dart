import 'dart:math';

import 'package:cctv_iot/history%20page/history_page.dart';
import 'package:cctv_iot/home_screen/cubit/check_device_status_cubit.dart';
import 'package:cctv_iot/home_screen/cubit/check_online_cubit.dart';
import 'package:cctv_iot/home_screen/cubit/get_cam1_cubit.dart';
import 'package:cctv_iot/home_screen/cubit/get_cam2_cubit.dart';
import 'package:cctv_iot/home_screen/cubit/get_cam3_cubit.dart';
import 'package:cctv_iot/home_screen/cubit/get_schedule_cubit.dart';
import 'package:cctv_iot/home_screen/cubit/get_sensor_data_cubit.dart';
import 'package:cctv_iot/home_screen/cubit/on_capture_cubit.dart';
import 'package:cctv_iot/home_screen/cubit/set_schedule_cubit.dart';
import 'package:cctv_iot/home_screen/cubit/time_cubit.dart';
import 'package:cctv_iot/home_screen/schedule_dialog.dart';
import 'package:cctv_iot/home_screen/sensor_card.dart';
import 'package:cctv_iot/utils/database_path.dart';
import 'package:cctv_iot/utils/format_timestamp.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'image_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatedDate = DateFormat('dd MMM yyy').format(now);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetCam1Cubit()..getCam1(),
        ),
        BlocProvider(
          create: (context) => GetCam2Cubit()..getCam2(),
        ),
        BlocProvider(
          create: (context) => GetCam3Cubit()..getCam3(),
        ),
        BlocProvider(
          create: (context) => TimeCubit()..getTime(),
        ),
        BlocProvider(
          create: (context) => GetScheduleCubit()..getSchedule(path: camAtas),
        ),
        BlocProvider(
          create: (context) =>
              GetSensorDataCubit()..getData(path: 'E0:5A:1B:4F:C1:24'),
        ),
        BlocProvider(
          create: (context) => OnCaptureCubit(),
        ),
        BlocProvider(
          create: (context) => CheckDeviceStatusCubit(),
        ),
        BlocProvider(
          create: (context) => CheckOnlineCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Mulya',
                            style: GoogleFonts.roboto(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Wecome to HydroWatch',
                            style: GoogleFonts.poppins(fontSize: 16.sp),
                          ),
                        ],
                      ),
                      // Container(
                      //   height: 50.h,
                      //   width: 50.h,
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue,
                      //     shape: BoxShape.circle,
                      //   ),
                      //   child: Image.asset(
                      //     'lib/icons/profile.jpeg',
                      //   ),
                      // ),
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'lib/icons/profile_rec.jpeg',
                            scale: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<GetSensorDataCubit, GetSensorDataState>(
                    builder: (context, sensor) {
                      if (sensor is GetSensorDataInitial) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (sensor is GetSensorDataEmpty) {
                        return Center(
                          child: Text('no data'),
                        );
                      }
                      if (sensor is GetSensorDataError) {
                        return Center(
                          child: Text('error'),
                        );
                      }
                      if (sensor is GetSensorDataHasData) {
                        int temp = 35 + Random().nextInt((35 + 1) - 30);
                        int hum = 70 + Random().nextInt((70 + 1) - 50);
                        return SensorCard(
                          formatedDate: formatedDate,
                          temp: temp,
                          hum: hum,
                        );
                      }
                      return Container();
                    },
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<TimeCubit, TimeState>(
                    builder: (context, time) {
                      if (time is TimeData) {
                        return Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Schedule',
                                    style: GoogleFonts.poppins(fontSize: 20.sp),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showCupertinoDialog(
                                          context: context,
                                          builder: (context) {
                                            return BlocProvider(
                                              create: (context) =>
                                                  SetScheduleCubit(),
                                              child: ScheduleDialog(),
                                            );
                                          });
                                    },
                                    child: Icon(Icons.edit_document),
                                  ),
                                ],
                              ),
                              Divider(),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // Icon(Icons.timelapse),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'h',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 30.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  '${time.time['hour']}:${time.time['minute']}',
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.grey[700],
                                                      fontSize: 60.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'm',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 30.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  's',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 30.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  '${time.time['second']}:${time.time['millisecond']}',
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.grey[700],
                                                      fontSize: 60.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'ms',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 30.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                    ),
                                    BlocBuilder<GetScheduleCubit,
                                        GetScheduleState>(
                                      builder: (context, schedule) {
                                        if (schedule is GetScheduleInitial) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (schedule is GetScheduleEmpty) {
                                          return Center(
                                            child: Text('no schedule'),
                                          );
                                        }
                                        if (schedule is GetScheduleError) {
                                          return Center(
                                            child:
                                                Text('error ${schedule.error}'),
                                          );
                                        }
                                        if (schedule is GetScheduleHasData) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: schedule.schedule.entries
                                                .map((entry) {
                                              return Row(
                                                children: [
                                                  Icon(Icons.alarm),
                                                  Gap(8),
                                                  Text(
                                                    '${entry.value}',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.grey[800],
                                                      fontSize: 28.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          );
                                        }
                                        return Container();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<GetCam1Cubit, GetCam1State>(
                    builder: (context, lastImage) {
                      if (lastImage is GetCam1Data) {
                        return BlocBuilder<CheckDeviceStatusCubit, String>(
                          bloc: CheckDeviceStatusCubit()..checkCam1(),
                          builder: (context, status) {
                            return BlocBuilder<OnCaptureCubit, int>(
                              bloc: OnCaptureCubit()..cam1Capture(),
                              builder: (context, capture) {
                                return ImageCard(
                                  camNumber: 1,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HistoryPage(
                                                path: camAtas,
                                                camName: 'Camera 1')));
                                  },
                                  name: 'Cam 1 $status',
                                  time: formatTimestamp(
                                      lastImage.lastImage['time']),
                                  image: lastImage.lastImage['imageUrl'],
                                  shoot: () {
                                    FirebaseDatabase.instance
                                        .ref("$camAtas/camera")
                                        .set(1);
                                  },
                                  onCapture: capture,
                                );
                              },
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                  Gap(8),
                  BlocBuilder<GetCam2Cubit, GetCam2State>(
                    builder: (context, lastImage) {
                      if (lastImage is GetCam2Data) {
                        print(lastImage.lastImage['imageUrl']);
                        return BlocBuilder<CheckDeviceStatusCubit, String>(
                          bloc: CheckDeviceStatusCubit()..checkCam2(),
                          builder: (context, status) {
                            return BlocBuilder<OnCaptureCubit, int>(
                              bloc: OnCaptureCubit()..cam2Capture(),
                              builder: (context, capture) {
                                return ImageCard(
                                  camNumber: 2,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HistoryPage(
                                                path: camTengah,
                                                camName: 'Camera 2')));
                                  },
                                  name: 'Cam 2 $status',
                                  time: formatTimestamp(
                                      lastImage.lastImage['time']),
                                  image: lastImage.lastImage['imageUrl'],
                                  shoot: () {
                                    FirebaseDatabase.instance
                                        .ref("$camTengah/camera")
                                        .set(1);
                                  },
                                  onCapture: capture,
                                );
                              },
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                  Gap(8),
                  BlocBuilder<GetCam3Cubit, GetCam3State>(
                    builder: (context, lastImage) {
                      if (lastImage is GetCam3Data) {
                        return BlocBuilder<CheckDeviceStatusCubit, String>(
                          bloc: CheckDeviceStatusCubit()..checkCam3(),
                          builder: (context, status) {
                            return BlocBuilder<OnCaptureCubit, int>(
                              bloc: OnCaptureCubit()..cam3Capture(),
                              builder: (context, capture) {
                                return ImageCard(
                                  camNumber: 3,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HistoryPage(
                                                path: camBawah,
                                                camName: 'Camera 3')));
                                  },
                                  name: 'Cam 3 $status',
                                  time: formatTimestamp(
                                      lastImage.lastImage['time']),
                                  image: lastImage.lastImage['imageUrl'],
                                  shoot: () {
                                    FirebaseDatabase.instance
                                        .ref("$camBawah/camera")
                                        .set(1);
                                  },
                                  onCapture: capture,
                                );
                              },
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
