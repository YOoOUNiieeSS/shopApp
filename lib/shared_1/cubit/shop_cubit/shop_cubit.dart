import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/favourites_screen/favourites_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared_1/components/constants.dart';
import 'package:shop_app/shared_1/cubit/shop_cubit/shop_states.dart';
import 'package:shop_app/shared_1/network/end_points.dart';
import 'package:shop_app/shared_1/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  List<Widget> bottomScreens=[
    HomeScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];
  int currentIndex=0;
  void changeBottomNavBar(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int,bool> favorites={};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
      token: token!
    ).then((value){
      homeModel=HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((product) {
        favorites.addAll({product.id!:product.inFavorites!});
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoryModel? categoryModel;
  void getCategoriesData(){
    DioHelper.getData(
        url: GET_CATEGORIES,
        token: token!
    ).then((value){
      categoryModel=CategoryModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    favorites[productId]=!favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId
        },
      token: token!
    ).then((value){
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status!){favorites[productId]=!favorites[productId]!;}
      else getFavData();
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      favorites[productId]=!favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavData(){
    emit(ShopLoadingFavoritesDataState());
    DioHelper.getData(
        url: FAVORITES,
        token: token!,
    ).then((value){
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(ShopSuccessFavoritesDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorFavoritesDataState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token!
    ).then((value){
      userModel=ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
  }){
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token!,
        data:{
          'name':name,
          'phone':phone,
          'email':email
        }
    ).then((value){
      userModel=ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}