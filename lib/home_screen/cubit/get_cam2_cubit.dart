import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cctv_iot/utils/database_path.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'get_cam2_state.dart';

class GetCam2Cubit extends Cubit<GetCam2State> {
  final dbref = FirebaseDatabase.instance.ref();
  GetCam2Cubit() : super(GetCam2Initial());

  void getCam2() {
    try {
      dbref.child('$camTengah/lastImage').onValue.listen((event) {
        if (event.snapshot.exists) {
          final jsonData = jsonEncode(event.snapshot.value);
          Map<String, dynamic> dataMap = jsonDecode(jsonData);
          emit(GetCam2Data(lastImage: dataMap));
        } else {
          emit(GetCam2NoData());
        }
      });
    } catch (e) {
      emit(GetCam2Error(error: e.toString()));
    }
  }
}
