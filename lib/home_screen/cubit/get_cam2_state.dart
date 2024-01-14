part of 'get_cam2_cubit.dart';

sealed class GetCam2State {}

final class GetCam2Initial extends GetCam2State {}

final class GetCam2NoData extends GetCam2State {}

final class GetCam2Error extends GetCam2State {
  final String error;

  GetCam2Error({required this.error});
}

final class GetCam2Data extends GetCam2State {
  final Map<String, dynamic> lastImage;

  GetCam2Data({required this.lastImage});
}
