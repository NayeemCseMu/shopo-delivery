import 'package:dartz/dartz.dart';
import 'package:shopo_delivery/core/error/failure.dart';
import 'package:shopo_delivery/modules/profile/model/profile_model.dart';
import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';

abstract class ProfileRepository {
  Future<Either<Failure, DeliveryManProfile>> fetchProfileInfo(String token);
  Future<Either<dynamic, String>> profileUpdate(
    DeliveryMan deliveryMan,
    String token,
  );
}

class ProfileRepositoryImpl extends ProfileRepository {
  final RemoteDataSource remoteDataSources;

  ProfileRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, DeliveryManProfile>> fetchProfileInfo(
      String token) async {
    try {
      final result = await remoteDataSources.deliveryManProfileInfo(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> profileUpdate(
    DeliveryMan deliveryMan,
    String token,
  ) async {
    try {
      final result = await remoteDataSources.profileUpdate(deliveryMan, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
