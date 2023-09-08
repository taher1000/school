import 'package:dartz/dartz.dart';
import '../entities/group_section.dart';

import '../../../../core/network/failure.dart';

abstract class ISectionGroupRepository {
  Future<Either<Failure, List<SectionGroup>>> getSectionGroup(int classYear);
}
