part of 'get_schedule_cubit.dart';

@immutable
sealed class GetScheduleState {}

final class GetScheduleInitial extends GetScheduleState {}

final class GetScheduleError extends GetScheduleState {
  final String error;

  GetScheduleError({required this.error});
}

final class GetScheduleEmpty extends GetScheduleState {}

final class GetScheduleHasData extends GetScheduleState {
  final Map<String, dynamic> schedule;

  GetScheduleHasData({required this.schedule});
}
