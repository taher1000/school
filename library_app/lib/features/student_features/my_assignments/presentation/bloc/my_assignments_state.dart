part of 'my_assignments_bloc.dart';

class MyAssignmentsState extends Equatable {
  final StudentAssignmentSummaryResponsePage? books;

  const MyAssignmentsState({
    this.books,
  });
  MyAssignmentsState copyWith({StudentAssignmentSummaryResponsePage? books}) {
    return MyAssignmentsState(
      books: books ?? this.books,
    );
  }

  @override
  List<Object> get props => [];
}

class MyAssignmentsInitial extends MyAssignmentsState {}

class GetMyAssignments extends MyAssignmentsState {}

class GetMyAssignmentsLoading extends MyAssignmentsState {}

class GetMyAssignmentsError extends MyAssignmentsState {
  final String message;
  const GetMyAssignmentsError({required this.message});
}

class GetMyAssignmentsEmpty extends MyAssignmentsState {}

class GetMyAssignmentsLoaded extends MyAssignmentsState {
  GetMyAssignmentsLoaded(StudentAssignmentSummaryResponsePage books)
      : super(books: books);
}
