part of 'on_capture_cubit.dart';

@immutable
sealed class OnCaptureState {}

final class OnCaptureInitial extends OnCaptureState {}

final class OnCaptureError extends OnCaptureState {
  final String error;

  OnCaptureError({required this.error});
}

final class OnCaptureHasData extends OnCaptureState {
  final int capture;

  OnCaptureHasData({required this.capture});
}

final class OnCaptureEmpty extends OnCaptureState {}
