import 'package:cctv_iot/history%20page/cubit/date_data_cubit.dart';
import 'package:cctv_iot/history%20page/cubit/history_list_cubit.dart';
import 'package:cctv_iot/history%20page/widgets/image_grid.dart';
import 'package:cctv_iot/history%20page/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.path, required this.camName});
  final String path;
  final String camName;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateDataCubit dateDataCubit = DateDataCubit();
  HistoryListCubit historyListCubit = HistoryListCubit();
  DateTime now = DateTime.now();
  String selectedSort = 'Harian';
  int selectedIndex = 0;
  final textFilter = ['Harian', 'Mingguan', 'Bulanan', 'Tahunan'];

  @override
  void initState() {
    dateDataCubit.getDailyDateRange(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('path ${widget.path}');

    // final reff = FirebaseDatabase.instance.ref('${widget.path}/images');
    // reff.orderByChild('time').onValue.listen((event) {
    //   if (event.snapshot.exists) {
    //     final jsonData = jsonEncode(event.snapshot.value);
    //     print(jsonData);
    //   }
    // });
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => dateDataCubit),
        BlocProvider(create: (context) => historyListCubit),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: Text(
            widget.camName,
            style: GoogleFonts.poppins(color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabbarList(
                  onChange: (String value) {
                    print(value);
                    selectedSort = value;
                    switch (value) {
                      case 'Harian':
                        dateDataCubit.getDailyDateRange(now);
                        break;
                      case 'Mingguan':
                        dateDataCubit.getWeeklyDateRange(now);
                        break;
                      case 'Bulanan':
                        dateDataCubit.getMonthlyDateRange(now);
                        break;
                      case 'Tahunan':
                        dateDataCubit.getYearlyDateRange(now);
                        break;
                    }
                  },
                ),
                SizedBox(height: 16.h),
                BlocBuilder<DateDataCubit, DateDataState>(
                  builder: (context, dateState) {
                    if (dateState is DateDataCubitData) {
                      return BlocBuilder<HistoryListCubit, HistoryListState>(
                        bloc: setSortHistory(
                          path: widget.path,
                          selectedSort: selectedSort,
                          timeAwal: dateState.awalTimestamp,
                          timeAkhir: dateState.akhirTimestamp,
                        ),
                        builder: (context, state) {
                          if (state is HistoryListLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is HistoryListError) {
                            return Center(
                              child: Text('error ${state.error}'),
                            );
                          }
                          if (state is HistoryListNoData) {
                            return const Center(
                              child: Text('No Data'),
                            );
                          }
                          if (state is HistoryListHasData) {
                            // print(state.historyList);
                            return ImageGrid(historyList: state.historyList);
                          }
                          return Container();
                        },
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  HistoryListCubit setSortHistory(
      {String? selectedSort, String? path, int? timeAwal, int? timeAkhir}) {
    if (selectedSort == 'Harian') {
      return HistoryListCubit()
        ..getData(
          path: path,
          startTime: timeAwal,
          endTime: timeAkhir,
        );
    }
    if (selectedSort == 'Mingguan') {
      print("awal: $timeAwal");
      return HistoryListCubit()
        ..getData(
          path: path,
          startTime: timeAwal,
          endTime: timeAkhir,
        );
    }

    if (selectedSort == 'Bulanan') {
      print("awalbula: $timeAwal");
      return HistoryListCubit()
        ..getData(
          path: path,
          startTime: timeAwal,
          endTime: timeAkhir,
        );
    }
    if (selectedSort == 'Tahunan') {
      print("awal tahun: $timeAwal");
      return HistoryListCubit()
        ..getData(
          path: path,
          startTime: timeAwal,
          endTime: timeAkhir,
        );
    }
    return HistoryListCubit()..getData();
  }
}
