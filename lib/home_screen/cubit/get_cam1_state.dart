part of 'get_cam1_cubit.dart';

@immutable
sealed class GetCam1State {}

final class GetCam1Initial extends GetCam1State {}

final class GetCam1NoData extends GetCam1State {}

final class GetCam1Error extends GetCam1State {
  final String error;

  GetCam1Error({required this.error});
}

final class GetCam1Data extends GetCam1State {
  final Map<String, dynamic> lastImage;

  GetCam1Data({required this.lastImage});
}
