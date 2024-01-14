import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cctv_iot/utils/database_path.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'get_cam3_state.dart';

class GetCam3Cubit extends Cubit<GetCam3State> {
  final dbref = FirebaseDatabase.instance.ref();
  GetCam3Cubit() : super(GetCam3Initial());

  void getCam3() {
    try {
      dbref.child('$camBawah/lastImage').onValue.listen((event) {
        if (event.snapshot.exists) {
          final jsonData = jsonEncode(event.snapshot.value);
          Map<String, dynamic> dataMap = jsonDecode(jsonData);
          emit(GetCam3Data(lastImage: dataMap));
        } else {
          emit(GetCam3NoData());
        }
      });
    } catch (e) {
      emit(GetCam3Error(error: e.toString()));
    }
  }
}
