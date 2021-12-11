import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/shared/Cubit/Home/HomeCubit.dart';
import 'package:learning/shared/Cubit/logIn/loginCubit.dart';
import 'package:learning/shared/compnents/constants.dart';
import 'package:learning/shared/networking/lacal/cacheHelper.dart';
import 'package:learning/shared/networking/remote/DioHelper.dart';
import 'layout/shoplayout.dart';
import 'modules/shopApp/introduction_screen/introductionScreen.dart';
import 'modules/shopApp/login/login.dart';
import 'shared/block_observer.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
   DioHelper.init();
   await CacheHelper.init();

   bool isDark = CacheHelper.getData(key: 'isDark');

   bool onBoarding = CacheHelper.getData(key: 'onBoarding');

   Token = CacheHelper.getData(key: 'Token');

   print(Token);

  Bloc.observer = MyBlocObserver();
  runApp(MyApp(isDark ,onBoarding ,Token));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isDark;
  final bool onBoarding;
  final String Token;


  MyApp(this.isDark , this.onBoarding , this.Token);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => HomeCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getCartsData()..getProfileData()..getProductData(),),
        BlocProvider(
        create: (BuildContext context) => LoginCubit()),
      ],
      child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              home: home(onBoarding ,Token) ,
            ),
    );


  }
}

Widget home(onBoarding , token)
{
  if(onBoarding == true && token != null ) return ShopLayout();
  if(onBoarding == true &&  token == null) return LogInScreen();
  return OnBoardingScreen();
}