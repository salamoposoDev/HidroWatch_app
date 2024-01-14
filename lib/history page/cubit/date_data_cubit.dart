import 'package:flutter_bloc/flutter_bloc.dart';
part 'date_data_state.dart';

class DateDataCubit extends Cubit<DateDataState> {
  DateDataCubit() : super(DateDataInitial());

  void getMonthlyDateRange(DateTime selectedDate) {
    DateTime awalBulanIni = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime akhirBulanIni =
        DateTime(awalBulanIni.year, awalBulanIni.month + 1, 0);
    int awalBulanIniTimestamp = (awalBulanIni.millisecondsSinceEpoch ~/ 1000);
    int akhirBulanIniTimestamp = (akhirBulanIni.millisecondsSinceEpoch ~/ 1000);

    // final awal =
    //     DateTime.fromMillisecondsSinceEpoch(awalBulanIniTimestamp * 1000);
    // final akhir =
    //     DateTime.fromMillisecondsSinceEpoch(akhirBulanIniTimestamp * 1000);
    // log('awal bulan = $awal, akhir bulan $akhir');
    emit(DateDataCubitData(awalBulanIniTimestamp, akhirBulanIniTimestamp));
  }

  void getDailyDateRange(DateTime selectedDate) {
    DateTime startOfDay =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    DateTime endOfDay = startOfDay.add(const Duration(days: 1));
    int awalHariIniTimestamp = (startOfDay.millisecondsSinceEpoch ~/ 1000);
    int akhirHariIniTimestamp = (endOfDay.millisecondsSinceEpoch ~/ 1000);
    // final awal =
    //     DateTime.fromMillisecondsSinceEpoch(awalHariIniTimestamp * 1000);
    // final akhir =
    //     DateTime.fromMillisecondsSinceEpoch(akhirHariIniTimestamp * 1000);
    // log('awal hari = $awal, akhir hari $akhir');
    emit(DateDataCubitData(awalHariIniTimestamp, akhirHariIniTimestamp));
  }

  void getWeeklyDateRange(DateTime selectedDate) {
    DateTime awalMingguIni = selectedDate;
    while (awalMingguIni.weekday != DateTime.monday) {
      awalMingguIni = awalMingguIni.subtract(const Duration(days: 1));
    }
    // ignore: prefer_const_constructors
    DateTime akhirMingguIni = awalMingguIni.add(Duration(days: 6));

    int awalMingguIniTimestamp = (awalMingguIni.millisecondsSinceEpoch ~/ 1000);
    int akhirMingguIniTimestamp =
        (akhirMingguIni.millisecondsSinceEpoch ~/ 1000);

    // final awal =
    //     DateTime.fromMillisecondsSinceEpoch(awalMingguIniTimestamp * 1000);
    // final akhir =
    //     DateTime.fromMillisecondsSinceEpoch(akhirMingguIniTimestamp * 1000);
    // log('awal minggu = $awal, akhir minggu $akhir');

    emit(DateDataCubitData(awalMingguIniTimestamp, akhirMingguIniTimestamp));
  }

  void getYearlyDateRange(DateTime selectedDate) {
    DateTime awalTahunIni = DateTime(selectedDate.year, 1, 1);
    DateTime akhirTahunIni = DateTime(selectedDate.year, 12, 31);
    int awalTahunIniTimestamp = (awalTahunIni.millisecondsSinceEpoch ~/ 1000);
    int akhirTahunIniTimestamp = (akhirTahunIni.millisecondsSinceEpoch ~/ 1000);

    // final awal =
    //     DateTime.fromMillisecondsSinceEpoch(awalTahunIniTimestamp * 1000);
    // final akhir =
    //     DateTime.fromMillisecondsSinceEpoch(akhirTahunIniTimestamp * 1000);
    // log('awal tahun = $awal, akhir tahun $akhir');

    emit(DateDataCubitData(awalTahunIniTimestamp, akhirTahunIniTimestamp));
  }
}
