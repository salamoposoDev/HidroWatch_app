import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'check_online_state.dart';

class CheckOnlineCubit extends Cubit<String> {
  CheckOnlineCubit() : super('offline');

  void checkOnline(int timestamp, int toleranceSeconds) {
    int currentTimestamp = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    });

    // Bandingkan dengan toleransi waktu
    bool isOnline = currentTimestamp - timestamp <= toleranceSeconds;

    if (isOnline) {
      print('online');
      emit('Online');
    } else {
      print('offline');
      emit('Offline');
    }
  }
}
