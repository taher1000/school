import 'package:dartz/dartz.dart';
import '../entities/group_section.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/uscecase/usecase.dart';
import '../repositories/group_section_repository.dart';

class GetSectionGroupsUseCase
    extends UseCase<Either<Failure, List<SectionGroup>>, int> {
  final ISectionGroupRepository repository;
  GetSectionGroupsUseCase(this.repository);
  @override
  Future<Either<Failure, List<SectionGroup>>> call({int? p}) async {
    return await repository.getSectionGroup(p!);
  }
}
