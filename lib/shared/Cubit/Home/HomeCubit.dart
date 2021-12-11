import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/ProductModel.dart';
import 'package:learning/models/passwordModel.dart';
import 'package:learning/models/shopmodel/CartGetModel.dart';
import 'package:learning/models/shopmodel/CategoriesModel.dart';
import 'package:learning/models/shopmodel/FavModel.dart';
import 'package:learning/models/shopmodel/FavoritesModel.dart';
import 'package:learning/models/shopmodel/cartModel.dart';
import 'package:learning/models/shopmodel/homeModel.dart';
import 'package:learning/models/shopmodel/shopmodel.dart';
import 'package:learning/modules/Home/Home.dart';
import 'package:learning/modules/Settings/Settings.dart';
import 'package:learning/modules/categories/categories.dart';
import 'package:learning/modules/favourites/favourites.dart';
import 'package:learning/shared/Cubit/Home/HomeStates.dart';
import 'package:learning/shared/compnents/constants.dart';
import 'package:learning/layout/end_point.dart';
import 'package:learning/shared/networking/remote/DioHelper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialShopState());

  static HomeCubit get(context) => BlocProvider.of(context);

  Map <int, bool> favourites = {};
  Map<int , bool> cart ={};
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home_outlined),
    ),
    BottomNavigationBarItem(
      label: 'Categories',
      icon: Icon(Icons.category_outlined),
    ),
    BottomNavigationBarItem(
      label: 'Favorites',
      icon: Icon(Icons.favorite_outline_rounded),
    ),
    BottomNavigationBarItem(
      label: 'Settings',
      icon: Icon(Icons.settings),
    ),
  ];
  int currentIndex = 0;

  void changeNav(index) {
    currentIndex = index;
    emit(NavBottom());
  }

  HomeModel homeModel;

  void getHomeData() {
    emit(ShopLoadingState());
    DioHelper.getData(
      url: HOME,
      Token: Token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
       print(homeModel.data.products[0]);
      homeModel.data.products.forEach((element) {
        favourites.addAll(
            {
              element.id: element.in_favorites,
            }
        );
      });
      homeModel.data.products.forEach((element) {
        cart.addAll({
          element.id : element.inCart
        });
      });
     // print(favourites.toString());
     //  print(cart.toString());
      emit(ShopSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorState(onError.toString()));
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: CATEGORIES,
      Token: Token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel.status);
      print('ssssssssssssss ${productDetailsModel.data.id}');
      emit(CategoriesSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(CategoriesErrorState(onError));
    });
  }
  ChangeFavoritesModel changefavoritesModel;
  void changeFavoritesData(int product_id)
  {
    favourites[product_id] = !favourites[product_id];
    emit(IconChangeState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : product_id,
        },
        Token: Token,
    ).then((value) {
      changefavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // print(value.data);
      if(!changefavoritesModel.status){
        favourites[product_id] = !favourites[product_id];
        emit(IconErrorChangeState());
      } else
        {
          getFavoritesData();
        }
      emit(FavoritesSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(FavoritesErrorState(onError.toString()));
    });
  }

  FavoritesModel favoritesModel;
  FavoritesData favoritesData;

  void getFavoritesData() {
    emit(FavoriteLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      Token: Token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      favoritesData = FavoritesData.fromJson(value.data);
      // print(value.data);
      emit(FavoriteSucessState());
    }).catchError((onError) {
      print(onError);
      emit(FavoriteErrorState());
    });
  }
  ChangeCartModel changeCartModel;
  void changeCartmodel(int product_id)
  {
    cart[product_id] = ! cart[product_id];
    emit(CartIconSucessState());
    DioHelper.postData(
        url: CARTS,
        data: {
          'product_id':product_id
        } ,
        Token: Token
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      // print(value.data);
      if(!changeCartModel.status)
      {
        cart[product_id] = ! cart[product_id];
        emit(CartIconErrorState());
      } else
       {
         getCartsData();
       }
      emit(CartSucessState());
    }).catchError((onError){
      print(onError.toString());
      emit(CartErrorState());
    });
  }
  GetCartModel cartModel;

  void getCartsData() {
    emit(GetCartLoadingState());
    DioHelper.getData(
      url: CARTS,
      Token: Token,
    ).then((value) {
      cartModel = GetCartModel.fromJson(value.data);
      print(cartModel.data.data[0]);
      emit(GetCartSucessState());
    }).catchError((onError) {
      print(onError);
      emit(GetCartErrorState());
    });
  }
  ShopLoginModel userData;

  void getProfileData() {
    emit(GetProfileLoadingState());
    DioHelper.getData(
      url: PROFILE,
      Token: Token,
    ).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      // print(userData.date.name);
      emit(GetProfileSucessState());
    }).catchError((onError) {
      print(onError);
      emit(GetProfileErrorState());
    });
  }

  void updateUserData({
  @required String name,
  @required String email,
  @required String phone,
})
  {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        data: {
        'name':name,
        'email':email,
        'phone':phone,
          } , Token: Token).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      emit(UpdateProfileSucessState());
    }).catchError((onError){
      print(onError.toString());
      emit(UpdateProfileErrorState());
    });
  }

  ChangePasswordModel changePasswordModel;
  void postPasswordData({
    @required String currentPassword ,
    @required String newPassword})
  {
    emit(UpdatePasswordLoadingState());
    DioHelper.postData(
        url: CHANGE_PASSWORD,
        Token: Token,
        data:
    {
      'current_password':currentPassword,
      'new_password':newPassword,
    }).then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);
     // print(changePasswordModel.message);
      emit(UpdatePasswordSucessState());
    }).catchError((onError){
      print(onError.toString());
      emit(UpdatePasswordErrorState());
    });
  }

  ProductDetailsModel productDetailsModel;
  void getProductData() {
    emit(PruductLoadingState());
    DioHelper.getData(
      url: PRODUCT_DETAILS,
      Token: Token,
    ).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);

      // print(value.data);
      emit(PruductSucessState());
    }).catchError((onError) {
      print(onError);
      emit(PruductErrorState());
    });
  }
}
