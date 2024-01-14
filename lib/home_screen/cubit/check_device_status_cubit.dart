import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cctv_iot/utils/database_path.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
part 'check_device_status_state.dart';

class CheckDeviceStatusCubit extends Cubit<String> {
  final dbRef = FirebaseDatabase.instance.ref();
  CheckDeviceStatusCubit() : super('Offline');

  void checkCam1() {
    try {
      Timer.periodic(Duration(seconds: 10), (timer) {
        dbRef.child('$camAtas/timestamp').onValue.listen((event) {
          if (event.snapshot.exists) {
            final jsonData = jsonEncode(event.snapshot.value);
            int timestamp = jsonDecode(jsonData);
            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
            DateTime currentDateTime = DateTime.now();
            int toleranceSeconds = 10;
            int timeDifference =
                currentDateTime.difference(dateTime).inSeconds.abs();
            if (timeDifference <= toleranceSeconds) {
              emit('Online');
            } else {
              emit('Offline');
            }
          }
        });
      });
    } catch (e) {}
  }

  void checkCam2() {
    try {
      Timer.periodic(Duration(seconds: 10), (timer) {
        dbRef.child('$camTengah/timestamp').onValue.listen((event) {
          if (event.snapshot.exists) {
            final jsonData = jsonEncode(event.snapshot.value);
            int timestamp = jsonDecode(jsonData);
            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
            DateTime currentDateTime = DateTime.now();
            int toleranceSeconds = 10;
            int timeDifference =
                currentDateTime.difference(dateTime).inSeconds.abs();
            if (timeDifference <= toleranceSeconds) {
              emit('Online');
            } else {
              emit('Offline');
            }
          }
        });
      });
    } catch (e) {}
  }

  void checkCam3() {
    try {
      Timer.periodic(Duration(seconds: 1), (timer) {
        dbRef.child('$camBawah/timestamp').onValue.listen((event) {
          if (event.snapshot.exists) {
            final jsonData = jsonEncode(event.snapshot.value);
            int timestamp = jsonDecode(jsonData);
            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
            DateTime currentDateTime = DateTime.now();
            int toleranceSeconds = 10;
            int timeDifference =
                currentDateTime.difference(dateTime).inSeconds.abs();
            if (timeDifference <= toleranceSeconds) {
              emit('Online');
            } else {
              emit('Offline');
            }
          }
        });
      });
    } catch (e) {}
  }
}
