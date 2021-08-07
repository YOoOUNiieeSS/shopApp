import 'package:shop_app/models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}
class ShopRegisterLoadingState extends ShopRegisterStates {}
class ShopRegisterSuccessState extends ShopRegisterStates {
  ShopLoginModel shopLoginModel;
  ShopRegisterSuccessState(this.shopLoginModel);
}
class ShopRegisterErrorState extends ShopRegisterStates {
  String error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangePrefixVisibilityState extends ShopRegisterStates {}
