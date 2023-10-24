part of 'reader_bloc.dart';

class ReaderState extends Equatable {
  final RequestStatus status;
  final List<String> content;
  final bool hasReachedMax;
  final String errorMessage;

  const ReaderState({
    this.content = const [],
    this.status = RequestStatus.loading,
    this.hasReachedMax = false,
    this.errorMessage = '',
  });
  ReaderState copyWith({
    RequestStatus? status,
    List<String>? content,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return ReaderState(
      content: content ?? this.content,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        content,
        hasReachedMax,
        errorMessage,
      ];
}
