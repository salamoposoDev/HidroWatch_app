import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cctv_iot/utils/database_path.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'get_cam1_state.dart';

class GetCam1Cubit extends Cubit<GetCam1State> {
  final dbref = FirebaseDatabase.instance.ref();
  GetCam1Cubit() : super(GetCam1Initial());

  void getCam1() {
    try {
      dbref.child('$camAtas/lastImage').onValue.listen((event) {
        if (event.snapshot.exists) {
          final jsonData = jsonEncode(event.snapshot.value);
          Map<String, dynamic> dataMap = jsonDecode(jsonData);
          emit(GetCam1Data(lastImage: dataMap));
        } else {
          emit(GetCam1NoData());
        }
      });
    } catch (e) {
      emit(GetCam1Error(error: e.toString()));
    }
  }
}
