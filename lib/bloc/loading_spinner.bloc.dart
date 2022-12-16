// Actions
abstract class SpinnerEvent {}

class LoadingSpinnerEvent extends SpinnerEvent {
  final bool enableSpinner;

  LoadingSpinnerEvent({
    required this.enableSpinner,
  });
}
