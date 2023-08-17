part of 'group_section_cubit.dart';

sealed class SectionGroupState extends Equatable {
  const SectionGroupState();

  @override
  List<Object> get props => [];
}

final class SectionGroupInitial extends SectionGroupState {}

final class FetchSectionGroups extends SectionGroupState {}

final class GetSectionGroupsLoading extends SectionGroupState {}

final class GetSectionGroupsLoaded extends SectionGroupState {
  final List<SectionGroup> groupSections;

  const GetSectionGroupsLoaded(this.groupSections);

  @override
  List<Object> get props => [groupSections];
}

final class GetSectionGroupsError extends SectionGroupState {
  final String message;

  const GetSectionGroupsError(this.message);

  @override
  List<Object> get props => [message];
}
