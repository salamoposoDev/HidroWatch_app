import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'get_schedule_state.dart';

class GetScheduleCubit extends Cubit<GetScheduleState> {
  final dbref = FirebaseDatabase.instance.ref();
  GetScheduleCubit() : super(GetScheduleInitial());

  void getSchedule({String? path}) {
    try {
      dbref.child('$path/schedule').onValue.listen((event) {
        if (event.snapshot.exists) {
          final jsonData = jsonEncode(event.snapshot.value);
          Map<String, dynamic> mapData = jsonDecode(jsonData);

          print(mapData);

          emit(GetScheduleHasData(schedule: mapData));
        } else {
          emit(GetScheduleEmpty());
        }
      });
    } catch (e) {
      emit(GetScheduleError(error: e.toString()));
    }
  }
}
