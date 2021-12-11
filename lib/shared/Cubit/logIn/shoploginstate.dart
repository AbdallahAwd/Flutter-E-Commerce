import 'package:learning/models/passwordModel.dart';
import 'package:learning/models/shopmodel/shopmodel.dart';

abstract class ShopLoginStates {}

class initialState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates
{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginLoadingState extends ShopLoginStates{}
class ChangeIcon extends ShopLoginStates{}
class ShopLoginErroeState extends ShopLoginStates{
  final error;

  ShopLoginErroeState(this.error);
}


class InitialState extends ShopLoginStates{}

class ChangeIcon2 extends ShopLoginStates{}

class SucessState extends ShopLoginStates{
  final registerModel;

  SucessState(this.registerModel);
}
class ErrorState extends ShopLoginStates{
  final Error;

  ErrorState(this.Error);
}
class LoadingState extends ShopLoginStates{}


class ResetSucessState extends ShopLoginStates{
  ChangePasswordModel changePasswordModel;

  ResetSucessState( this.changePasswordModel);
}
class ResetErrorState extends ShopLoginStates{}
class ResetLoadingState extends ShopLoginStates{}

class ResetPSucessState extends ShopLoginStates{
  ChangePasswordModel changePasswordModel;

  ResetPSucessState( this.changePasswordModel);
}
class ResetPErrorState extends ShopLoginStates{}
class ResetPLoadingState extends ShopLoginStates{}
