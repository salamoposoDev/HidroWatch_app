import 'dart:async';

String checkDeviceOnlineStatus(int timestamp, int toleranceSeconds) {
  // Ambil timestamp saat ini
  int currentTimestamp = 0;
  Timer.periodic(Duration(seconds: 1), (timer) {
    currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  });

  // Bandingkan dengan toleransi waktu
  bool isOnline = currentTimestamp - timestamp <= toleranceSeconds;

  if (isOnline) {
    print('online');
    return 'online';
  } else {
    print('offline');
    return 'offline';
  }
}
