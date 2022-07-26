import 'package:advanced_flutter_arabic/data/network/failure.dart';
import 'package:advanced_flutter_arabic/data/network/requstes/forgot_password_request.dart';
import 'package:advanced_flutter_arabic/data/network/requstes/register_request.dart';
import 'package:advanced_flutter_arabic/domain/model/home.dart';
import 'package:advanced_flutter_arabic/domain/model/homeDetails.dart';
import 'package:advanced_flutter_arabic/domain/model/models.dart';
import 'package:advanced_flutter_arabic/domain/model/notification.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/requstes/login_request.dart';
import '../model/forgetpassword.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, ForgotPasswordModel>> resetPassword(
      ForgotPasswordRequset forgotPasswordRequset);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, Home>> getHome();
  Future<Either<Failure, HomeDetailsModel>> getHomeDetails();
  Future<Either<Failure, NotificationModel>> getNotification();
}
