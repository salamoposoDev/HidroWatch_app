import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'history_list_state.dart';

class HistoryListCubit extends Cubit<HistoryListState> {
  final dbref = FirebaseDatabase.instance.ref();
  HistoryListCubit() : super(HistoryListLoading());

  // GET DATA DAYLY
  void getData({String? path, int? startTime, int? endTime}) async {
    if (path != null && startTime != null && endTime != null) {
      try {
        // print('get data');
        final snapshot = await dbref
            .child('$path/images')
            .orderByChild('time')
            .startAt(startTime)
            .endAt(endTime)
            .once();
        if (snapshot.snapshot.exists) {
          final jsonData = json.encode(snapshot.snapshot.value);
          // print('json data $jsonData');
          List<Map<String, dynamic>> historyList = [];
          Map<String, dynamic> dataMap = json.decode(jsonData);

          dataMap.forEach((key, value) {
            final image = value['imageUrl'];
            final time = value['time'] as int;
            historyList.add({
              'image': image,
              'time': time,
            });
          });
          // print('history list = $historyList');

          historyList.sort((a, b) {
            // Extract the "time" values from the maps and compare them.
            final int timeA = a['time'];
            final int timeB = b['time'];
            // To sort in ascending order, use the following:
            // return timeA.compareTo(timeB);
            // To sort in descending order, use the following:
            return timeB.compareTo(timeA);
          });

          emit(HistoryListHasData(historyList: historyList));
        } else {
          emit(HistoryListNoData());
        }
      } catch (e) {
        emit(HistoryListError(error: e.toString()));
      }
    } else {
      print('ada yang kosong');
    }
  }

  // GET DATA DAYLY
  void getWeekly({String? path, int? startTime, int? endTime}) async {
    if (path != null && startTime != null && endTime != null) {
      try {
        // print('get data');
        final snapshot = await dbref
            .child('$path/images')
            .orderByChild('time')
            .startAt(startTime)
            .endAt(endTime)
            .once();
        if (snapshot.snapshot.exists) {
          final jsonData = json.encode(snapshot.snapshot.value);
          // print('json data $jsonData');
          List<Map<String, dynamic>> historyList = [];
          Map<String, dynamic> dataMap = json.decode(jsonData);

          dataMap.forEach((key, value) {
            final image = value['imageUrl'];
            final time = value['time'] as int;
            historyList.add({
              'image': image,
              'time': time,
            });
          });
          // print('history list = $historyList');

          historyList.sort((a, b) {
            // Extract the "time" values from the maps and compare them.
            final int timeA = a['time'];
            final int timeB = b['time'];
            // To sort in ascending order, use the following:
            // return timeA.compareTo(timeB);
            // To sort in descending order, use the following:
            return timeB.compareTo(timeA);
          });

          emit(HistoryListHasData(historyList: historyList));
        } else {
          emit(HistoryListNoData());
        }
      } catch (e) {
        emit(HistoryListError(error: e.toString()));
      }
    } else {
      print('ada yang kosong');
    }
  }
}
