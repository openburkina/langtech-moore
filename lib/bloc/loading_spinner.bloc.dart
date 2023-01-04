import 'package:bloc/bloc.dart';

// Actions
abstract class SpinnerEvent {}

class LoadingSpinnerEvent extends SpinnerEvent {}

// States
abstract class SpinnerState {
  final bool enableSpinner;
  const SpinnerState({
    required this.enableSpinner,
  });
}

class LoadingSpinnerState extends SpinnerState {
  LoadingSpinnerState({required super.enableSpinner});
}

class LoadingSpinnerInitialeState extends SpinnerState {
  LoadingSpinnerInitialeState() : super(enableSpinner: false);
}

// Bloc
class LoadingSpinnerBloc extends Bloc<SpinnerEvent, SpinnerState> {
  LoadingSpinnerBloc() : super(LoadingSpinnerInitialeState()) {
    on((LoadingSpinnerEvent event, emit) {
      emit(
        LoadingSpinnerState(
          enableSpinner: !state.enableSpinner,
        ),
      );
    });
  }
}
