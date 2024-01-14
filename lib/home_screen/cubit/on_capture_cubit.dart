import 'package:bloc/bloc.dart';
import 'package:cctv_iot/utils/database_path.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
part 'on_capture_state.dart';

class OnCaptureCubit extends Cubit<int> {
  final dbref = FirebaseDatabase.instance.ref();
  OnCaptureCubit() : super(0);

  void cam1Capture() {
    try {
      dbref.child('$camAtas/camera').onValue.listen((event) {
        if (event.snapshot.exists) {
          final capture = event.snapshot.value as int;
          print('data $capture');
          emit(capture);
        }
      });
    } catch (e) {}
  }

  void cam2Capture() {
    try {
      dbref.child('$camTengah/camera').onValue.listen((event) {
        if (event.snapshot.exists) {
          final capture = event.snapshot.value as int;
          emit(capture);
        }
      });
    } catch (e) {}
  }

  void cam3Capture() {
    try {
      dbref.child('$camBawah/camera').onValue.listen((event) {
        if (event.snapshot.exists) {
          final capture = event.snapshot.value as int;
          emit(capture);
        }
      });
    } catch (e) {}
  }
}
