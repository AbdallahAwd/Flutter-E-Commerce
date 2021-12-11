import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/passwordModel.dart';
import 'package:learning/models/shopmodel/shopmodel.dart';
import 'package:learning/shared/Cubit/logIn/shoploginstate.dart';
import 'package:learning/layout/end_point.dart';
import 'package:learning/shared/networking/remote/DioHelper.dart';

class LoginCubit extends Cubit<ShopLoginStates>
{
  LoginCubit() : super(initialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userLogin({@required email ,@required password })
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data:
    {
      'email':email,
      'password':password,
    }).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((onError)
    {
      print('Errrrrrrrrrror !!!!! ${onError.toString()}');
      emit(ShopLoginErroeState(onError));
    });
  }
  bool isAppear = true;
  IconData suffix = Icons.visibility_outlined;
  void chanegIcon()
  {
    isAppear = !isAppear;
    isAppear ? suffix = Icons.visibility_outlined : suffix = Icons.visibility_off_rounded;
    emit(ChangeIcon());
  }

  ChangePasswordModel changePasswordModel;
  void verifyEmail(String email)
  {
    emit(ResetLoadingState());
    DioHelper.postData(url: VERIFY_CODE, data: {
      'email' : email,
    }).then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);
      emit(ResetSucessState(changePasswordModel));
    }).catchError((onError){
      print(onError.toString());
      emit(ResetErrorState());
    });
  }
  ChangePasswordModel _changePasswordModel;

  void resetPassword({
    @ required String email,
    @ required String code,
    @ required String password,
  })
  {
    emit(ResetPLoadingState());
    DioHelper.postData(
        url: RESET_PASSWORD,
        data: {
      'email' : email,
      'code' : code,
      'password' : password,
       }).then((value) {
      _changePasswordModel = ChangePasswordModel.fromJson(value.data);
      print(_changePasswordModel.message);
      emit(ResetPSucessState(_changePasswordModel));
    }).catchError((onError){
      print(onError.toString());
      emit(ResetPErrorState());
    });
  }
}