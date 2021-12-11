import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/shopmodel/shopmodel.dart';
import 'package:learning/shared/Cubit/Register/registerStates.dart';
import 'package:learning/layout/end_point.dart';
import 'package:learning/shared/networking/remote/DioHelper.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(InitialState());
 static RegisterCubit get(context) => BlocProvider.of(context);

  var registerModel;

  void userRegister({
  @required String name,
  @required String email,
  @required String phone,
  @required String password,
  })
  {
    emit(LoadingState());
    DioHelper.postData(url: REGISTER, data:
    {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      print(value.data);
      registerModel = ShopLoginModel.fromJson(value.data);
      emit(SucessState(registerModel));
    }).catchError((onError)
    {
      print('Errrrrrrrrror is $onError');
      emit(ErrorState(onError));
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
}