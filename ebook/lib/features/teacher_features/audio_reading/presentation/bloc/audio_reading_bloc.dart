import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audio_reading_event.dart';
part 'audio_reading_state.dart';

class AudioReadingBloc extends Bloc<AudioReadingEvent, AudioReadingState> {
  AudioReadingBloc() : super(AudioReadingInitial()) {
    on<AudioReadingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
