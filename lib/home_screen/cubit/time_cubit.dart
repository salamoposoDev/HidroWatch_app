import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(TimeInitial());

  void getTime() {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      String h = DateTime.now().hour.toString();
      String m = DateTime.now().minute.toString();
      String s = DateTime.now().second.toString();
      String ms = (DateTime.now().millisecond ~/ 10).toString().padLeft(2, '0');
      final time = {'hour': h, 'minute': m, 'second': s, 'millisecond': ms};
      emit(TimeData(time: time));
    });
  }
}
