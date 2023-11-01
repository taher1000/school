import 'package:flutter_bloc/flutter_bloc.dart';

import '../enums/request_status.dart';
import '../params/pagination_params.dart';
import '../uscecase/usecase.dart';

abstract class FetchDataWithPagination {
  final UseCase useCase;
  final dynamic state;

  FetchDataWithPagination({required this.useCase, required this.state});
  Future<void> getData({
    required bool isRefresh,
    required Emitter emit,
    required RequestStatus requestStatus,
    required bool hasReachedMax,
    required List list,
    required PaginationParameters firstFetchParams,
    required PaginationParameters secondFetchParams,
  });
}
