import 'package:bloc/bloc.dart';
import 'package:cctv_iot/utils/database_path.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'set_schedule_state.dart';

class SetScheduleCubit extends Cubit<SetScheduleState> {
  final cam1Ref = FirebaseDatabase.instance.ref(camAtas);
  final cam2Ref = FirebaseDatabase.instance.ref(camTengah);
  final cam3Ref = FirebaseDatabase.instance.ref(camBawah);
  SetScheduleCubit() : super(SetScheduleInitial());

  void setSchedule({String? key, String? schedule}) {
    if (key != null && schedule != null) {
      try {
        cam1Ref.child('schedule/$key').set(schedule);
        cam2Ref.child('schedule/$key').set(schedule);
        cam3Ref.child('schedule/$key').set(schedule);

        cam1Ref.child('restart').set(true);
        cam2Ref.child('restart').set(true);
        cam3Ref.child('restart').set(true);
      } catch (e) {
        print(e);
      }
    }
  }
}
