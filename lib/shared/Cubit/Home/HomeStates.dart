abstract class HomeStates{}

class InitialShopState extends HomeStates{}

class NavBottom extends HomeStates{}

class ShopSuccessState extends HomeStates{}
class ShopErrorState extends HomeStates{
  final error;

  ShopErrorState(this.error);
}
class CategoriesSuccessState extends HomeStates{}
class CategoriesErrorState extends HomeStates{
  final error;

  CategoriesErrorState(this.error);
}
class FavoritesSuccessState extends HomeStates{}
class FavoritesErrorState extends HomeStates{
  final error;

  FavoritesErrorState(this.error);
}
class ShopLoadingState extends HomeStates{}
class IconChangeState extends HomeStates{}
class IconErrorChangeState extends HomeStates{}

class FavoriteSucessState extends HomeStates{}
class FavoriteLoadingState extends HomeStates{}
class FavoriteErrorState extends HomeStates{}

class CartSucessState extends HomeStates{}
class CartIconSucessState extends HomeStates{}
class CartIconErrorState extends HomeStates{}
class CartLoadingState extends HomeStates{}
class CartErrorState extends HomeStates{}

class GetCartSucessState extends HomeStates{}
class GetCartLoadingState extends HomeStates{}
class GetCartErrorState extends HomeStates{}

class GetProfileSucessState extends HomeStates{}
class GetProfileLoadingState extends HomeStates{}
class GetProfileErrorState extends HomeStates{}

class UpdateProfileSucessState extends HomeStates{}
class UpdateProfileLoadingState extends HomeStates{}
class UpdateProfileErrorState extends HomeStates{}

class UpdatePasswordSucessState extends HomeStates{}
class UpdatePasswordLoadingState extends HomeStates{}
class UpdatePasswordErrorState extends HomeStates{}

class PruductSucessState extends HomeStates{}
class PruductLoadingState extends HomeStates{}
class PruductErrorState extends HomeStates{}
