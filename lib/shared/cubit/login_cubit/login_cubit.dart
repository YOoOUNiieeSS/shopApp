import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/login_cubit/login_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }){
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email':email,
      'password':password,
    }).then((value) {
      print(value.data);
      emit(ShopLoginSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error));
    });
  }

  bool isPassword=false;
  IconData visibilityIcon=Icons.visibility_outlined;
  void changePrefixVisibility(){
    isPassword=!isPassword;
    visibilityIcon=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePrefixVisibilityState());
  }
}