import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/group_section.dart';

import '../../../../core/network/failure.dart';
import '../../domain/repositories/group_section_repository.dart';
import '../datasources/group_section_datasource.dart';
import '../models/group_section.dart';

class SectionGroupRepositoryImpl extends ISectionGroupRepository {
  final ISectionGroupRemoteDataSource remoteDataSource;

  SectionGroupRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<SectionGroup>>> getSectionGroup(
      int classYear) async {
    try {
      var response = await remoteDataSource.getSectionGroup(classYear);
      if (response.errors!.isEmpty && response.succeeded!) {
        final sectionGroupsList = List<SectionGroupModel>.from(
            response.data!.map((x) => SectionGroupModel.fromJson(x)));
        return Right(sectionGroupsList);
      } else {
        return Left(Failure(message: response.message!));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }
}
