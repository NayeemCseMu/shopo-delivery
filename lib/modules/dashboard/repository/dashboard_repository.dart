import 'package:dartz/dartz.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';

import '../model/dashboard_model.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardModel>> getDashboardData(String token);
}

class DashboardRepositoryImpl implements DashboardRepository {
  final RemoteDataSource remoteDataSources;

  DashboardRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, DashboardModel>> getDashboardData(String token) async {
    try {
      final result = await remoteDataSources.getDashboardData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
