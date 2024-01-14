part of 'time_cubit.dart';

@immutable
sealed class TimeState {}

final class TimeInitial extends TimeState {}

final class TimeData extends TimeState {
  final Map<String, dynamic> time;

  TimeData({required this.time});
}
