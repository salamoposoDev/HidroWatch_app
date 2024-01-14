part of 'date_data_cubit.dart';

sealed class DateDataState {}

final class DateDataInitial extends DateDataState {}

class DateDataCubitData extends DateDataState {
  final int awalTimestamp;
  final int akhirTimestamp;

  DateDataCubitData(this.awalTimestamp, this.akhirTimestamp);
}
