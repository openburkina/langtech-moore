// Events
import 'package:bloc/bloc.dart';

abstract class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}

class DecrementCounterEvent extends CounterEvent {}

// State
abstract class CounterState {
  final int counter;

  const CounterState({
    required this.counter,
  });
}

class CounterSuccessState extends CounterState {
  CounterSuccessState({required super.counter});
}

class CounterErrorState extends CounterState {
  final String errorMessage;

  CounterErrorState({
    required int counter,
    required this.errorMessage,
  }) : super(
          counter: counter,
        );
}

class CounterInitialState extends CounterState {
  CounterInitialState() : super(counter: 0);
}

// Bloc
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitialState()) {
    // Increment part
    on((IncrementCounterEvent event, emit) {
      if (state.counter < 10) {
        emit(
          CounterSuccessState(
            counter: state.counter + 1,
          ),
        );
      } else {
        emit(
          CounterErrorState(
            counter: state.counter,
            errorMessage: "Counter value can not be more than 10 !",
          ),
        );
      }
    });

    // Decrement part
    on((DecrementCounterEvent event, emit) {
      if (state.counter > 0) {
        emit(
          CounterSuccessState(
            counter: state.counter - 1,
          ),
        );
      } else {
        emit(
          CounterErrorState(
            counter: state.counter,
            errorMessage: "Counter value can not be less than 1 !",
          ),
        );
      }
    });
  }
}
