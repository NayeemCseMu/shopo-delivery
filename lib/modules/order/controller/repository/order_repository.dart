import 'package:dartz/dartz.dart';
import 'package:shopo_delivery/modules/order/model/order_details_model.dart';
import '../../../dashboard/model/order_model.dart';

import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> getRequestOrders(String token);
  Future<Either<Failure, List<OrderModel>>> getRunningOrders(String token);
  Future<Either<Failure, List<OrderModel>>> getCompleteOrders(String token);
  Future<Either<Failure, OrderDetailsModel>> orderDetails(
      String id, String token);

  Future<Either<Failure, String>> orderRequestUpdate(
      String id, Map<String, String> map, String token);
  Future<Either<Failure, String>> orderRunningUpdate(
      String id, Map<String, String> map, String token);
}

class OrderRepositoryImpl implements OrderRepository {
  final RemoteDataSource remoteDataSources;

  OrderRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, List<OrderModel>>> getRequestOrders(
      String token) async {
    try {
      final result = await remoteDataSources.getRequestOrders(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getRunningOrders(
      String token) async {
    try {
      final result = await remoteDataSources.getRunningOrders(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getCompleteOrders(
      String token) async {
    try {
      final result = await remoteDataSources.getCompletedOrders(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, OrderDetailsModel>> orderDetails(
      String id, String token) async {
    try {
      final result = await remoteDataSources.getOrderDetails(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> orderRequestUpdate(
      String id, Map<String, String> map, String token) async {
    try {
      final result = await remoteDataSources.orderRequestUpdate(id, map, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> orderRunningUpdate(String id, Map<String, String> map, String token) async{
    try {
      final result = await remoteDataSources.orderRunningUpdate(id, map, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
