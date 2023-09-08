part of 'audio_reading_bloc.dart';

abstract class AudioReadingState extends Equatable {
  const AudioReadingState();  

  @override
  List<Object> get props => [];
}
class AudioReadingInitial extends AudioReadingState {}
