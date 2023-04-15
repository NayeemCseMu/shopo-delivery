
import 'package:dartz/dartz.dart';
import '../../../core/data/datasources/local_data_source.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../models/set_password_model.dart';
import '../models/user_login_response_model.dart';

abstract class AuthRepository {
  Future<Either<dynamic, UserLoginResponseModel>> login(Map<String, dynamic> body);

  Either<Failure, UserLoginResponseModel> getCashedUserInfo();

  Future<Either<dynamic, String>> signUp(Map<String, dynamic> body);

  Future<Either<dynamic, String>> sendForgotPassCode(Map<String, dynamic> body);

  Future<Either<dynamic, String>> setPassword(SetPasswordModel body);

  Future<Either<Failure, String>> sendActiveAccountCode(String email);

  Future<Either<Failure, String>> activeAccountCodeSubmit(String code);

  Future<Either<Failure, String>> logOut(String token);
}

class AuthRepositoryImp extends AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  AuthRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<dynamic, UserLoginResponseModel>> login(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.signIn(body);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch(e){
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> logOut(String token) async {
    try {
      final result = await remoteDataSource.logOut(token);
      localDataSource.clearUserProfile();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Either<Failure, UserLoginResponseModel> getCashedUserInfo() {
    try {
      final result = localDataSource.getUserResponseModel();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<dynamic, String>> signUp(Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.userRegister(body);
      return Right(result);
    } on InvalidAuthData catch (e) {
    return Left(InvalidAuthData(e.errors));
    }on ServerException catch(e){
      return Left(ServerFailure(e.message,e.statusCode));
    }

  }

  @override
  Future<Either<dynamic, String>> sendForgotPassCode(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.sendForgotPassCode(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> setPassword(SetPasswordModel body) async {
    try {
      final result = await remoteDataSource.setPassword(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> sendActiveAccountCode(String email) async {
    try {
      final result = await remoteDataSource.sendActiveAccountCode(email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> activeAccountCodeSubmit(String code) async {
    try {
      final result = await remoteDataSource.activeAccountCodeSubmit(code);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
