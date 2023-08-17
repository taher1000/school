import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/class_year.dart';

import '../../../../core/network/failure.dart';
import '../../domain/repositories/class_year_repository.dart';
import '../datasources/class_year_datasource.dart';
import '../models/class_year.dart';

class ClassYearRepositoryImpl extends IClassYearRepository {
  final IClassYearRemoteDataSource remoteDataSource;

  ClassYearRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ClassYear>>> getClassYear() async {
    try {
      var response = await remoteDataSource.getClassYear();
      if (response.errors!.isEmpty && response.succeeded!) {
        final classYearsList = List<ClassYearModel>.from(
            response.data!.map((x) => ClassYearModel.fromJson(x)));
        return Right(classYearsList);
      } else {
        return Left(Failure(message: response.message!));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }
}
