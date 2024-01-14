part of 'history_list_cubit.dart';

@immutable
sealed class HistoryListState {}

final class HistoryListLoading extends HistoryListState {}

final class HistoryListError extends HistoryListState {
  final String error;

  HistoryListError({required this.error});
}

final class HistoryListNoData extends HistoryListState {}

final class HistoryListHasData extends HistoryListState {
  final List<Map<String, dynamic>> historyList;

  HistoryListHasData({required this.historyList});
}
