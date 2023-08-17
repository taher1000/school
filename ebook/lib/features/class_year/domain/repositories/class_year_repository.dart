import 'package:dartz/dartz.dart';
import '../entities/class_year.dart';

import '../../../../core/network/failure.dart';

abstract class IClassYearRepository {
  Future<Either<Failure, List<ClassYear>>> getClassYear();
}
