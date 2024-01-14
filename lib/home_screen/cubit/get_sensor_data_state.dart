part of 'get_sensor_data_cubit.dart';

@immutable
sealed class GetSensorDataState {}

final class GetSensorDataInitial extends GetSensorDataState {}

final class GetSensorDataError extends GetSensorDataState {
  final String error;

  GetSensorDataError({required this.error});
}

final class GetSensorDataEmpty extends GetSensorDataState {}

final class GetSensorDataHasData extends GetSensorDataState {
  final Map<String, dynamic> sensors;

  GetSensorDataHasData({required this.sensors});
}
