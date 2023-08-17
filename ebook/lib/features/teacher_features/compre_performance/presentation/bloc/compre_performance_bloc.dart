import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'compre_performance_event.dart';
part 'compre_performance_state.dart';

class ComprePerformanceBloc extends Bloc<ComprePerformanceEvent, ComprePerformanceState> {
  ComprePerformanceBloc() : super(ComprePerformanceInitial()) {
    on<ComprePerformanceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
