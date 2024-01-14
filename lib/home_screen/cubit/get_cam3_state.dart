part of 'get_cam3_cubit.dart';

sealed class GetCam3State {}

final class GetCam3Initial extends GetCam3State {}

final class GetCam3NoData extends GetCam3State {}

final class GetCam3Error extends GetCam3State {
  final String error;

  GetCam3Error({required this.error});
}

final class GetCam3Data extends GetCam3State {
  final Map<String, dynamic> lastImage;

  GetCam3Data({required this.lastImage});
}
