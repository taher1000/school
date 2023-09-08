import 'package:dartz/dartz.dart';
import '../../../../core/params/no_params.dart';
import '../entities/class_year.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/uscecase/usecase.dart';
import '../repositories/class_year_repository.dart';

class GetClassYearsUseCase
    extends UseCase<Either<Failure, List<ClassYear>>, NoParams> {
  final IClassYearRepository repository;
  GetClassYearsUseCase(this.repository);
  @override
  Future<Either<Failure, List<ClassYear>>> call({NoParams? p}) async {
    return await repository.getClassYear();
  }
}
