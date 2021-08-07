import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared_1/network/end_points.dart';
import 'package:shop_app/shared_1/network/remote/dio_helper.dart';

import 'register_states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  late ShopLoginModel shopRegisterModel;

  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email':email,
      'password':password,
      'name':name,
      'phone':phone
    }).then((value) {
      shopRegisterModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(shopRegisterModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error));
    });
  }

  bool isPassword=true;
  IconData visibilityIcon=Icons.visibility_outlined;
  void changePrefixVisibility(){
    isPassword=!isPassword;
    visibilityIcon=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterChangePrefixVisibilityState());
  }
}