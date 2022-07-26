import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:advanced_flutter_arabic/data/network/dio_factory.dart';
import 'package:advanced_flutter_arabic/data/network/requstes/forgot_password_request.dart';
import 'package:advanced_flutter_arabic/data/network/requstes/register_request.dart';
import 'package:advanced_flutter_arabic/data/repository/local_repo.dart';
import 'package:advanced_flutter_arabic/domain/model/forgetpassword.dart';
import 'package:advanced_flutter_arabic/domain/model/home.dart';
import 'package:advanced_flutter_arabic/domain/model/homeDetails.dart';
import 'package:advanced_flutter_arabic/domain/model/models.dart';
import 'package:advanced_flutter_arabic/data/network/failure.dart';
import 'package:advanced_flutter_arabic/domain/model/notification.dart';
import 'package:advanced_flutter_arabic/domain/repository/api_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../domain/repository/local_repo.dart';
import '../network/error_handler.dart';
import '../network/requstes/login_request.dart';

class RepositoryImpl extends Repository {
  bool? result;
  final LocalDataSource _localDataSourceImpl = LocalDataSourceImpl();
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    result = await InternetConnectionChecker().hasConnection;

    if (result ?? false) {
      try {
        print(loginRequest.toJson());
        var response = await DioFactory.postdata(
            url: Constants.login, data: loginRequest.toJson());
        print(response.statusCode);
        if (response.statusCode == ResponseCode.SUCCESS) {
          return Right(Authentication.fromMap(response.data));
        } else {
          return Left(ErrorHandler.handle(response.statusCode).failure);
        }
      } catch (error) {
        print('object');
        print(error.toString());

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      print(DataSource.NO_INTERNET_CONNECTION.getFailure().message);
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordModel>> resetPassword(
      ForgotPasswordRequset forgotPasswordRequset) async {
    try {
      var response = await DioFactory.postdata(
          url: Constants.forgotPassword, data: forgotPasswordRequset.toJson());
      if (response.statusCode == ResponseCode.SUCCESS) {
        return Right(ForgotPasswordModel.fromMap(response.data));
      } else {
        return Left(ErrorHandler.handle(response.statusCode).failure);
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    try {
      print(registerRequest.toJson());
      var response = await DioFactory.postdata(
          url: Constants.register, data: registerRequest.toJson());

      if (response.statusCode == ResponseCode.SUCCESS) {
        return Right(Authentication.fromJson(response.data));
      } else {
        return Left(ErrorHandler.handle(response.statusCode).failure);
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Home>> getHome() async {
    try {
      var response = _localDataSourceImpl.getHomeData();
      print('an hnaaa');
      return Right(response);
    } catch (e) {
      var response = await DioFactory.getdata(url: Constants.home);
      try {
        if (response.statusCode == ResponseCode.SUCCESS) {
          _localDataSourceImpl.saveHomeToCache(Home.fromMap(response.data));
          return Right(Home.fromMap(response.data));
        } else {
          return left(ErrorHandler.handle(response.statusCode).failure);
        }
      } catch (cacheError) {
        return left(ErrorHandler.handle(cacheError).failure);
      }
    }
  }

  @override
  Future<Either<Failure, HomeDetailsModel>> getHomeDetails() async {
    try {
      var response = _localDataSourceImpl.getHomeDetailsData();

      print('wassssssssl');
      return Right(response);
    } catch (e) {
      try {
        var response = await DioFactory.getdata(url: Constants.homeDetails);
        if (response.statusCode == ResponseCode.SUCCESS) {
          _localDataSourceImpl
              .saveHomeDetailsToCache(HomeDetailsModel.fromJson(response.data));
          return right(HomeDetailsModel.fromJson(response.data));
        } else {
          return left(ErrorHandler.handle(response.statusCode).failure);
        }
      } catch (cacheError) {
        return left(ErrorHandler.handle(cacheError).failure);
      }
    }
  }

  @override
  Future<Either<Failure, NotificationModel>> getNotification() async {
    try {
      var response = _localDataSourceImpl.getNotificationData();

      return Right(response);
    } catch (e) {
      try {
        var response = await DioFactory.getdata(url: Constants.notifications);
        if (response.statusCode == ResponseCode.SUCCESS) {
          _localDataSourceImpl.saveNotificationToCache(
              NotificationModel.fromJson(response.data));
          return right(NotificationModel.fromJson(response.data));
        } else {
          return left(ErrorHandler.handle(response.statusCode).failure);
        }
      } catch (cacheError) {
        return left(ErrorHandler.handle(cacheError).failure);
      }
    }
  }
}
