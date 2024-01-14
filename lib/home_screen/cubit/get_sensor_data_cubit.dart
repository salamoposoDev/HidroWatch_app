import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'get_sensor_data_state.dart';

class GetSensorDataCubit extends Cubit<GetSensorDataState> {
  final dbref = FirebaseDatabase.instance.ref();
  GetSensorDataCubit() : super(GetSensorDataInitial());

  void getData({String? path}) {
    try {
      dbref.child('$path/sensors').onValue.listen((event) {
        if (event.snapshot.exists) {
          final jsonData = jsonEncode(event.snapshot.value);
          Map<String, dynamic> dataMap = jsonDecode(jsonData);
          emit(GetSensorDataHasData(sensors: dataMap));
        } else {
          emit(GetSensorDataEmpty());
        }
      });
    } catch (e) {
      emit(GetSensorDataError(error: e.toString()));
    }
  }
}
